//
//  ColorSettingsViewController.swift
//  ColorPicker
//
//  Created by Nikolay Trofimov on 20.01.2022.
//

import UIKit

class ColorSettingsViewController: UIViewController {
    
    // MARK: IBOutlets
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
    
    // MARK: Properties
    var viewColor: UIColor!
    var delegate: ColorSettingsViewControllerDelegate!
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        redSlider.value = Float(viewColor.redValue)
        greenSlider.value = Float(viewColor.greenValue)
        blueSlider.value = Float(viewColor.blueValue)
        
        updateColor()
        
        addDoneButton(for: redValueTF)
        addDoneButton(for: greenValueTF)
        addDoneButton(for: blueValueTF)
        
        resultColor.layer.cornerRadius = 10
    }
    
    // MARK: IBActions
    @IBAction func redSettingSlider(_ sender: UISlider) {
        redLabel.text = String(format: "%.2f", sender.value)
        updateColor()
    }
    
    @IBAction func greenSettingSlider(_ sender: UISlider) {
        greenLabel.text = String(format: "%.2f", sender.value)
        updateColor()
    }
    
    @IBAction func blueSettingSlider(_ sender: UISlider) {
        blueLabel.text = String(format: "%.2f", sender.value)
        updateColor()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.updateBackground(color: resultColor.backgroundColor ?? .white)
        
        dismiss(animated: true)
    }
    
    // MARK: Private Methods
    private func updateColor() {
        updateLabelValues()
        resultColor.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func updateLabelValues() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        redValueTF.text = redLabel.text
        greenValueTF.text = greenLabel.text
        blueValueTF.text = blueLabel.text
    }
    
    private func addDoneButton(for textField: UITextField) {
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
        textField.inputAccessoryView = toolbarDone
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: Alert Controller
extension ColorSettingsViewController {
    private func showNotification(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: Hide keyboard on tap
extension ColorSettingsViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate
extension ColorSettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redValueTF:
            redSlider.value = getValue(from: textField)
            updateColor()
        case greenValueTF:
            greenSlider.value = getValue(from: textField)
            updateColor()
        default:
            blueSlider.value = getValue(from: textField)
            updateColor()
        }
        
    }
    
    private func getValue(from textField: UITextField) -> Float {
        guard let textValue = textField.text else { return 1 }
        guard let doubleValue = Double(textValue) else { return 1 }
        if doubleValue < 0 {
            showNotification(
                title: "Warning!",
                message: "Valid values are from 0.00 to 1.00"
            )
            return 0
        }
        
        if doubleValue > 1 {
            showNotification(
                title: "Warning!",
                message: "Valid values are from 0.00 to 1.00"
            )
            return 1
        }
        
        return Float(doubleValue)
    }
}

// MARK: UIColor extension
extension UIColor {
    var redValue: CGFloat { return CIColor(color: self).red }
    var greenValue: CGFloat { return CIColor(color: self).green }
    var blueValue: CGFloat { return CIColor(color: self).blue }
}
