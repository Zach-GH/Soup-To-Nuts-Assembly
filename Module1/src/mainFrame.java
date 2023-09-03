// Java program to create a
// frame using inheritance().
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Font;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

// inheriting JFrame
public class mainFrame extends JFrame implements ActionListener {
    static JButton toUpperBtn;
    static JButton toLowerBtn;
    static JButton binaryBtn;
    static JButton intToHexBtn;
    static JButton asciiBtn;
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
		binaryBtn = new JButton("Binary\nTo\nHex");
		intToHexBtn = new JButton("Int\nTo\nHex");
		asciiBtn = new JButton("ASCII\nValue");
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
        /* JLabel Bounds */
        upperLabel.setBounds(300, 70, 115, 55);
		lowerLabel.setBounds(300, 120, 115, 55);
		binaryLabel.setBounds(300, 170, 115, 55);
		intToHexLabel.setBounds(300, 220, 115, 55);
		asciiLabel.setBounds(300, 270, 115, 55);

        /* Button Actionlisteners */
        toUpperBtn.addActionListener(this);
        toLowerBtn.addActionListener(this);
        binaryBtn.addActionListener(this);
        intToHexBtn.addActionListener(this);
        asciiBtn.addActionListener(this);

		/* Set up the frame with components */
        add(textField);
		add(toUpperBtn);
		add(toLowerBtn);
		add(binaryBtn);
		add(intToHexBtn);
		add(asciiBtn);
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
        /* Temporary variables used for buffer input */
        String binaryToHexTmp;
        Integer intToHexTmp;
        String intToHexOutput;

        if (s.equals("toUpper")) {
           upperLabel.setText(textField.getText());
           textField.setText("");
        } else if (s.equals("toLower")) {
           lowerLabel.setText(textField.getText());
           textField.setText("");
        } else if (s.equals("Binary\nTo\nHex")) {
            /* Assure that whatever value entered is a string */
            binaryToHexTmp = textField.getText().toString();
            binaryLabel.setText(binaryToHexTmp);
            textField.setText("");
        } else if (s.equals("Int\nTo\nHex")) {
            intToHexTmp = 0;
            outputHex oh = new outputHex();
            try {
                /* Assure that whatever value entered is an Integer */
                intToHexTmp = Integer.parseInt(textField.getText());
                /* Convert from */
                intToHexOutput = oh.intToHex(intToHexTmp);
                /* Convert back into string after hex conversion */
                // intToHexOutput = intToHexTmp.toString();
                intToHexLabel.setText(intToHexOutput);
            } catch (NumberFormatException ne) {
                intToHexOutput = textField.getText();
                System.out.println(intToHexOutput + " is not a valid integer"); 
            } 
            textField.setText("");
        } else if (s.equals("ASCII\nValue")) {
            asciiLabel.setText(textField.getText());
            textField.setText("");
        }
    }
}

