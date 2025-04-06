package io.ballerina.jsonschema.validator;

import org.apache.pdfbox.tools.TextToPDF;
import org.apache.pdfbox.pdmodel.PDDocument;
import java.io.StringReader;
import java.io.Reader;
import java.io.IOException;

public class XsdToJsonSchema {
    public static void main(String[] args) {
        String text = "This is the text content that will be converted into a PDF.\n" +
                "You can include multiple lines.\n" +
                "No need for PDPageContentStream!";

        try {
            // Create a TextToPDF converter
            TextToPDF textToPDF = new TextToPDF();

            // Convert String to Reader (not InputStream)
            Reader reader = new StringReader(text); // or use InputStreamReader with ByteArrayInputStream

            // Generate PDF document (now passing a Reader)
            PDDocument document = textToPDF.createPDFFromText(reader);

            // Save the PDF
            document.save("output_no_contentstream.pdf");
            document.close();

            System.out.println("PDF created successfully without PDPageContentStream!");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}