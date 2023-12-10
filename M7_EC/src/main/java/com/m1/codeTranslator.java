package main.java.com.m1;

public class codeTranslator {
    static int opType;
    static String opCode;
    static String[] words;
    static String binaryValue;
    static String cc; // condition code
    static String ot; // opType
    static String oc; // opCode
    static String s;  // s or ls
    static String a;
    static String rn;
    static String rd;
    static String wf;
    static String ra; // rotationAmount
    static String im; // immediate
    static String sa; // shiftAmount
    static String rs;
    static String mc; // multCd
    static String st; // shiftType
    static String sr; // S/R
    static String rt;
    static String rm;
    static String tmpNumber1;
    static int tmpNumber2;
    static boolean shiftOrImm;

    public static String translateAssemblyCode(String arg1, String arg2, String arg3, String arg4) {

        // Make sure there is nothing inside of the commandString
        translatorTools.commandString.delete(0, translatorTools.commandString.length());

        if (arg4.isEmpty()) {
            arg4 = "00"; // 00 is a place-holder so the following can grep values and use toUpperCase without breaking
        }

        // Convert register names to uppercase
        arg1 = arg1.toUpperCase();
        arg2 = arg2.toUpperCase();
        arg3 = arg3.toUpperCase();
        arg4 = arg4.toUpperCase();

        System.out.println("arg1 " + arg1);
        System.out.println("arg2 " + arg2);
        System.out.println("arg3 " + arg3);
        System.out.println("arg4 " + arg4);

        cc = "1110";
        if ((arg2.substring(0, 1).equals("#"))
        || (arg3.substring(0, 1).equals("#"))
        || (arg4.substring(0, 1).equals("#"))) {
            shiftOrImm = true;
        } else {
            shiftOrImm = false;
        }

        System.out.println("arg2 substring " + arg2.substring(0, 1));
        System.out.println("arg3 substring " + arg3.substring(0, 1));
        System.out.println("arg4 substring " + arg4.substring(0, 1));

        if (arg1.equals("MOV")
        || arg1.equals("ADD")
        || arg1.equals("SUB")
        || arg1.equals("MUL")
        || arg1.equals("LSL")
        || arg1.equals("ASR")) {
            if (shiftOrImm == true) {
                ot = "001";
                sr = "0";
            } else {
                ot = "000";
                sr = "1";
            }
            if ((arg1.equals("LSL"))
            || (arg1.equals("ASR"))) {
                oc = "1101";
            }
        } else if (arg1.equals("LDR")
        || arg1.equals("STR")) {
            oc = "1100";
            if (arg1.equals("LDR")) {
                ot = "010";
                if (shiftOrImm == true) {
                    sr = "0";
                } else {
                    sr = "1";
                }
            } else if (arg1.equals("STR")) {
                if (shiftOrImm == true) {
                    ot = "010";
                    sr = "0";
                } else {
                    ot = "011";
                    sr = "1";
                }
            }

        } else {
            return "Unsupported Assembly Instruction";
        }

        if (arg1.equals("MOV")) {
            oc = "1101";
            s = "0";
            rn = "0000";
            System.out.println("rn " + rn);
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            System.out.println("rd " + rd);
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            if (shiftOrImm == true) {
                tmpNumber1 = arg3.substring(1, (arg3.length()));
                tmpNumber2 = Integer.valueOf(tmpNumber1);
                System.out.println("tmpNumber1 " + tmpNumber1);
                // process the register format
                tmpNumber2 = translatorTools.processRegisterFormat(tmpNumber2);
                System.out.println("tmpNumber2 numConverter.hexToBinary " + numConverter.hexToBinary(String.valueOf(tmpNumber2)));
                translatorTools.commandString.append(numConverter.hexToBinary(String.valueOf(tmpNumber2)));
            } else {
                translatorTools.commandString.append("00000000" + numConverter.hexToBinary(arg3.substring(1, 2)));
            }
        } else if (arg1.equals("ADD")) {
            oc = "0100";
            s = "0";
            rn = numConverter.hexToBinary(arg3.substring(1, 2));
            System.out.println("rn " + rn);
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            System.out.println("rd " + rd);
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            if ((shiftOrImm == true) && (!arg4.isEmpty())) {
                tmpNumber1 = arg4.substring(1, (arg4.length()));
                tmpNumber2 = Integer.valueOf(tmpNumber1);
                System.out.println("tmpNumber1 " + tmpNumber1);
                // process the register format
                tmpNumber2 = translatorTools.processRegisterFormat(tmpNumber2);
                System.out.println("tmpNumber2 numConverter.hexToBinary " + numConverter.hexToBinary(String.valueOf(tmpNumber2)));
                translatorTools.commandString.append(numConverter.hexToBinary(String.valueOf(tmpNumber2)));
            } else if ((shiftOrImm == false) && (!arg4.isEmpty())) {
                translatorTools.commandString.append("0000" + numConverter.hexToBinary(arg4.substring(1, 2)));
            }
        } else if (arg1.equals("SUB")) {
            oc = "0010";
            s = "0";
            rn = numConverter.hexToBinary(arg3.substring(1, 2));
            System.out.println("rn " + rn);
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            System.out.println("rd " + rd);
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            if ((shiftOrImm == true) && (!arg4.isEmpty())) {
                tmpNumber1 = arg4.substring(1, (arg4.length()));
                tmpNumber2 = Integer.valueOf(tmpNumber1);
                System.out.println("tmpNumber1 " + tmpNumber1);
                // process the register format
                tmpNumber2 = translatorTools.processRegisterFormat(tmpNumber2);
                System.out.println("tmpNumber2 numConverter.hexToBinary " + numConverter.hexToBinary(String.valueOf(tmpNumber2)));
                translatorTools.commandString.append(numConverter.hexToBinary(String.valueOf(tmpNumber2)));
            } else if ((shiftOrImm == false) && (!arg4.isEmpty())) {
                translatorTools.commandString.append("00000000" + numConverter.hexToBinary(arg4.substring(1, 2)));
            }
        } else if (arg1.equals("MUL")) {
            ot = "000";
            oc = "000";
            a = "0";
            s = "0";
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            System.out.println("rd " + rd);
            rn = "0000";
            rs = numConverter.hexToBinary(arg4.substring(1, 2));
            System.out.println("rs " + rs);
            mc = "1001";
            rm = numConverter.hexToBinary(arg3.substring(1, 2));
            System.out.println("rm " + rm);
            translatorTools.commandString.append(cc + ot + oc + a + s + rd + rn + rs + mc + rm);

        } else if (arg1.equals("LSL")) {
            s = "0";
            rn = "0000";
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            translatorTools.commandString.append(numConverter.hexToBinary(arg4.substring(1, 2)) + "000" + sr + numConverter.hexToBinary(arg3.substring(1, 2)));

        } else if (arg1.equals("ASR")) {
            s = "0";
            rn = "0000";
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            translatorTools.commandString.append(numConverter.hexToBinary(arg4.substring(1, 2)) + "010" + sr + numConverter.hexToBinary(arg3.substring(1, 2)));

        } else if (arg1.equals("LDR")) {
            s = "1";
            rn = numConverter.hexToBinary(arg3.substring(1, 2));
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            if ((shiftOrImm == true) && (!arg4.isEmpty())) {
                tmpNumber1 = arg4.substring(1, (arg4.length()));
                tmpNumber2 = Integer.valueOf(tmpNumber1);
                System.out.println("tmpNumber1 " + tmpNumber1);
                // process the register format
                tmpNumber2 = translatorTools.processRegisterFormat(tmpNumber2);
                translatorTools.commandString.append(numConverter.hexToBinary(String.valueOf(tmpNumber2)));
            } else if ((shiftOrImm == false) && (!arg4.isEmpty())) {
                translatorTools.commandString.append("00000000" + numConverter.hexToBinary(arg4.substring(1, 2)));
            } else if (arg4.isEmpty()) {
                translatorTools.commandString.append("000000000000");
            }
        } else if (arg1.equals("STR")) {
            s = "0";
            rn = numConverter.hexToBinary(arg3.substring(1, 2));
            rd = numConverter.hexToBinary(arg2.substring(1, 2));
            translatorTools.commandString.append(cc + ot + oc + s + rn + rd);
            if ((shiftOrImm == true) && (!arg4.isEmpty())) {
                tmpNumber1 = arg4.substring(1, (arg4.length()));
                tmpNumber2 = Integer.valueOf(tmpNumber1);
                System.out.println("tmpNumber1 " + tmpNumber1);
                // process the register format
                tmpNumber2 = translatorTools.processRegisterFormat(tmpNumber2);
                translatorTools.commandString.append(numConverter.hexToBinary(String.valueOf(tmpNumber2)));
            } else if ((shiftOrImm == false) && (!arg4.isEmpty())) {
                translatorTools.commandString.append("00000000" + numConverter.hexToBinary(arg4.substring(1, 2)));
            } else if (arg4.isEmpty()) {
                translatorTools.commandString.append("000000000000");
            }
        } else {
            return "Unsupported Assembly Instruction";
        }

        System.out.println("Command String " + translatorTools.commandString.toString());
        System.out.println("Hex String " + numConverter.binaryToHex(translatorTools.commandString.toString()));
        return numConverter.binaryToHex(translatorTools.commandString.toString());

    }

