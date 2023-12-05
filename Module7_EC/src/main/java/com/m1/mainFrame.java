package main.java.com.m1;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Font;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

/* Main gui instantiation */
public class mainFrame extends JFrame implements ActionListener {
    static JButton assemblerBtn;
    static JButton disassemblerBtn;
    static JButton clearBtn;
    static JFrame frame;
    static JLabel assemblerLabel;
    static JLabel disassemblerLabel;
    static JTextField aTextField1;
    static JTextField aTextField2;
    static JTextField aTextField3;
    static JTextField dTextField;

	mainFrame() {
        /* Soup To Nuts */
		setTitle("M7 Extra Credit Zachary Meisner");

		/* Buttons */
		assemblerBtn = new JButton("Assemble");
		disassemblerBtn = new JButton("Disassemble");
		clearBtn = new JButton("Clear Values");

        /* JLabels */
        assemblerLabel = new JLabel("0");
		disassemblerLabel = new JLabel("0");

        /* Create text field for user input */
        aTextField1 = new JTextField(15);
        aTextField1.setDocument(new textFieldLimit(3));
        aTextField2 = new JTextField(15);
        aTextField2.setDocument(new textFieldLimit(2));
        aTextField3 = new JTextField(15);
        aTextField3.setDocument(new textFieldLimit(7));
        dTextField = new JTextField(15);
        dTextField.setDocument(new textFieldLimit(8));

        /* Create and set the font for the text field */
        Font font = new Font("Comic Sans", Font.BOLD, 20);
        aTextField1.setFont(font);
		aTextField1.setBounds(165, 20, 115, 55);
        aTextField2.setFont(font);
		aTextField2.setBounds(285, 20, 115, 55);
        aTextField3.setFont(font);
		aTextField3.setBounds(405, 20, 115, 55);
        /* JButton Bounds */
		assemblerBtn.setBounds(165, 70, 115, 55);
        dTextField.setFont(font);
		dTextField.setBounds(165, 130, 115, 55);
		disassemblerBtn.setBounds(165, 180, 115, 55);
		clearBtn.setBounds(165, 320, 115, 55);
        /* JLabel Bounds */
        assemblerLabel.setBounds(300, 70, 299, 55);
		disassemblerLabel.setBounds(300, 180, 299, 55);

        /* Button Actionlisteners */
        assemblerBtn.addActionListener(this);
        disassemblerBtn.addActionListener(this);
        clearBtn.addActionListener(this);

		/* Set up the frame with components */
        add(aTextField1);
        add(aTextField2);
        add(aTextField3);
		add(assemblerBtn);
        add(dTextField);
		add(disassemblerBtn);
		add(clearBtn);
		add(assemblerLabel);
		add(disassemblerLabel);

        /* JPanel ops to finalize output */
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLayout(null);
        pack();
		setSize(600, 500);
		setVisible(true);
	}

    /* Assign new text on each button press */
	public void actionPerformed(ActionEvent e) {
        String s = e.getActionCommand();
        /* Objects for input conversion */

        machineCodeTranslator mct = new machineCodeTranslator();

        /* Temporary variables used for buffer input */
        String aTmpText1;
        String aTmpText2;
        String aTmpText3;
        String dTmpText;

        // Ex machine code
        String machineCode = "e1a01002";

        if (s.equals("Assemble")) {
           /* Assure that whatever value entered is a string */
           aTmpText1 = aTextField1.getText().toString();
           aTmpText2 = aTextField2.getText().toString();
           aTmpText3 = aTextField3.getText().toString();

            // Translate machine code to assembly
           String asmInstruction = mct.translateMachineCode(machineCode);

           System.out.println("Machine Code: " + machineCode);
           System.out.println("Assembly Instruction: " + asmInstruction);

           assemblerLabel.setText("<html>" + asmInstruction + "</html>");

        } else if (s.equals("Disassemble")) {
           /* Assure that whatever value entered is a string */
           dTmpText = dTextField.getText().toString();

            // Translate machine code to assembly
           String asmInstruction = mct.translateMachineCode(dTmpText);
           disassemblerLabel.setText("<html>" + asmInstruction + "</html>");

        } else if (s.equals("Clear Values")) {
            assemblerLabel.setText("0");
            disassemblerLabel.setText("0");
            aTextField1.setText("");
            aTextField2.setText("");
            aTextField3.setText("");
            dTextField.setText("");
        }
    }
}

