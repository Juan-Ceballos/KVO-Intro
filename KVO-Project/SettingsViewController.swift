//
//  SettingsViewController.swift
//  KVO-Project
//
//  Created by Juan Ceballos on 4/7/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let iconNames = ["sun.haze", "moon", "globe", "icloud"]
    
    private var fontSizeObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureFontSizeObservation()
    }
    
    private func configurePickerView()  {
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        let newSize = Int(sender.value) // float to Int
        Settings.shared.fontSize = newSize
    }
    
    private func configureFontSizeObservation() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler:  { [weak self] (settings, change) in
            guard let newSize = change.newValue    else{return}
            self?.fontSizeLabel.text = newSize.description
        })
    }
}

extension SettingsViewController: UIPickerViewDataSource    {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iconNames.count
    }
    
}

extension SettingsViewController: UIPickerViewDelegate  {
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iconNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let iconName = iconNames[row]
        Settings.shared.iconName = iconName
    }
}
