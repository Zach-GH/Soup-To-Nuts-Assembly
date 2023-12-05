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
            // Add more cases
            default:
                return "Unsupported opcode";
        }
    }

    public static String translateMOVInstruction(String operands) {
        // Extract relevant fields from operands
        char immediateFlag = operands.charAt(0);
        System.out.println("immediateFlag " + immediateFlag);
        String destinationRegister = operands.substring(1, 2);
        System.out.println("destinationRegister " + destinationRegister);
        String sourceRegister = operands.substring(2, 3);
        System.out.println("sourceRegister " + sourceRegister);
        String immediateValue = operands.substring(4);
        System.out.println("immediateValue " + immediateValue);

        // Translate based on the immediate flag
        if (immediateFlag == '1') {
            // Immediate value provided
            return "MOV R" + Integer.parseInt(destinationRegister, 16) + ", #" + Integer.parseInt(sourceRegister, 16);
        } else {
            // Register to Register move
            return "MOV R" + Integer.parseInt(destinationRegister, 16) + ", R" + Integer.parseInt(immediateValue, 16);
        }
    }
    
}
