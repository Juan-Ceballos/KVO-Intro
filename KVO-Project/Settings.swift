//
//  Settings.swift
//  KVO-Project
//
//  Created by Juan Ceballos on 4/7/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation

// settings needs to be KVO-Compliant
@objc class Settings: NSObject  {
    static var shared = Settings()
    @objc dynamic var fontSize: Int // property marked for observing
    @objc dynamic var iconName: String
    
    override private init() {
        fontSize = 17
        iconName = "sun.haze.fill"
    }
}
