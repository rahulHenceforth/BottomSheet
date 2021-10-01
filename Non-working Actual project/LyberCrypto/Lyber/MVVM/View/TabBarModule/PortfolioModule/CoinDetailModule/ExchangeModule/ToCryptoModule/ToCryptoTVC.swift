//
//  ToCryptoTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

import UIKit

class ToCryptoTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var lblCoinSymbol: UILabel!
    @IBOutlet weak var lblCoinPrice: UILabel!
    @IBOutlet weak var lbBalance: UILabel!
    @IBOutlet weak var viewBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        viewBg.layer.cornerRadius = 24
        viewBg.layer.borderWidth = 1
        viewBg.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        CommmonUI.initialLbl(lbl: lblCoinName, textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCoinSymbol, textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCoinPrice, text: "€100.00", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lbBalance, textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- CONFIGURE CELL WITH DATA
extension ToCryptoTVC{
    func configure(row: Int){
        
        switch row {
        case 0:
            lblCoinName.text = L10n.Bitcoin.description
            lblCoinSymbol.text = L10n.BTC.description
            lbBalance.text = "0.001548 \(L10n.BTC.description)"
            imgCoin.image = Asset.bitcoin_small.image()
        case 1:
            lblCoinName.text = L10n.Ethereum.description
            lblCoinSymbol.text = L10n.ETH.description
            lbBalance.text = "0.001548 \(L10n.ETH.description)"
            imgCoin.image = Asset.ethereum_small.image()
        case 2:
            lblCoinName.text = L10n.Euro.description
            lblCoinSymbol.text = L10n.EUR.description
            lbBalance.text = "0.001548 \(L10n.EUR.description)"
            imgCoin.image = Asset.eur.image()
        default:
            return
        }
    }
}

