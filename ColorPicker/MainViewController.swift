//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Nikolay Trofimov on 13.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
        colorSettingsVC.viewColor = view.backgroundColor
    }

}
