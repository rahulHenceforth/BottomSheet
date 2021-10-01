//
//  uiLabelExtension.swift
//  myDotiNewProject
//
//  Created by Think Recycling Pvt Ltd on 14/01/20.
//  Copyright © 2020 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UILabel{
    func StringIP(txt: [String], font: [UIFont], Color: [UIColor]) -> NSMutableAttributedString{
        
        let mutableString : NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for(num, _) in txt.enumerated(){
            
            let attributes = [NSAttributedString.Key.foregroundColor: Color[num], NSAttributedString.Key.font: font[num]]
            let mutString = NSMutableAttributedString(string: txt[num], attributes: attributes)
            mutableString.append(mutString)
        }
        return mutableString
    }
    func createAttributedLabels(plainText : String, attributedString : String, size: Int){
        let yourAttributes3 = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
        let yourOtherAttributes3 = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
        let partOne3 = NSMutableAttributedString(string: plainText, attributes: yourAttributes3)
        let partTwo3 = NSMutableAttributedString(string: attributedString, attributes: yourOtherAttributes3)
        let combination3 = NSMutableAttributedString()
        combination3.append(partOne3)
        combination3.append(partTwo3)
        self.attributedText = combination3
    }
    
    func createGreen(greenText: String, blackText: String, size : Int){
        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
        let partOne = NSMutableAttributedString(string: greenText, attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: " • \(blackText)", attributes: yourOtherAttributes)
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        self.attributedText = combination
    }
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font as Any])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
    
    func lblWitgImg(txt: String, image: UIImage) -> NSAttributedString{
        
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: txt)
        completeText.append(textAfterIcon)
        //        self.mobileLabel.textAlignment = .center
        //        self.mobileLabel.attributedText = completeText
        return completeText
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

class EdgeInsetLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

