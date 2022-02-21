//
//  ColorSettingsViewController.swift
//  ColorPicker
//
//  Created by Nikolay Trofimov on 20.01.2022.
//

import UIKit

class ColorSettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    @IBOutlet var resultColor: UIView!
    
    // MARK: - Public Properties
    var delegate: ColorSettingsViewControllerDelegate!
    var viewColor: UIColor!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        resultColor.layer.cornerRadius = 10
        resultColor.backgroundColor = viewColor
        
        setSliders()
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redValueTF, greenValueTF, blueValueTF)
        
        addDoneButton(for: redValueTF, greenValueTF, blueValueTF)
    }
    
    // MARK: - IBActions
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redValueTF)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenValueTF)
        default:
            setValue(for: blueLabel)
            setValue(for: blueValueTF)
        }
        
        updateColor()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setColor(resultColor.backgroundColor ?? .white)
        
        dismiss(animated: true)
    }

}
    
// MARK: - Private Methods
extension ColorSettingsViewController {
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func updateColor() {
        resultColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redValueTF: textField.text = string(from: redSlider)
            case greenValueTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func addDoneButton(for textFields: UITextField...) {
        let toolbarDone = UIToolbar()
        toolbarDone.sizeToFit()
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let barButtonDone = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
            target: self,
            action: #selector(dismissKeyboard)
        )
        
        toolbarDone.items = [flexSpace, barButtonDone]
        
        textFields.forEach { textField in
            textField.inputAccessoryView = toolbarDone
        }
    }
    
    private func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - UITextFieldDelegate
extension ColorSettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redValueTF:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case greenValueTF:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            }
            
            updateColor()
            return
        }
        
        showAlert(title: "Wrong format!",message: "Please enter correct value")
    }
    
}
