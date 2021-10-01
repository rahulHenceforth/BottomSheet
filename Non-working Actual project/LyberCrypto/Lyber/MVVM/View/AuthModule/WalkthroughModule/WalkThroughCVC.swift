//
//  WalkThroughCVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 25/08/21.
//

import UIKit

class WalkThroughCVC: UICollectionViewCell {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblBottomTitle: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewBottomTitle: UIView!
    
    
    func setData(index: Int){
        
        imgView.contentMode = .scaleAspectFit
        CommmonUI.initialLbl(lbl: lblHeader, textColor: .primaryTextColor, font: .MontserratBold(Size.XLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBottomTitle, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        
        switch index {
        case 0:
            viewBottomTitle.isHidden = true
            viewHeader.isHidden = false
            imgView.image = Asset.splash_one.image()
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.Splash_Content_1.description,
                                                                    L10n.Splash_Sub_Content_1_1.description,
                                                                    L10n.Splash_Sub_Content_1_2.description,
                                                                    L10n.Splash_Sub_Content_1_3.description,
                                                                    L10n.Splash_Sub_Content_1_4.description],
                                        fonts: [.MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue())],
                                        color: [.primaryTextColor,
                                                .themeColor,
                                                .primaryTextColor,
                                                .themeColor,
                                                .primaryTextColor],
                                        alingment: .left, spacing: 4)
        case 1:
            viewHeader.isHidden = true
            viewBottomTitle.isHidden = false
            imgView.image = Asset.splash_two.image()
            lblBottomTitle.attributedText = CommonFunctions.sendAttText([L10n.Splash_Content_2.description,
                                                                         L10n.Splash_Sub_Content_2_1.description],
                                        fonts: [.MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue())],
                                        color: [.primaryTextColor, .themeColor],
                                        alingment: .left, spacing: 4)
        case 2:
            viewBottomTitle.isHidden = true
            viewHeader.isHidden = false
            imgView.image = Asset.splash_three.image()
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.Splash_Content_3.description,
                                                                    L10n.Splash_Sub_Content_3_1.description,
                                                                    L10n.Splash_Sub_Content_3_2.description],
                                        fonts: [.MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue())],
                                        color: [.primaryTextColor, .themeColor, .primaryTextColor],
                                        alingment: .left, spacing: 4)
        case 3:
            viewHeader.isHidden = true
            viewBottomTitle.isHidden = false
            imgView.image = Asset.splash_four.image()
            lblBottomTitle.attributedText = CommonFunctions.sendAttText([L10n.Splash_Content_4.description,
                                                                         L10n.Splash_Sub_Content_4_1.description,
                                                                         L10n.Splash_Sub_Content_4_2.description,
                                                                         L10n.Splash_Sub_Content_4_3.description,
                                                                         L10n.Splash_Sub_Content_4_4.description],
                                        fonts: [.MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue())],
                                        color: [.primaryTextColor,
                                                .themeColor,
                                                .primaryTextColor,
                                                .themeColor,
                                                .primaryTextColor],
                                        alingment: .left, spacing: 4)
        case 4:
            viewBottomTitle.isHidden = true
            viewHeader.isHidden = false
            imgView.image = Asset.splash_five.image()
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.Splash_Content_5.description,
                                                                    L10n.Splash_Sub_Content_5_1.description,
                                                                    L10n.Splash_Sub_Content_5_2.description,
                                                                    L10n.Splash_Sub_Content_5_3.description,
                                                                    L10n.Splash_Sub_Content_5_4.description],
                                        fonts: [.MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue()),
                                                .MontserratSemiBold(Size.XXXLarge.sizeValue()),
                                                .MontserratMedium(Size.XXXLarge.sizeValue())],
                                        color: [.primaryTextColor,
                                                .themeColor,
                                                .primaryTextColor,
                                                .themeColor,
                                                .primaryTextColor],
                                        alingment: .left, spacing: 4)
        default:
            return
        }
        
        
    }
}
