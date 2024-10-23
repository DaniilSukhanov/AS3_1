//
//  AppColor.swift
//  AutmnSchoolHM1_3
//
//  Created by Даниил Суханов on 16.10.2024.
//

import UIKit

enum AppColor {
    static var backgroudView: UIColor {
        UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
    }
    
    static var textColor: UIColor {
        UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
    }
    
    static var backgroudViewButton: UIColor {
        UITraitCollection.current.userInterfaceStyle == .dark ? .blue : .cyan
    }
    
}