    public static String translateMachineCode(String mc) {
        words = new String[mc.length()];

        // Make sure there is nothing inside of the commandString
        translatorTools.commandString.delete(0, translatorTools.commandString.length());

        // Extract opcode and operands based on the ARM instruction format
        for (int i = 0; i < mc.length(); i++) {
            words[i] = mc.substring(i, i + 1);
        }
    
        translatorTools.commandString = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            System.out.println("word" + (i + 1) + " " + words[i]);
            binaryValue = numConverter.hexToBinary(words[i]);
            System.out.println("Binary representation: " + binaryValue);
            translatorTools.commandString.append(binaryValue);
        }
    
        System.out.println("machine code " + mc);
        System.out.println("Command String in Binary: " + translatorTools.commandString.toString());

        cc = translatorTools.commandString.substring(0, 4);
        ot = translatorTools.commandString.substring(4, 7);
        oc = translatorTools.commandString.substring(7, 11);
        s = translatorTools.commandString.substring(11, 12);
        rn = translatorTools.commandString.substring(12, 16);
        rd = translatorTools.commandString.substring(16, 20);
        wf = translatorTools.commandString.substring(20, 32);
        sa = translatorTools.commandString.substring(20, 25);
        st = translatorTools.commandString.substring(25, 27);
        sr = translatorTools.commandString.substring(27, 28);
        rm = translatorTools.commandString.substring(28, 32);

