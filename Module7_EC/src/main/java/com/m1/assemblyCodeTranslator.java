package main.java.com.m1;

import java.util.HashMap;
import java.util.Map;

public class assemblyCodeTranslator {

// Define the opcode values for MOV instruction
    private static final String OPCODE_MOV = "0100";

    // Define the register mappings
    private static final Map<String, String> registerMap = new HashMap<>();
    static {
        registerMap.put("R0", "0000");
        registerMap.put("R1", "0001");
        registerMap.put("R2", "0010");
        // Add mappings for other registers
        for (int i = 0; i <= 15; i++) {
            String registerName = "R" + i;
            registerMap.put(registerName, String.format("%04d", Integer.parseInt(Integer.toBinaryString(i))));
        }
    }

    public static String translateMOV(String opcode, String destRegister, String sourceRegister) {
        // Validate opcode
        if (!opcode.equalsIgnoreCase("mov")) {
            throw new IllegalArgumentException("Invalid opcode: " + opcode);
        }

        // Convert register names to uppercase
        destRegister = destRegister.toUpperCase();
        sourceRegister = sourceRegister.toUpperCase();

        // Lookup register codes
        String destRegisterCode = registerMap.get(destRegister);
        String sourceRegisterCode = registerMap.get(sourceRegister);

        // Form the machine code
        return "e1a" + destRegisterCode + sourceRegisterCode + "000000000000";
    }
}
