package main.java.com.m1;

public class machineCodeTranslator {

    public static String translateMachineCode(String machineCode) {
        // Extract relevant fields from the machine code
        char conditionCode = machineCode.charAt(3);
        System.out.println("conditionCode " + conditionCode);
        String opcodeAndOperands = machineCode.substring(3);
        System.out.println("opcodeAndOperands " + opcodeAndOperands);

        // Translate based on the condition code and opcode
        switch (conditionCode) {
            case '0':
            case '3':
            case '6':
                // Always Condition (AL)
                return translateALOpcode(opcodeAndOperands);
            // Add more cases here

            default:
                return "Unsupported condition code";
        }
    }

    public static String translateALOpcode(String opcodeAndOperands) {
        // Extract opcode and operands based on the ARM instruction format
        String opcode = opcodeAndOperands.substring(0, 4);
        String operands = opcodeAndOperands.substring(0);
        System.out.println("opcode " + opcode);
        System.out.println("operands " + operands);
        // Translate based on the opcode
        switch (opcode) {
            case "0100":
                return translateMOVInstruction(operands);
            case "0300":
                return translateMOVInstruction(operands);
            case "3700":
                return translateADDInstruction(operands);
            case "6800":
                return translateSUBInstruction(operands);
            case "3059":
                return translateMULInstruction(operands);
            case "0133":
                return translateLSRInstruction(operands);
            case "0200":
                return translateLDRInstruction(operands);
            // Add more cases
            default:
                return "Unsupported opcode";
        }
    }

    public static String translateMOVInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(1);

        System.out.println("\nimmediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(4);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(4);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        if (immediateFlag == '3') {
            // Immediate value provided
            return "MOV R" + Integer.parseInt(destinationRegister, 16) + ", #" + Integer.parseInt(sourceRegister, 16);
        } else {
            // Register to Register move
            return "MOV R" + Integer.parseInt(destinationRegister, 16) + ", R" + Integer.parseInt(immediateValue, 16);
        }
    }

    public static String translateADDInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(1);
        String addValue = operands.substring(0, 1);
        System.out.println("\nimmediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(4);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(4);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        // Register to Register move
        return "ADD R" + Integer.parseInt(destinationRegister, 16) + ", R" + Integer.parseInt(addValue, 16) + ", #" + Integer.parseInt(immediateValue, 16);
    }

    public static String translateSUBInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(1);
        String subValue = operands.substring(0, 1);
        System.out.println("\nimmediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(4);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(4);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        // Register to Register move
        return "SUB R" + Integer.parseInt(destinationRegister, 16) + ", R" + Integer.parseInt(subValue, 16) + ", R" + Integer.parseInt(immediateValue, 16);
    }

    public static String translateMULInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(1);
        String subValue = operands.substring(0, 1);
        System.out.println("\nimmediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(4);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(2, 3);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        // Register to Register move
        return "MUL R" + Integer.parseInt(subValue, 16) + ", R" + Integer.parseInt(sourceRegister, 16) + ", R" + Integer.parseInt(immediateValue, 16);
    }

    public static String translateLSRInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(1);
        System.out.println("\nimmediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(4);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(2, 3);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        // Register to Register move
        return "LSR R" + Integer.parseInt(destinationRegister, 16) + ", R" + Integer.parseInt(sourceRegister, 16) + ", R" + Integer.parseInt(immediateValue, 16);
    }

    public static String translateLDRInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(4);
        System.out.println("\nimmediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(4);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(2, 3);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        // Register to Register move
        // Translate based on the immediate flag
        if (immediateFlag == '2') {
           return "LDR R" + Integer.parseInt(destinationRegister, 16) + ", [R" + Integer.parseInt(immediateValue, 16) + ", R" + Integer.parseInt(sourceRegister, 16) + "]";
        } else {
           return "LDR R" + Integer.parseInt(destinationRegister, 16) + ", [R" + Integer.parseInt(immediateValue, 16) + ", #" + Integer.parseInt(sourceRegister, 16) + "]";
        }

    }
}
