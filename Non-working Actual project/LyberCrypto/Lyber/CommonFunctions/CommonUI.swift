
//
//  CommonUI.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 25/08/21.
//

import Foundation
import UIKit
import ActiveLabel
import SkyFloatingLabelTextField

class CommmonUI{
    
    static func borderdBtn(btn:UIButton, title:String, titlecolor:UIColor, bgColor:UIColor, borderColor:UIColor, borderWidth:CGFloat, font: UIFont, cornerRadius: CGFloat) {
        btn.setTitle(title, for: .normal)
        btn.layer.borderWidth = borderWidth
        btn.layer.cornerRadius = cornerRadius
        btn.layer.borderColor = borderColor.cgColor
        btn.setTitleColor(titlecolor, for: .normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = font
    }
    
    static func unBorderdBtn(btn:UIButton, title:String, titlecolor:UIColor, font: UIFont){
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font =  font
        btn.setTitleColor(titlecolor, for: .normal)
    }
    
    static func initialLbl(lbl:UILabel, text: String? = nil, textColor:UIColor, font: UIFont) {
        lbl.text = text
        lbl.font = font
        lbl.textColor = textColor
    }
    
    static func errorLbl(lbl:UILabel, text:String){
        lbl.text = text
        lbl.textColor = .red
    }
    
    static func round(view: UIView){
        view.layer.cornerRadius = view.bounds.height/2
    }
    
    static func normalTF(tf: SkyFloatingLabelTextField, img: UIImage?, placeHolder : String, rytImage: UIImage? = nil){
        tf.textColor = UIColor.primaryTextColor
        tf.lineColor = UIColor.secondaryTextColor.withAlphaComponent(0.24)
        tf.titleColor = UIColor.secondaryTextColor
        tf.selectedTitleColor = UIColor.secondaryTextColor
        tf.placeholderColor = UIColor.secondaryTextColor
        tf.titleErrorColor = UIColor.secondaryTextColor
        tf.lineErrorColor = UIColor.secondaryTextColor
        tf.lineHeight = 2
        tf.selectedLineHeight = 2
        tf.selectedLineColor = UIColor.themeColor
        tf.placeholder = placeHolder
        tf.font = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.clipsToBounds = true
        tf.placeholder = placeHolder
        tf.tintColor = UIColor.primaryTextColor
//        tf.setRightPaddingPoints(20)
        
        if img != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = img?.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.themeColor
            tf.openView(true, img: imgVw)
        }else if rytImage != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = rytImage?.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 18, bottom: 0, right: 6))
            tf.openView(false, img: imgVw)
