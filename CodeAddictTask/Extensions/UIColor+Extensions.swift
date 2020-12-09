//
//  UIColor+Extensions.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

extension UIColor {
    
    static var numbersOfStarsColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.systemGray
        } else {
            return UIColor(displayP3Red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        }
    }
    
    static var cellBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.tertiarySystemFill
        } else {
            return UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }
}
