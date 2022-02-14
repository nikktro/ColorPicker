//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Nikolay Trofimov on 13.02.2022.
//

import UIKit

protocol ColorSettingsViewControllerDelegate {
    func updateBackground(color: UIColor)
}

class MainViewController: UIViewController {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
        colorSettingsVC.viewColor = view.backgroundColor
        colorSettingsVC.delegate = self
    }
    
}

// MARK: Protocol Methods
extension MainViewController: ColorSettingsViewControllerDelegate {
    func updateBackground(color: UIColor) {
        view.backgroundColor = color
    }
}
