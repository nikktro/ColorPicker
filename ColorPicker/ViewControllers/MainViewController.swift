//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Nikolay Trofimov on 13.02.2022.
//

import UIKit

protocol ColorSettingsViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
        colorSettingsVC.delegate = self
        colorSettingsVC.viewColor = view.backgroundColor
    }
    
}

// MARK: - ColorSettings Delegate
extension MainViewController: ColorSettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
