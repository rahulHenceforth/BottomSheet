//
//  GradientView.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 25/08/21.
//

import Foundation
import UIKit


@IBDesignable
class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateView()
        }
    }

    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }

    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
        if (isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
        layer.masksToBounds = false
        layer.shadowColor =  UIColor.black.withAlphaComponent(0.75).cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//            imgs.layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4.0
        layer.cornerRadius = 4
        
    }
    
}
