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
package ai.koryki.northwind.fixture;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.jupiter.api.Test;

/**
 * The two columns that hold the same branches, a native list of structs and a JSON array, are only
 * a test of anything if they answer every question the same way. The same question goes to both
 * ({@code select_branches} and {@code select_branches_json}), so their results must be one and the
 * same file: a difference means a selector reads one storage differently from the other.
 */
class NestedTwinsTest {

    private static final Path CSV =
            Path.of("src/main/resources/ai/koryki/fixture/expected/kql/nested/csv");

    @Test
    void aSelectorOnAJsonArrayAnswersLikeOneOnANativeList() throws IOException {
        assertEquals(
                Files.readString(CSV.resolve("select_branches.csv")),
                Files.readString(CSV.resolve("select_branches_json.csv")));
        assertEquals(
                Files.readString(CSV.resolve("select_branches.json")),
                Files.readString(CSV.resolve("select_branches_json.json")));
    }
}
