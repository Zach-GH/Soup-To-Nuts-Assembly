public class outputHex {
    
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
        output.append(hexCharacter);

        /* Print statements used for debugging the value */
        System.out.println("output: " + output);
        System.out.println("The hex number is = " + hexNumber);
        System.out.println("The Quotient is = " + quotient);
        System.out.println("The Remainder is = " + remainder);
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
            /* Together the prior two statements give us the upper nibble of a byte */
            /* and is what allows a smooth conversion */
            output.append(hexCharacter);

            /* Print statements used for debugging the value */
            System.out.println("output: " + output);
            System.out.println("loop: " + loop + " The Hex Number is = " + hexNumber);
            System.out.println("loop: " + loop + " The Quotient is = " + quotient);
            System.out.println("loop: " + loop + " The Remainder is = " + remainder);
            loop = loop + 1;
        }
        /* assign output to the full number */
        return(output.toString());
    }
}