//            tf.setLeftPaddingPoints(20)
        }
    }
    
    static func errorTF(tf : SkyFloatingLabelTextField, img: UIImage?, placeHolder : String, rytImage: UIImage? = nil){
        tf.textColor = UIColor.red
        tf.lineColor = UIColor.red
        tf.titleColor = UIColor.red
        tf.selectedTitleColor = UIColor.red
        tf.placeholderColor = UIColor.red
        tf.titleErrorColor = UIColor.red
        tf.lineErrorColor = UIColor.red
        tf.lineHeight = 2
        tf.selectedLineHeight = 2
        tf.selectedLineColor = UIColor.red
        tf.placeholder = placeHolder
        tf.font = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.clipsToBounds = true
        tf.placeholder = placeHolder
        tf.tintColor = UIColor.red
        tf.shake()
        
        if img != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = img?.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.red
            tf.openView(true, img: imgVw)
        }else if rytImage != nil{
//            tf.setLeftPaddingPoints(20)
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = rytImage?.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 18, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.red
            tf.openView(false, img: imgVw)
        }
    }
    
    static func normalTFBtn(tf : SkyFloatingLabelTextField, btn: UIButton, placeHolder : String, leftImage: UIImage? = nil){
        
        tf.disableAutoFill()
        
        let img1 = Asset.visibility.image().imageWithInsets(insets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 20))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.visibility_off.image().imageWithInsets(insets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 20))?.withRenderingMode(.alwaysTemplate)
        
        tf.textColor = UIColor.primaryTextColor
        tf.lineColor = UIColor.secondaryTextColor.withAlphaComponent(0.24)
        tf.titleColor = UIColor.secondaryTextColor
        tf.selectedTitleColor = UIColor.secondaryTextColor
        tf.placeholderColor = UIColor.secondaryTextColor
        tf.titleErrorColor = UIColor.secondaryTextColor
        tf.lineErrorColor = UIColor.secondaryTextColor
        tf.lineHeight = 2
        tf.selectedLineHeight = 2
        tf.selectedLineColor = UIColor.themeColor
        tf.placeholder = placeHolder
        tf.font = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.clipsToBounds = true
        tf.placeholder = placeHolder
        tf.tintColor = UIColor.primaryTextColor
        
        if tf.isSecureTextEntry {
            btn.setImage(img2, for: .normal)
        }else{
            btn.setImage(img1, for: .normal)
        }
        
        btn.tintColor = UIColor.secondaryTextColor
        tf.openView(false, btn: btn)
        
        if leftImage != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = leftImage?.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.themeColor
            tf.openView(true, img: imgVw)
        }else{
//            tf.setLeftPaddingPoints(20)
        }
    }
    
    static func errorTFBtn(tf : SkyFloatingLabelTextField, btn: UIButton, placeHolder : String, leftImage: UIImage? = nil){
        
        tf.disableAutoFill()
        
        let img1 = Asset.visibility.image().imageWithInsets(insets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 20))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.visibility_off.image().imageWithInsets(insets: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 20))?.withRenderingMode(.alwaysTemplate)
        
        tf.textColor = UIColor.red
        tf.lineColor = UIColor.red
        tf.titleColor = UIColor.red
        tf.selectedTitleColor = UIColor.red
        tf.placeholderColor = UIColor.red
        tf.titleErrorColor = UIColor.red
        tf.lineErrorColor = UIColor.red
        tf.lineHeight = 2
        tf.selectedLineHeight = 2
        tf.selectedLineColor = UIColor.red
        tf.placeholder = placeHolder
        tf.font = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Large.sizeValue())
        tf.clipsToBounds = true
        tf.placeholder = placeHolder
        tf.tintColor = UIColor.red
        tf.shake()
        
        if tf.isSecureTextEntry {
            btn.setImage(img2, for: .normal)
        }else{
            btn.setImage(img1, for: .normal)
        }
        
        btn.tintColor = UIColor.red
        tf.rightView = btn
        tf.rightViewMode = .always
        
        if leftImage != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = leftImage?.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.red
            tf.openView(true, img: imgVw)
        }else{
//            tf.setLeftPaddingPoints(20)
        }
    }
    
    static  func attributedLbl(lbl: ActiveLabel, txt: String, font: UIFont, clickAbleTxt: String, clickAbleTxtFont: UIFont, txtColor: UIColor, clickAbleTxtColor: UIColor, handleTap: @escaping ()->() ) {
        
        let customType = ActiveType.custom(pattern: "\\s\(clickAbleTxt)\\b")//Regex that looks for "with"
        lbl.enabledTypes = [.mention, .hashtag, customType]
        lbl.font = font
        lbl.text = "\(txt) \(clickAbleTxt)"
        lbl.textColor = txtColor
        lbl.customFont[customType] = clickAbleTxtFont
        lbl.customColor[customType] = clickAbleTxtColor
//        lbl.customUnderLineStyle[customType] = []
        lbl.handleCustomTap(for: customType) { element in
            print("Custom type tapped: \(element)")
            handleTap()
        }
    }
    
    static func ViewOpenTransition(viewPopUp: UIView) {
        viewPopUp.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, animations: {
            viewPopUp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                viewPopUp.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { _ in
            }
        }
    }
    
    static func ViewCloseTransition(viewPopUp: UIView, ViewToRemove: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            viewPopUp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                viewPopUp.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { _ in
                ViewToRemove.removeFromSuperview()
            }
        }
    }
    
//    static func showError(on tf: UITextField, vw: UIView, img: String? = nil, btn: UIButton? = nil){
//        var kImg: UIImage?
//        
//        if let rImg = img{
//            kImg = UIImage(named: rImg)
//        }
//        
//        if let button = btn{
//            CommmonUI.errorTFBtn(tf: tf, btn: button, placeHolder: tf.placeholder ?? "", leftImage: kImg)
//            button.shake()
//        }else{
//            CommmonUI.errorTF(tf: tf, img: kImg, placeHolder: tf.placeholder ?? "")
//        }
//        vw.shake()
//        if let lbl = vw.subviews.first as? UILabel{
//            lbl.textColor = .red
//        }
//    }
//    
//    static func removeError(on tf: SkyFloatingLabelTextField, vw: UIView, img: String? = nil, btn: UIButton? = nil){
//        var kImg: UIImage?
//        
//        if let rImg = img{
//            kImg = UIImage(named: rImg)
//        }
//        
//        if let button = btn{
//            CommmonUI.normalTFBtn(tf: tf, btn: button, placeHolder: tf.placeholder ?? "", leftImage: kImg)
//        }else{
//            CommmonUI.normalTF(tf: tf, img: kImg, placeHolder: tf.placeholder ?? "")
//        }
//        if let lbl = vw.subviews.first as? UILabel{
//            lbl.textColor = .primaryTextColor
//        }
//    }
    
}
