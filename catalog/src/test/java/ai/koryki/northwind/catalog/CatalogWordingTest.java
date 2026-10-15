/*
 * Copyright 2025-2026 Johannes Zemlin
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package ai.koryki.northwind.catalog;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.json.JsonMapper;

/**
 * Every model says in its own words what its db.json says: the label, comment and description of
 * each column, and of each part of a nested column, are in the attribute and in its members.
 * What a model leaves out is read from the schema, in the language of the schema, so a German
 * heading that shows an English word is one nobody wrote.
 *
 * <p>The same rule as {@code WordingAudit} in koryki-core, written against the JSON because this
 * repository depends on nothing of koryki: core's own {@code CatalogWordingTest} holds the shipped
 * catalogs to it once more, through the loader.
 */
class CatalogWordingTest {

    private static final Path RESOURCES = Path.of("src/main/resources");
    private static final JsonMapper JSON = JsonMapper.builder().build();
    private static final List<String> WORDS = List.of("label", "comment", "description");

    /** The db.json a model belongs to: the nearest one above it. */
    private static Path dbOf(Path model) {
        for (Path dir = model.getParent(); dir != null; dir = dir.getParent()) {
            if (Files.exists(dir.resolve("db.json"))) {
                return dir.resolve("db.json");
            }
        }
        throw new IllegalStateException("no db.json above " + model);
    }

    private static boolean said(JsonNode node, String word) {
        JsonNode value = node == null ? null : node.get(word);
        return value != null && !value.isNull() && !value.asString().isBlank();
    }

    private static void compare(String where, JsonNode schema, JsonNode model, List<String> gaps) {
        for (String word : WORDS) {
            if (said(schema, word) && !said(model, word)) {
                gaps.add(where + " " + word);
            }
        }
    }

    /** The parts of a nested column: the entries that are concepts of their own. */
    private static void parts(String where, JsonNode concept, JsonNode members, List<String> gaps) {
        JsonNode entries = concept.get("entries");
        if (entries == null) {
            return;
        }
        entries.properties().forEach(entry -> {
            if (!entry.getValue().isObject()) {
                return; // a type spelling or the name of a concept: the notion words it
            }
            JsonNode member = members == null ? null : members.get(entry.getKey());
            String path = where + "/" + entry.getKey();
            compare(path, entry.getValue(), member, gaps);
            parts(path, entry.getValue(), member == null ? null : member.get("members"), gaps);
        });
    }

    private static List<String> gapsOf(Path modelFile) throws IOException {
        JsonNode db = JSON.readTree(dbOf(modelFile).toFile());
        JsonNode model = JSON.readTree(modelFile.toFile());
        List<String> gaps = new ArrayList<>();
        for (JsonNode table : db.get("tables")) {
            String tableName = table.get("name").asString();
            JsonNode entity = null;
            for (JsonNode e : model.get("entities")) {
                String of = e.hasNonNull("table") ? e.get("table").asString() : e.get("name").asString();
                if (of.equals(tableName)) {
                    entity = e;
                }
            }
            if (entity == null) {
                continue;
            }
            for (JsonNode column : table.get("columns")) {
                JsonNode concept = column.get("concept");
                if (concept == null) {
                    continue;
                }
                String columnName = column.get("name").asString();
                JsonNode attribute = null;
                for (JsonNode a : entity.get("attributes")) {
                    String of = a.hasNonNull("column") ? a.get("column").asString() : a.get("name").asString();
                    if (of.equals(columnName)) {
                        attribute = a;
                    }
                }
                if (attribute == null) {
                    continue;
                }
                String where = tableName + "." + columnName;
                compare(where, concept, attribute, gaps);
                parts(where, concept, attribute.get("members"), gaps);
            }
        }
        return gaps;
    }

    @Test
    void everyModelLeavesNoWordToItsSchema() throws IOException {
        List<Path> models;
        try (Stream<Path> walk = Files.walk(RESOURCES)) {
            models = walk.filter(p -> p.getFileName().toString().equals("model.json")).sorted().toList();
        }
        assertFalse(models.isEmpty());

        List<String> gaps = new ArrayList<>();
        for (Path model : models) {
            for (String gap : gapsOf(model)) {
                gaps.add(RESOURCES.relativize(model) + ": " + gap);
            }
        }
        assertEquals(List.of(), gaps);
    }
}
