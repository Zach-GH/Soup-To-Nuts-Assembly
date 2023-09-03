package main.java.com.m1;

public class outputHex {

    /* Takes an integer input and outputs the corresponding hex value */
    public String intToHex(int input) {
        /* Used for outputting a representation on the gui */
        StringBuilder output = new StringBuilder();
        /* Array of hex values for conversion */
        char[] hexValues = "0123456789ABCDEF".toCharArray();
        char[] hexCharacter = new char[4 * 2];
        int quotient;
        int remainder;
        int hexNumber;
        int loop = 1;
        int hexValue;

        hexNumber = input;
        quotient = hexNumber / 16; /* Initial division */
        remainder = hexNumber % 16; /* Get the remainder */
        hexValue = remainder & 0xFF;
        hexCharacter[1 * 2] = hexValues[hexValue >>> 4];
        hexCharacter[1 * 2 + 1] = hexValues[hexValue & 0x0F];

        /* Print statements used for debugging the value */
        System.out.println("The hex number is = " + hexNumber);
        System.out.println("The Quotient is = " + quotient);
        System.out.println("The Remainder is = " + remainder);

        output.append(hexCharacter[1 * 2 + 1]);
        System.out.println("output: " + output);

        /* Continue dividing until the quotient is 0 */
        /* This is the when the binary number is complete */
        while (quotient != 0) {
            hexNumber = quotient;
            quotient = hexNumber / 16;
            remainder = hexNumber % 16;
            /* Converting the remainder to base 16 for bit shifting */
            hexValue = remainder & 0xFF;
            /* Bit shift by 4 matching the corresponding array value */
            hexCharacter[1 * 2] = hexValues[hexValue >>> 4];
            /* Represents the lower four bits and translates the bit pattern */
            hexCharacter[1 * 2 + 1] = hexValues[hexValue & 0x0F];

            loop = loop + 1;
            /* Print statements used for debugging the value */
            System.out.println("loop: " + loop
                + " The Hex Number is = " + hexNumber);
            System.out.println("loop: "
                + loop + " The Quotient is = " + quotient);
            System.out.println("loop: "
                + loop + " The Remainder is = " + remainder);

            output.append(hexCharacter[1 * 2 + 1]);
            System.out.println("output: " + output);
        }
        /* assign output to the full number */
        /* reverse the final number so it is readable */
        return((output.reverse()).toString());
    }

    /* Converts inputted binary number to it's corresponding hex value */
    public String binaryToHex(String input) {
        /* Used for outputting a representation on the gui */
        String output = "";
        /* Array of hex values for conversion */
        char binaryHexChars[] = { 'A', 'B', 'C', 'D', 'E', 'F' };
        int remainder;
        int inputInteger = 0;
        Boolean inputSafe = false;
        String intChecker = input;
        int binaryToDecimal = 0;
        int i = 0;

        /* We have to intake a string so we can check binary validity */
        /* Per each character in the string */
        /* Just to be safe we also check that the input */
        /* Is a valid integer as we are converting our string input */
        /* To compute the values from Binary to Hex */
        try {
            for (i = 0; i < intChecker.length(); i++) {
                if ((intChecker.charAt(i) != '0')
                    && (intChecker.charAt(i) != '1')) {
                    System.out.println("character "
                        + intChecker.charAt(i) + " is not of binary value!");
                    inputSafe = false;
                } else {
                    inputInteger = Integer.parseInt(input);
                    inputSafe = true;
                }
            }
        } catch (NumberFormatException ne) {
            inputSafe = false;
            System.out.println(intChecker + " is not a valid integer"); 
        } 
        if (inputSafe) {
            /* Convert from binary to decimal */
            while (inputInteger > 0) {
                /* Extract each digit of the binary number */
                /* By getting the remainder of division by 10 */
                /* And multiply it by increasing integral powers by 2 */
                binaryToDecimal += Math.pow(2, i++) * (inputInteger % 10);
                System.out.println("binaryToDecimal " + binaryToDecimal);
                /* Update condition by dividing the binary by 10 */
                inputInteger /= 10;
            }
    
            /* Continue dividing until 0 */
            while (binaryToDecimal != 0) {
                /* Calculate the remainder dividing by 16 */
                remainder = binaryToDecimal % 16;
                System.out.println("\nremainder " + remainder);
                /* Check to assure we output correct hex values */
                if (remainder >= 10) {
                    output = binaryHexChars[remainder - 10] + output;
                    System.out.println("output " + output);
                } else if (remainder != 0) {
                    output = remainder + output;
                    System.out.println("output " + output);
                } else {
                    System.out.println("output was 0, negate adding");
                }
                /* Continue iterating through the loop */
                binaryToDecimal /= 16;
            }
            /* assign output of hex converted from binary */
            return(output);
        } else {
            return ("0");
        }
    }
}
