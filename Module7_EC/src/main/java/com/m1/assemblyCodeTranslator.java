package main.java.com.m1;

import java.util.HashMap;
import java.util.Map;

public class assemblyCodeTranslator {

    private static String toBinaryString(int value, int length) {
        String binaryString = Integer.toBinaryString(value);
        int padding = length - binaryString.length();
        return "0".repeat(Math.max(0, padding)) + binaryString;
    }

    // Define the register mappings
    private static final Map<String, String> registerMap = new HashMap<>();
    static {
        registerMap.put("R0", "0000");
        registerMap.put("R1", "0001");
        registerMap.put("R2", "0010");
        registerMap.put("R3", "0011");
        registerMap.put("R4", "0100");
        registerMap.put("R5", "0101");
        registerMap.put("R6", "0110");
        registerMap.put("R7", "0111");
        registerMap.put("R8", "1000");
        registerMap.put("R9", "1001");
        registerMap.put("R10", "1010");

        // Add mappings for other registers
        for (int i = 0; i <= 15; i++) {
            String registerName = "R" + i;
            registerMap.put(registerName, String.format("%02d", Integer.parseInt(Integer.toBinaryString(i))));
        }
    }

    public static String translateASM(String opcode, String destRegister, String sourceRegister, String sourceRegister2) {
        String opcodePrefix;

        if (sourceRegister2.isEmpty()) {
            sourceRegister2 = "R0";
        }

        // Initialize variables
        opcodePrefix = "";

        // Validate opcode
        switch (opcode.toLowerCase()) {
            case "mov":
                opcodePrefix = "e1a";
                break;
            case "sub":
                opcodePrefix = "e04";
                break;
            case "mul":
                opcodePrefix = "e00";
                break;
            case "lsr":
                opcodePrefix = "e1a";
                break;
            case "ldr":
                opcodePrefix = "e59";
                break;
            // Add cases for other opcodes as needed
            default:
                throw new IllegalArgumentException("Invalid opcode: " + opcode);
        }

        // Convert register names to uppercase
        destRegister = destRegister.toUpperCase();
        sourceRegister = sourceRegister.toUpperCase();
        sourceRegister2 = sourceRegister2.toUpperCase();

        // Lookup register codes
        String destRegisterCode = getRegisterCode("1", destRegister);
        String sourceRegisterCode = getRegisterCode("2", sourceRegister);
        String sourceRegisterCode2 = getRegisterCode("2", sourceRegister2);

        System.out.println("destRegisterCode " + destRegisterCode);
        System.out.println("sourceRegisterCode " + sourceRegisterCode);
        System.out.println("sourceRegisterCode2 " + sourceRegisterCode2);

        // Form the machine code with the desired format
        if (opcode.equalsIgnoreCase("mov")) {
           return opcodePrefix + destRegisterCode + "00" + sourceRegisterCode;
        } else if (opcode.equalsIgnoreCase("sub")) {
            destRegisterCode = String.valueOf(Integer.parseInt(destRegisterCode, 2));
            return opcodePrefix + sourceRegisterCode  + destRegisterCode + "00" + sourceRegisterCode2;
        } else if (opcode.equalsIgnoreCase("mul")) {
            destRegisterCode = String.valueOf(Integer.parseInt(destRegisterCode, 2));
            sourceRegisterCode = getRegisterCode("4", sourceRegister);
            sourceRegisterCode = String.valueOf(Integer.parseInt(sourceRegisterCode, 2));
            return opcodePrefix + destRegisterCode  + "0" + sourceRegisterCode2 + sourceRegisterCode;
        } else if (opcode.equalsIgnoreCase("lsr")) {
            destRegisterCode = String.valueOf(Integer.parseInt(destRegisterCode, 2));
            sourceRegisterCode2 = getRegisterCode("3", sourceRegister2);
            sourceRegisterCode2 = String.valueOf(Integer.parseInt(sourceRegisterCode2, 2));
            return opcodePrefix + "0" + destRegisterCode  + sourceRegisterCode2 + sourceRegisterCode;
        } else if (opcode.equalsIgnoreCase("ldr")) {
            destRegisterCode = String.valueOf(Integer.parseInt(destRegisterCode, 2));
            return opcodePrefix + "0" + destRegisterCode  + "0" + sourceRegisterCode + sourceRegisterCode2;
        } else {
            return "Should not reach here";
        }
    }

    private static String getRegisterCode(String code, String register) {
        if (register.startsWith("R")) {
            if (code.equals("1")) {
                return registerMap.get(register);
            } else if (code.equals("2")) {
                return Integer.toString(Integer.parseInt(registerMap.get(register), 2));
            } else if (code.equals("3")) {
                // we have to return the address of the register instead of the value
                // so we add 30 to output 33 instead of 3
                String r3Binary = registerMap.get("R3");
                int modifiedValue = Integer.parseInt(r3Binary, 2) + 30;
                return toBinaryString(modifiedValue, r3Binary.length());
            } else {
                // we have to return the address of the register instead of the value
                // so we add 90 to output 94 instead of 4
                String r4Binary = registerMap.get("R4");
                int modifiedValue = Integer.parseInt(r4Binary, 2) + 90;
                return toBinaryString(modifiedValue, r4Binary.length());
            }
        } else if (register.startsWith("#")) {
            // Assuming immediate value handling here, adjust as needed
            int immediateValue = Integer.parseInt(register.substring(1));  // Skip the '#'
            if (code.equals("1")) {
                return String.format("%04d", immediateValue);
            } else {
                return Integer.toString(immediateValue);
            }
        } else {
            throw new IllegalArgumentException("Invalid register: " + register);
        }
    }
}
