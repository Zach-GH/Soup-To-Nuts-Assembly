import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Font;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

/* Main gui instantiation */
public class mainFrame extends JFrame implements ActionListener {
    static JButton toUpperBtn;
    static JButton toLowerBtn;
    static JButton binaryBtn;
    static JButton intToHexBtn;
    static JButton asciiBtn;
    static JButton clearBtn;
    static JFrame frame;
    static JLabel upperLabel;
    static JLabel lowerLabel;
    static JLabel binaryLabel;
    static JLabel intToHexLabel;
    static JLabel asciiLabel;
    static JTextField textField;

	mainFrame() {
        /* Soup To Nuts */
		setTitle("Soup To Nuts Assembly Module 1");

		/* Buttons */
		toUpperBtn = new JButton("toUpper");
		toLowerBtn = new JButton("toLower");
		binaryBtn = new JButton("Binary To Hex");
		intToHexBtn = new JButton("Int To Hex");
		asciiBtn = new JButton("ASCII Value");
		clearBtn = new JButton("Clear Values");

        /* JLabels */
        upperLabel = new JLabel("0");
		lowerLabel = new JLabel("0");
		binaryLabel = new JLabel("0");
		intToHexLabel = new JLabel("0");
		asciiLabel = new JLabel("0");

        /* Create text field for user input */
        textField = new JTextField(16);

        /* Create and set the font for the text field */
        Font font = new Font("Comic Sans", Font.BOLD, 20);
        textField.setFont(font);
		textField.setBounds(165, 20, 115, 55);

        /* JButton Bounds */
		toUpperBtn.setBounds(165, 70, 115, 55);
		toLowerBtn.setBounds(165, 120, 115, 55);
		binaryBtn.setBounds(165, 170, 115, 55);
		intToHexBtn.setBounds(165, 220, 115, 55);
		asciiBtn.setBounds(165, 270, 115, 55);
		clearBtn.setBounds(165, 320, 115, 55);
        /* JLabel Bounds */
        upperLabel.setBounds(300, 70, 299, 55);
		lowerLabel.setBounds(300, 120, 299, 55);
		binaryLabel.setBounds(300, 170, 299, 55);
		intToHexLabel.setBounds(300, 220, 299, 55);
		asciiLabel.setBounds(300, 270, 299, 55);

        /* Button Actionlisteners */
        toUpperBtn.addActionListener(this);
        toLowerBtn.addActionListener(this);
        binaryBtn.addActionListener(this);
        intToHexBtn.addActionListener(this);
        asciiBtn.addActionListener(this);
        clearBtn.addActionListener(this);

		/* Set up the frame with components */
        add(textField);
		add(toUpperBtn);
		add(toLowerBtn);
		add(binaryBtn);
		add(intToHexBtn);
		add(asciiBtn);
		add(clearBtn);
		add(upperLabel);
		add(lowerLabel);
		add(binaryLabel);
		add(intToHexLabel);
		add(asciiLabel);

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
        outputHex oh = new outputHex();
        asciiConverter ac = new asciiConverter();
        /* Temporary variables used for buffer input */
        String binaryToHexTmp;
        Integer intToHexTmp;
        String asciiInput;
        String asciiOutput;
        String intToHexOutput;
        String binaryToHexOutput;

        if (s.equals("toUpper")) {
           asciiInput = textField.getText();
           asciiOutput = ac.toUpper(asciiInput);
           upperLabel.setText("<html>" + asciiOutput + "</html>");
           textField.setText("");
        } else if (s.equals("toLower")) {
           asciiInput = textField.getText();
           asciiOutput = ac.toLower(asciiInput);
           lowerLabel.setText("<html>" + asciiOutput + "</html>");
           textField.setText("");
        } else if (s.equals("Binary To Hex")) {
            /* Assure that whatever value entered is a string */
            binaryToHexTmp = textField.getText().toString();
            binaryToHexOutput = oh.binaryToHex(binaryToHexTmp);
            binaryLabel.setText("<html>" + binaryToHexOutput + "</html>");
        } else if (s.equals("Int To Hex")) {
            intToHexTmp = 0;
            try {
                /* Assure that whatever value entered is an Integer */
                intToHexTmp = Integer.parseInt(textField.getText());
                /* Convert from Int to Hex */
                intToHexOutput = oh.intToHex(intToHexTmp);
                intToHexLabel.setText("<html>" + intToHexOutput + "</html>");
            } catch (NumberFormatException ne) {
                intToHexOutput = textField.getText();
                System.out.println(intToHexOutput + " is not a valid integer"); 
            } 
            textField.setText("");
        } else if (s.equals("ASCII Value")) {
            asciiInput = textField.getText();
            asciiOutput = ac.asciiToValue(asciiInput);
            asciiLabel.setText("<html>" + asciiOutput + "</html>");
            textField.setText("");
        } else if (s.equals("Clear Values")) {
            upperLabel.setText("0");
            lowerLabel.setText("0");
            binaryLabel.setText("0");
            intToHexLabel.setText("0");
            asciiLabel.setText("0");
            textField.setText("");
        }
    }
}

