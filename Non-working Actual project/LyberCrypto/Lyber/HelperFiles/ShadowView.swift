//
//  shadowView.swift
//  RxHub
//
//  Created by MAC on 29/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class shadowView: UIView {

    // MARK: - VARIABLES
    var cornarRadius: CGFloat = 8
    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 1
    var shadowColor: UIColor? = UIColor.black
    var shadowOpacity: Float = 0.6
    var shadowRadius: CGFloat?
    

    // MARK: - OVERRIDE FUNCTIONS
    // called whenever subview changed
    override func layoutSubviews() {
        layer.cornerRadius = cornarRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornarRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        
        if let shadowRadius = shadowRadius{
            layer.shadowRadius = shadowRadius
        }
        
        layer.shadowPath = shadowPath.cgPath
    }
}
