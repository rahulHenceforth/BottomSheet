//
//  Fonts.swift
//  Lowicks
//
//  Created by MAC on 03/09/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

internal enum Size : CGFloat{
    
    case VSmall = 10.0
    case Small = 12.0
    case Medium = 14.0
    case Large = 16.0
    case XLarge = 18.0
    case Header = 20.0
    case XXLarge = 22.0
    case XXXLarge = 24.0
    case max = 36.0
    
    func sizeValue() -> CGFloat{
        return self.rawValue
    }
}

extension UIFont {
    
    class func MontserratBlack(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Black", size: size)!
    }
    class func MontserratBlackItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-BlackItalic", size: size)!
    }
    class func MontserratBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }
    class func MontserratBoldItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-BoldItalic", size: size)!
    }
    class func MontserratExtraBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-ExtraBold", size: size)!
    }
    class func MontserratExtraBoldItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-ExtraBoldItalic", size: size)!
    }
    
    class func MontserratExtraLight(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-ExtraLight", size: size)!
    }
    class func MontserratExtraLightItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-ExtraLightItalic", size: size)!
    }
    class func MontserratItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Italic", size: size)!
    }
    class func MontserratLight(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Light", size: size)!
    }
    class func MontserratLightItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-LightItalic", size: size)!
    }
    class func MontserratMedium(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }
    
    class func MontserratMediumItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-MediumItalic", size: size)!
    }
    class func MontserratRegular(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    class func MontserratSemiBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size)!
    }
    class func MontserratSemiBoldItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBoldItalic", size: size)!
    }
    class func MontserratThin(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Thin", size: size)!
    }
    class func MontserratThinItalic(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-ThinItalic", size: size)!
    }
    
}
