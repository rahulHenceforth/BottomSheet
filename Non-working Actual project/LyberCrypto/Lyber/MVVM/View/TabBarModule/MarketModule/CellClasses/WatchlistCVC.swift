//
//  WatchlistCVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class WatchlistCVC: UICollectionViewCell {
    
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var lblBalanceUnits: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDayChange: UILabel!
    
}

//MARK:- CONFIGURE CELL WITH DATA
extension WatchlistCVC{
    func configure(with data: String){
        CommmonUI.initialLbl(lbl: lblCurrencyName, text: L10n.Bitcoin.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCurrencySymbol, text: "BTC", textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalanceUnits, text: "€41,449.73", textColor: .primaryTextColor, font: .MontserratBold(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDayChange, text: "0.60%", textColor: .AppGreenColor, font: .MontserratMedium(Size.Small.sizeValue()))
        
        viewBg.layer.cornerRadius = 24
        viewBg.backgroundColor = .appWhiteColor
        viewBg.layer.borderWidth = 1
        viewBg.layer.borderColor = UIColor(netHex: 0xC0C8D55C).withAlphaComponent(0.36).cgColor
    }
}