        System.out.println("condCode : " + cc);
        System.out.println("opType : " + ot);
        System.out.println("opCode : " + oc);
        System.out.println("s : " + s);
        System.out.println("rn : " + rn);
        System.out.println("rd : " + rd);
        System.out.println("wordFormat : " + wf);
        System.out.println("wordFormat binaryToHex : " + numConverter.binaryToHex(wf));
        System.out.println("shiftAmt : " + sa);
        System.out.println("shiftType : " + st);
        System.out.println("sr : " + sr);
        System.out.println("rm : " + rm);

        opCode = translatorTools.determineOpcode(oc);
        opType = translatorTools.determineOptype(ot);

        return translateInstruction();
    }

    public static String translateInstruction() {
        // Translate based on the immediate flag
        if (opType == translatorTools.dpOpsReg) {
            // Data Processing Operation Register Type
            System.out.println("Data Op Reg Type");
            if (opCode.equals("MOV")) {
                if (rn.equals("0000")) {
                    if (st.equals("00") && (sr.equals("0"))) {
                        if (sa.equals("00000")) {
                            return opCode + " R" + words[4] + ", R" + words[7];
                        } else {
                            return "LSL R" + words[4] + ", R" + words[7] + ", #" + numConverter.binaryToDecimal(sa);
                        }
                    } else if (st.equals("00") && (sr.equals("1"))) {
                        return "LSL R" + words[4] + ", R" + words[7] + ", R" + words[5];
                    } else {
                        return "ASR R" + words[4] + ", R" + words[7] + ", R" + words[5];
                    }
                } else {
                    return opCode + " R" + words[4] + ", R" + numConverter.binaryToDecimal(wf);
                }
            } else if (opCode.equals("AND")){
                rn = "0000"; // rn is not used so we set this to 0
                return "MUL R" + words[3] + " R" + words[7] + ", R" + words[5];
            } else {
                return opCode + " R" + words[4] + " R" + words[3] + ", R" + numConverter.binaryToDecimal(wf);
            }
        } else if (opType == translatorTools.dpOpsImm) {
            // Data Processing Operation Immediate Type
            System.out.println("Data Op Imm Type");
            if (opCode.equals("MOV")) {
                return opCode + " R" + words[4] + ", #" + numConverter.binaryToDecimal(wf);
            } else {
              return opCode + " R" + words[4] + " R" + words[3] + ", #" + numConverter.binaryToDecimal(wf);  
            }
        } else if (opType == translatorTools.lsOpsImm) {
            // Load/Store Operation Immediate
            System.out.println("rm " + rm);
            if (rm.equals("0000")) {
                return "LDR R" + words[4] + " [R" + words[3] + "]";
            } else {
                System.out.println("Load Store Op Imm");
                return "LDR R" + words[4] + " [R" + words[3] + ", #" + numConverter.binaryToDecimal(wf) + "]";
            }
        } else if (opType == translatorTools.lsOpsReg) {
            // Load/Store Operation Register
            System.out.println("Load Store Op Reg");
            return "STR R" + words[4] + " [R" + words[3] + ", R" + words[7] + "]";
        } else {
            return "opType not supported in translateInstruction";
        }
    }
}
