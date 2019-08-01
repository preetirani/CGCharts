//
//  UIColor+Extension.swift
//  CGChart
//
//  Created by Rani on 31/07/19.
//  Copyright © 2019 Vinsol. All rights reserved.
//

import UIKit
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed   = CGFloat(Double(red) / 255.0)
        let newGreen = CGFloat(Double(green) / 255.0)
        let newBlue  = CGFloat(Double(blue) / 255.0)
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: CGFloat(1.0))
    }
    
    convenience init(fromHexString hex: String, andAlpha alpha: Float = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(red: 0, green: 0, blue: 0)
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha)
            )
        }
    }
    
    func clone() -> UIColor {
        var (red, green, blue, alpha) = (CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0))
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return UIColor.white
    }
}
