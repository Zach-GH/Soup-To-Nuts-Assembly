import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

public class asciiConverter {

    /* Converts an inputted ascii string to a character value */
    public String asciiToValue(String input) {
        char[] inputChars = input.toCharArray();
		List<String> inputStrings = new ArrayList<>();
        StringBuilder output = new StringBuilder();

        for (int i = 0; i < inputChars.length; i++) {
            inputStrings.add(Character.toString(inputChars[i]));
            try {
 
            /* An array of byte type is created */
            /* by using getBytes method */
            byte[] bytes = inputStrings.get(i).getBytes("US-ASCII");
 
            /* This is the ASCII value of the character */
            /* present at the '0'th index of above string. */
            System.out.println("ascii: " + inputStrings.get(i) + " hex value: " + bytes[0]);
            output.append(inputStrings.get(i) + ": " + bytes[0] + " ");

            } catch (UnsupportedEncodingException e) {
                System.out.println("Unsupported Encoding Exception!");
            }
        }
        return (output.toString());
    }

    /* Converts all inputted ascii values from lowercase to uppercase */
    public String toUpper(String input) {
        char[] inputChars = input.toCharArray();
        StringBuilder output = new StringBuilder();

        for (int i = 0; i < inputChars.length; i++) {
            if ((int)inputChars[i] >= 65) {
                if ((int)inputChars[i] >= 97) {
                    if ((int)inputChars[i] <= 122) {
                        System.out.println("\nCharacter " + inputChars[i] + " was found as lowercase at the ASCII value: " + (int)inputChars[i]);
                        System.out.println("Converting char to upperCase...");
                        inputChars[i] -= 32; /* cannot use addition or subtraction must use bitwise operators & or | */
                        System.out.println("new Char is " + inputChars[i]);
                        output.append(inputChars[i]);
                    }
                } else if ((int)inputChars[i] <= 90) {
                    System.out.println("Character " + inputChars[i] + " is already uppercase, no change needed.");
                    inputChars[i] = inputChars[i];
                    output.append(inputChars[i]);
                }
            }
            System.out.print("new ASCII Value " + (int)inputChars[i] + "\n");
            System.out.print("Output " + output + "\n");
        }
        return (output.toString());
    }

    /* Converts all inputted ascii values from uppercase to lowercase */
    public String toLower(String input) {
        char[] inputChars = input.toCharArray();
        StringBuilder output = new StringBuilder();

        for (int i = 0; i < inputChars.length; i++) {
            if ((int)inputChars[i] >= 65) {
                if ((int)inputChars[i] <= 90) {
                    System.out.println("\nCharacter " + inputChars[i] + " was found as uppercase at the ASCII value: " + (int)inputChars[i]);
                    System.out.println("Converting char to lowerCase...");
                    inputChars[i] += 32; /* cannot use addition or subtraction must use bitwise operators & or | */
                    System.out.println("new Char is " + inputChars[i]);
                    output.append(inputChars[i]);
                } else if ((int)inputChars[i] >= 97) {
                    if ((int)inputChars[i] <= 122) {
                        System.out.println("Character " + inputChars[i] + " is already lowercase, no change needed.");
                        inputChars[i] = inputChars[i];
                        output.append(inputChars[i]);
                    }
                }
            }
            System.out.print("new ASCII Value " + (int)inputChars[i] + "\n");
            System.out.print("Output " + output + "\n");
        }
        return (output.toString());
    }

}
