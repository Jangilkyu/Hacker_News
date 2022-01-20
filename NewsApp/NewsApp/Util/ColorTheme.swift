//
//  ColorTheme.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/20.
//

import UIKit

enum ColorTheme {
    case lightYellow
    
    var color: UIColor {
        switch self {
        case .lightYellow:
            return UIColor(r: 244, g: 189, b: 117)
        }
    }
}


extension UIColor {
    public convenience init(
        r: Int,
        g: Int,
        b: Int,
        alpha: CGFloat = 1.0
    ) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: alpha
        )
    }
}
