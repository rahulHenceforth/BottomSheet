//
//  AssetsOptionsCVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class AssetsOptionsCVC: UICollectionViewCell {
 
    //MARK:- IB OUTLETS
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var lblBalanceUnits: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblBalanceInEuro: UILabel!
    
}

//MARK:- CONFIGURE CELL WITH DATA
extension AssetsOptionsCVC{
    func configure(with data: String){
        CommmonUI.initialLbl(lbl: lblCurrencyName, text: L10n.Bitcoin.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCurrencySymbol, text: "BTC", textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalanceUnits, text: "1,116 BTC", textColor: .primaryTextColor, font: .MontserratBold(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalanceInEuro, text: CommonFunctions.formattedCurrency(from: "124564"), textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        
//        lblBalanceUnits.text = CommonFunctions.sendAttText(["1.116 BTC", CommonFunctions.formattedCurrency(from: "2110")], fonts: [.MontserratBold(Size.Medium.sizeValue()), .MontserratMedium(Size.VSmall.sizeValue())], color: [.primaryTextColor, .primaryTextColor], alingment: .natural)
        
        viewBg.layer.cornerRadius = 24
        viewBg.backgroundColor = .appWhiteColor
        viewBg.layer.borderWidth = 1
        viewBg.layer.borderColor = UIColor(netHex: 0xC0C8D55C).withAlphaComponent(0.36).cgColor
    }
}

