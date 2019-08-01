//
//  BarEntry.swift
//  CGChart
//
//  Created by Rani on 31/07/19.
//  Copyright © 2019 Vinsol. All rights reserved.
//

import UIKit

struct BarEntry {
    var color: UIColor = UIColor.red
    var fillGradientColor: Bool = false
    
    var barWidth: CGFloat = 10.0
    
    var x: CGFloat
    var yMin: CGFloat
    var yMax: CGFloat
    
    var cornerRadius: Bool = true
    
    var bottomTextData: TextData?
    var topText: TextData?
    
    var isAccessible: Bool = false
    var accessibilityLabel: String?
    var accessibilityHint: String?
    
    init(x: CGFloat, yMin: CGFloat, yMax: CGFloat) {
        self.x = x
        self.yMin = yMin
        self.yMax = yMax
    }
}

struct TextData {
    var text: String?
    var color: UIColor = UIColor.black
    var font: UIFont?
}
