package main.java.com.m1;

import java.util.HashMap;
import java.util.Map;

public class assemblyCodeTranslator {

    // Define the opcode values for MOV instruction
    private static final String OPCODE_MOV = "01";

    // Define the register mappings
    private static final Map<String, String> registerMap = new HashMap<>();
    static {
        registerMap.put("R0", "00");
        registerMap.put("R1", "01");
        registerMap.put("R2", "10");
        // Add mappings for other registers
        for (int i = 0; i <= 15; i++) {
            String registerName = "R" + i;
            registerMap.put(registerName, String.format("%02d", Integer.parseInt(Integer.toBinaryString(i))));
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
        String sourceRegisterCode = Integer.toString(Integer.parseInt(registerMap.get(sourceRegister), 2));
        System.out.println("destRegisterCode " + destRegisterCode);
        System.out.println("sourceRegisterCode " + sourceRegisterCode);
        // Form the machine code with the desired format
        return "e1a" + destRegisterCode + "00" + sourceRegisterCode;
    }

}
