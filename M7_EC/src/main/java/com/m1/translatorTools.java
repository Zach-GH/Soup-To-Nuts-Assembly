package main.java.com.m1;

public class translatorTools {
    static int dpOpsReg = 1;
    static int dpOpsImm = 2;
    static int lsOpsImm = 3;
    static int lsOpsReg = 4;
    static StringBuilder commandString = new StringBuilder();

    public static int processRegisterFormat(int tmpNumber2) {
        System.out.println("tmpNumber2");
        if (tmpNumber2 < 256) {
            commandString.append("0000");
            System.out.println("tmpNumber2 " + tmpNumber2 + " is less than 256 ");
        } else {
            commandString.append("0000"); // should not happen for our example problems
            System.out.println("tmpNumber2 " + tmpNumber2 + " is greater than 256");
        }
        if (tmpNumber2 < 128) {
            commandString.append("0");
            System.out.println("tmpNumber2 " + tmpNumber2 + " is less than 128");
        } else {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is greater than 128");
            commandString.append("1");
            tmpNumber2 = tmpNumber2 - 128;
            System.out.println("tmpNumber2 is now " + tmpNumber2);
        }
        if (tmpNumber2 < 62) {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is less than 62");
            commandString.append("0");
        } else {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is greater than 62");
            commandString.append("1");
            tmpNumber2 = tmpNumber2 - 62;
            System.out.println("tmpNumber2 is now " + tmpNumber2);
        }
        if (tmpNumber2 < 32) {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is less than 32");
            commandString.append("0");
        } else {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is greater than 32");
            commandString.append("1");
            tmpNumber2 = tmpNumber2 - 32;
            System.out.println("tmpNumber2 is now " + tmpNumber2);
        }
        if (tmpNumber2 < 16) {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is less than 16");
            commandString.append("0");
        } else {
            System.out.println("tmpNumber2 " + tmpNumber2 + " is greater than 16");
            commandString.append("1");
            tmpNumber2 = tmpNumber2 - 16;
            System.out.println("tmpNumber2 is now " + tmpNumber2);
        }
        return tmpNumber2;
    }

    public static int determineOptype(String ot) {
        int opType;
        // Translate based on the opType
        switch (ot) {
            case "000":
                opType = dpOpsReg; // Data Processing Operation Register Type
                break;
            case "001":
                opType = dpOpsImm; // Data Processing Operation Immediate Type
                break;
            case "010":
                opType = lsOpsImm; // Load/Store Operation Immediate
                break;
            case "011":
                opType = lsOpsReg; // Load/Store Operation Register
                break;
            default:
                System.out.println("Unsupported OpType");
                return -1;
        }
        return opType;
    }

    public static String determineOpcode(String oc) {
        // Translate based on the opcode
        switch (oc) {
            case "0000":
                oc = "AND"; // AND
                break;
            case "0001":
                oc = "EOR"; // EOR
                break;
            case "0010":
                oc = "SUB"; // SUB
                break;
            case "0011":
                oc = "RSB"; // RSB
                break;
            case "0100":
                oc = "ADD"; // ADD
                break;
            case "1100":
                oc = "ORR"; // ORR
                break;
            case "1101":
                oc = "MOV"; // MOV or Shift
                break;
            case "1111":
                oc = "MVN"; // MVN
                break;
            default:
                return "Unsupported opCode";
        }
        return oc;
    }
}
