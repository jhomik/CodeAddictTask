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
    
    static var detailCustomButtonBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.tertiarySystemFill
        } else {
            return UIColor(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        }
    }
    
    static var detailCustomButtonTitleColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        } else {
            return UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        }
    }
    
    static var circleNumberViewBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.systemGray
        } else {
            return UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }
    
    static var commitAuthorNameTitleColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.systemGray
        } else {
            return UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        }
    }
    
    static var commitMessageTitleColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.systemGray
        } else {
            return UIColor(displayP3Red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        }
    }
    
    static var detailViewTitlesColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        } else {
            return UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
    
    static var defaultMainColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        } else {
            return UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        }
    }
}
