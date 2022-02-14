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
    
    // MARK: Private Properties
    private var red: CGFloat = 0.5 {
        didSet {
            redLabel.text = String(format: "%.2f", red)
            updateColor()
        }
    }
    
    private var green: CGFloat = 0.5 {
        didSet {
            greenLabel.text = String(format: "%.2f", green)
            updateColor()
        }
    }
    
    private var blue: CGFloat = 0.5 {
        didSet {
            blueLabel.text = String(format: "%.2f", blue)
            updateColor()
        }
    }
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        red = viewColor.redValue
        green = viewColor.greenValue
        blue = viewColor.blueValue
        
        addDoneButton(for: redValueTF)
        addDoneButton(for: greenValueTF)
        addDoneButton(for: blueValueTF)
        
        resultColor.layer.cornerRadius = 10
    }
    
    // MARK: IBActions
    @IBAction func redSettingSlider(_ sender: UISlider) {
        red = CGFloat(sender.value)
    }
    
    @IBAction func greenSettingSlider(_ sender: UISlider) {
        green = CGFloat(sender.value)
    }
    
    @IBAction func blueSettingSlider(_ sender: UISlider) {
        blue = CGFloat(sender.value)
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        
        let newColor = UIColor(red: red,green: green, blue: blue, alpha: 1.0)
        delegate.updateBackground(color: newColor)
        
        dismiss(animated: true)
    }
    
    // MARK: Private Methods
    private func updateColor() {
        updateSliders()
        updateTextFields()
        resultColor.backgroundColor = UIColor(red: red,
                                              green: green,
                                              blue: blue,
                                              alpha: 1.0)
    }
    
    private func updateSliders() {
        redSlider.value = Float(round(red * 100) / 100)
        greenSlider.value = Float(round(green * 100) / 100)
        blueSlider.value = Float(round(blue * 100) / 100)
    }
    
    private func updateTextFields() {
        redValueTF.text = redLabel.text
        greenValueTF.text = greenLabel.text
        blueValueTF.text = blueLabel.text
    }
    
    private func addDoneButton(for textField: UITextField) {
        let toolbarDone = UIToolbar()
        toolbarDone.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
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

// MARK: Extensions
extension ColorSettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redValueTF:
            red = getValue(from: textField)
        case greenValueTF:
            green = getValue(from: textField)
        case blueValueTF:
            blue = getValue(from: textField)
        default:
            break
        }
        
    }
    
    private func getValue(from textField: UITextField) -> CGFloat {
        guard let textValue = textField.text else { return 1 }
        guard let doubleValue = Double(textValue) else { return 1 }
        if doubleValue < 0 { return 0 }
        if doubleValue > 1 { return 1 }
        return CGFloat(doubleValue)
    }
}

extension UIColor {
    var redValue: CGFloat { return CIColor(color: self).red }
    var greenValue: CGFloat { return CIColor(color: self).green }
    var blueValue: CGFloat { return CIColor(color: self).blue }
}
