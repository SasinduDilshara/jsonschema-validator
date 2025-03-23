package io.ballerina.jsonschema.validator;

import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.values.BString;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.networknt.schema.JsonSchema;
import com.networknt.schema.JsonSchemaFactory;
import com.networknt.schema.SpecVersion;
import com.networknt.schema.ValidationMessage;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Set;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

public class JsonSchemaValidator {
    final static BString VALIDATION_ERROR = fromString("Validation failed");
    final static BString ERROR = fromString("Error occurred while validating the JSON");
    public static Object validate(BString jsonString, BString schemaPath) {
        try {
            // Load the JSON Schema from a file (or you can use a JSON string)
            InputStream schemaInputStream = new FileInputStream(schemaPath.toString());
            JsonSchema schema = JsonSchemaFactory.getInstance(SpecVersion.VersionFlag.V201909).getSchema(schemaInputStream);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonToValidate = mapper.readTree(jsonString.toString());

            // Validate the JSON against the schema
            Set<ValidationMessage> validationResult = schema.validate(jsonToValidate);

            // Check validation results
            if (validationResult.isEmpty()) {
                return null;
            } else {
                StringBuilder causesBuilder = new StringBuilder();
                for (ValidationMessage message : validationResult) {
                    causesBuilder.append("\n").append(message.getMessage());
                }
                return ErrorCreator.createError(VALIDATION_ERROR, fromString(causesBuilder.toString()));
            }
        } catch (Exception e) {
            return ErrorCreator.createError(ERROR);
        }
    }
}
