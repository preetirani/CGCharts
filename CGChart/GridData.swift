//
//  GridView.swift
//  CGChart
//
//  Created by Rani on 31/07/19.
//  Copyright © 2019 Vinsol. All rights reserved.
//

import UIKit

struct GridData {
    var horizontalPartitions: Int
    var verticalPartitions: Int
    var isDottedLine: Bool = false
    var color: UIColor = UIColor(fromHexString: "#f8f8f8")
    var lineWidth: CGFloat = 1
    
    init(horizontalPartitions: Int, verticalPartitions: Int) {
        self.horizontalPartitions = horizontalPartitions
        self.verticalPartitions = verticalPartitions
    }
    
}
