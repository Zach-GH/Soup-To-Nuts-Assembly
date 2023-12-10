package main.java.com.m1;

public class numConverter {

    public static String hexToBinary(String hexValue) {
        int decimalValue;
        String binaryString;

        decimalValue = Integer.parseInt(hexValue, 16);
        binaryString = Integer.toBinaryString(decimalValue);
        // Ensure that the binary representation always has 4 characters by left-padding with zeros
        return String.format("%4s", binaryString).replace(' ', '0');
    }
 
    public static String binaryToHex(String binaryValue) {
        if (binaryValue.length() % 4 != 0) {
            throw new IllegalArgumentException("Binary string length must be a multiple of 4");
        }

        // Split the binary string into groups of 4 characters
        int groupCount = binaryValue.length() / 4;
        String[] groups = new String[groupCount];
        for (int i = 0; i < groupCount; i++) {
            groups[i] = binaryValue.substring(i * 4, (i + 1) * 4);
        }

        // Convert each group to hexadecimal and concatenate them
        StringBuilder hexBuilder = new StringBuilder();
        for (String group : groups) {
            int decimalValue = Integer.parseInt(group, 2);
            hexBuilder.append(String.format("%01X", decimalValue));
        }

        return hexBuilder.toString();
    }

    public static int binaryToDecimal(String binaryValue) {
        int decimalValue = 0;
        int length = binaryValue.length();

        for (int i = 0; i < length; i++) {
            char digit = binaryValue.charAt(i);
            if (digit == '1') {
                decimalValue += Math.pow(2, length - 1 - i);
            } else if (digit != '0') {
                throw new IllegalArgumentException("Invalid binary character: " + digit);
            }
        }
        return decimalValue;
    }
}
