//
//  ViewController.swift
//  KVO-Project
//
//  Created by Juan Ceballos on 4/7/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    private var fontSizedObservation: NSKeyValueObservation?
    private var iconNameObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
    }

    private func configureObservers()   {
        configureFontSizeObservation()
        configureIconNameObservation()
    }
    
    private func configureFontSizeObservation() {
        fontSizedObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            // update ui
            guard let newSize = change.newValue else    {return}
            let fontSize = CGFloat(newSize)
            self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    private func configureIconNameObservation() {
        iconNameObservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            guard let iconName = change.newValue else   {return}
            self?.welcomeImageView.image = UIImage(systemName: iconName)
        })
    }
    
    deinit {
        fontSizedObservation?.invalidate()
        iconNameObservation?.invalidate()
    }
    
}
