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
    static JButton assemblerBtn, disassemblerBtn, clearBtn;
    static JFrame frame;
    static JLabel assemblerLabel, disassemblerLabel;
    static JTextField aTextField1, aTextField2, aTextField3, dTextField;

    mainFrame() {
        setTitle("M7 Extra Credit Zachary Meisner");

        assemblerBtn = createButton("Assemble");
        disassemblerBtn = createButton("Disassemble");
        clearBtn = createButton("Clear Values");

        assemblerLabel = createLabel("0");
        disassemblerLabel = createLabel("0");

        aTextField1 = createTextField(15, 165, 20);
        aTextField2 = createTextField(15, 285, 20);
        aTextField3 = createTextField(15, 405, 20);
        dTextField = createTextField(15, 165, 130);

        Font font = new Font("Comic Sans", Font.BOLD, 20);
        setFontForTextFields(font, aTextField1, aTextField2, aTextField3, dTextField);

        JLabel commaLabel = createLabel(",");
        commaLabel.setFont(font);

        commaLabel.setBounds(400, 20, 20, 80);
        assemblerBtn.setBounds(165, 70, 115, 55);
        dTextField.setBounds(165, 130, 115, 55);
        disassemblerBtn.setBounds(165, 180, 115, 55);
        clearBtn.setBounds(165, 320, 115, 55);
        assemblerLabel.setBounds(300, 70, 299, 55);
        disassemblerLabel.setBounds(300, 180, 299, 55);

        add(aTextField1);
        add(aTextField2);
        add(commaLabel);
        add(aTextField3);
        add(assemblerBtn);
        add(dTextField);
        add(disassemblerBtn);
        add(clearBtn);
        add(assemblerLabel);
        add(disassemblerLabel);

        assemblerBtn.addActionListener(this);
        disassemblerBtn.addActionListener(this);
        clearBtn.addActionListener(this);

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);
        pack();
        setSize(600, 500);
        setVisible(true);
    }

    private JButton createButton(String text) {
        JButton button = new JButton(text);
        return button;
    }

    private JLabel createLabel(String text) {
        JLabel label = new JLabel(text);
        return label;
    }

    private JTextField createTextField(int columns, int x, int y) {
        JTextField textField = new JTextField(columns);
        textField.setDocument(new textFieldLimit(columns));
        textField.setBounds(x, y, 115, 55);
        return textField;
    }

    private void setFontForTextFields(Font font, JTextField... textFields) {
        for (JTextField textField : textFields) {
            textField.setFont(font);
        }
    }

    /* Assign new text on each button press */
	public void actionPerformed(ActionEvent e) {
        String s = e.getActionCommand();
        /* Objects for input conversion */

        machineCodeTranslator mct = new machineCodeTranslator();
        assemblyCodeTranslator act = new assemblyCodeTranslator();

        /* Temporary variables used for buffer input */
        String aTmpText1;
        String aTmpText2;
        String aTmpText3;
        String dTmpText;

        if (s.equals("Assemble")) {
           /* Assure that whatever value entered is a string */
           aTmpText1 = aTextField1.getText().toString();
           aTmpText2 = aTextField2.getText().toString();
           aTmpText3 = aTextField3.getText().toString();

            // Translate machine code to assembly
           if ((!(aTextField1.getText().equals(""))) && (!(aTextField2.getText().equals(""))) && (!(aTextField3.getText().equals("")))) {
              // mov r1 r2
              String machineCode = act.translateMOV(aTmpText1, aTmpText2, aTmpText3);
              assemblerLabel.setText("<html>" + machineCode + "</html>");
            } else {
              assemblerLabel.setText("<html>" + "Please enter a valid value" + "</html>");
            }

        } else if (s.equals("Disassemble")) {
           /* Assure that whatever value entered is a string */
           dTmpText = dTextField.getText().toString();

            // Translate machine code to assembly
           if (!(dTextField.getText().equals(""))) {
              String asmInstruction = mct.translateMachineCode(dTmpText);
              disassemblerLabel.setText("<html>" + asmInstruction + "</html>");
           } else {
              disassemblerLabel.setText("<html>" + "Please enter a valid value" + "</html>");
           }

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

