// import ballerina/io;
// import ballerina/test;

// @test:Config {
//     dataProvider: jsonSchemaDataProvider
// }
// public function testJsonSchema(int index, string[][] issues) returns error? {
//     string schemaPath = string `./tests/resources/${index}/schema.json`;
//     string validJsonPath = string `./tests/resources/${index}/valid_json.json`;
//     string invalidJsonPath = string `./tests/resources/${index}/invalid_json1.json`;
//     string invalidJsonPath2 = string `./tests/resources/${index}/invalid_json2.json`;

//     json validJson = check io:fileReadJson(validJsonPath);
//     json invalidJson = check io:fileReadJson(invalidJsonPath);
//     json invalidJson2 = check io:fileReadJson(invalidJsonPath2);

//     error? result = validate(validJson, schemaPath);
//     test:assertEquals(result, (), "Valid JSON should be validated successfully");

//     result = validate(invalidJson, schemaPath);
//     test:assertTrue(result is error, "Invalid JSON1 should not be validated successfully");
//     string msg = (<error>result).detail().toBalString();
//     issues[0].forEach(function (string issue) {
//         test:assertTrue(msg.includes(issue), "Expected issue not found in the error message for invalid1 json, message: " + msg + "\n issue: " + issue);
//     });

//     result = validate(invalidJson2, schemaPath);
//     test:assertTrue(result is error, "Invalid JSON2 should not be validated successfully: ");

//     msg = (<error>result).detail().toBalString();
//     issues[1].forEach(function (string issue) {
//         test:assertTrue(msg.includes(issue), "Expected issue not found in the error message for invalid2 json, message: " + msg + "\n issue: " + issue);
//     });
// }

// function jsonSchemaDataProvider() returns [int, string[][]][] {
//     return [
//         [
//             1, 
//             [
//                 ["$.age: string found, integer expected", "$.email: does not match the email pattern"], 
//                 ["$: required property 'name' not found", "$: required property 'age' not found", "$: required property 'email' not found"]
//             ]
//         ],
//         [
//             2, 
//             [
//                 ["$.age: must have a minimum value of 18", "$.preferences: required property 'newsletter' not found", "$.tags: must have at most 5 items but found 6"],
//                 ["$.email: does not match the email pattern", "$.profileImage: does not match content encoding base64", "$.metadata: property 'role@admin' is not defined in the schema"]
//             ]
//         ],
//         [
//             3, 
//             [
//                 ["$.contact: must be valid to one and only one schema, but 2 are valid with indexes '0, 1'", "$.age: must have a minimum value of 18", "$.auth: required property 'email' not found"],
//                 ["$.contact: must be valid to one and only one schema, but 0 are valid", ""]
//             ]
//         ],
//         [
//             4, 
//             [
//                 ["$.age: must have a minimum value of 18", "$.tags: must have at most 5 items but found 6", "$.profileImage: does not match content encoding base64"],
//                 ["$.history[0]: string found, boolean expected", "$.contact: must be valid to one and only one schema, but 0 are valid"]
//             ]
//         ]
//     ];
// }
