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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;
import tools.jackson.core.JacksonException;
import tools.jackson.core.StreamReadFeature;
import tools.jackson.databind.DeserializationFeature;
import tools.jackson.databind.json.JsonMapper;

class CatalogJsonTest {

    private static final Path RESOURCES = Path.of("src/main/resources");

    /**
     * A duplicate key is legal JSON that parsers resolve differently, so the catalog must not have
     * one.
     */
    private static final JsonMapper STRICT =
            JsonMapper.builder()
                    .enable(StreamReadFeature.STRICT_DUPLICATE_DETECTION)
                    .enable(DeserializationFeature.FAIL_ON_TRAILING_TOKENS)
                    .build();

    @Test
    void everyCatalogFileIsStrictJson() throws IOException {
        List<Path> files;
        try (Stream<Path> walk = Files.walk(RESOURCES)) {
            files = walk.filter(p -> p.toString().endsWith(".json")).sorted().toList();
        }
        assertFalse(files.isEmpty(), () -> "no catalog files below " + RESOURCES.toAbsolutePath());

        List<String> problems = new ArrayList<>();
        for (Path file : files) {
            try {
                STRICT.readTree(file.toFile());
            } catch (JacksonException e) {
                problems.add(RESOURCES.relativize(file) + ": " + e.getOriginalMessage());
            }
        }
        assertTrue(
                problems.isEmpty(),
                () ->
                        problems.size()
                                + " catalog files are not strict JSON:\n  "
                                + String.join("\n  ", problems));
    }
}
