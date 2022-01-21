//
//  ViewController.swift
//  ColorPicker
//
//  Created by Nikolay Trofimov on 20.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var resultColor: UIView!
    
    var red: CGFloat = 0.5 { didSet {
        redLabel.text = String(format: "%.2f", red)
        updateColor()
    }}
    
    var green: CGFloat = 0.5 { didSet {
        greenLabel.text = String(format: "%.2f", green)
        updateColor()
    }}
    
    var blue: CGFloat = 0.5 { didSet {
        blueLabel.text = String(format: "%.2f", blue)
        updateColor()
    }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultColor.layer.cornerRadius = 10
        updateColor()
    }


    @IBAction func redSettingSlider(_ sender: UISlider) {
        red = CGFloat(sender.value)
    }
    
    @IBAction func greenSettingSlider(_ sender: UISlider) {
        green = CGFloat(sender.value)
    }
    
    @IBAction func blueSettingSlider(_ sender: UISlider) {
        blue = CGFloat(sender.value)
    }
    
    private func updateColor() {
        resultColor.backgroundColor = UIColor(red: red,
                                              green: green,
                                              blue: blue,
                                              alpha: 1.0)
    }
    
}

