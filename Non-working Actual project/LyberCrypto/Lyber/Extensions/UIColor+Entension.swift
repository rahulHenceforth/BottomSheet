//
//  Extension+UIColor.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 27/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UIColor{
    
    open class var appWhiteColor : UIColor{
        get {
            return UIColor(named: "AppWhiteColor") ?? UIColor(netHex: 0xFFFFFFFF)
        }
    }
    open class var primaryTextColor : UIColor{
        get {
            return UIColor(named: "PrimaryTextColor") ?? UIColor(netHex: 0x022B69FF)
        }
    }
    
    open class var secondaryTextColor : UIColor{
        get {
            return UIColor(named: "SecondaryTextColor") ?? UIColor(netHex: 0xC0C8D5FF)
        }
    }
    
    open class var themeColor : UIColor{
        get {
            return UIColor(named: "ThemeColor") ?? UIColor(netHex: 0x00B5E2FF)
        }
    }
    
    open class var GradientSecondColor : UIColor{
        get {
            return UIColor(named: "GradientSecondColor") ?? UIColor(netHex: 0x07A6CEFF)
        }
    }
    
    open class var headerShadowColor : UIColor{
        get {
            return UIColor(netHex: 0x0000001A)
        }
    }
    
    open class var borderColor : UIColor{
        get {
            return UIColor(netHex: 0xE5E5E5FF)
        }
    }
    
    open class var TfBorderColor : UIColor{
        get {
            return UIColor(named: "TfBorderColor") ?? UIColor(netHex: 0xE5E5E5FF)
        }
    }
    
    open class var ethereumColor : UIColor{
        get {
            return UIColor(named: "EthereumColor") ?? UIColor(netHex: 0x4656E9FF)
        }
    }
    
    open class var DescTextColor : UIColor{
        get {
            return UIColor(named: "DescTextColor") ?? UIColor(netHex: 0x6B7287FF)
        }
    }
    
    open class var WalkthroughBgColor : UIColor{
        get {
            return UIColor(named: "WalkthroughBgColor") ?? UIColor(netHex: 0xC2CED5FF)
        }
    }
    
    open class var AppGreenColor : UIColor{
        get {
            return UIColor(named: "AppGreenColor") ?? UIColor(netHex: 0x1CD17CFF)
        }
    }
    
    open class var AppRedColor : UIColor{
        get {
            return UIColor(named: "AppRedColor") ?? UIColor(netHex: 0xFB5869FF)
        }
    }
    
}



extension UIColor {
    // help in fetching color code throught Int
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 255, "Invalid alpha component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    // help in fetching color code throught Int
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 24) & 0xff, green:(netHex >> 16) & 0xff, blue:(netHex >> 8) & 0xff, alpha: netHex & 0xff)
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
