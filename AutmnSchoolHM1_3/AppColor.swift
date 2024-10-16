//
//  AppColor.swift
//  AutmnSchoolHM1_3
//
//  Created by Даниил Суханов on 16.10.2024.
//

import UIKit

struct AppColor {
    static var backgroudView: UIColor {
        UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
    }
    
    static var text: UIColor {
        UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
    }
}
