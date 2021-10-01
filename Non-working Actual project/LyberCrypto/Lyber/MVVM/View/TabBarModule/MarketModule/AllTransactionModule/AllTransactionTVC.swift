//
//  AllTransactionTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class AllTransactionTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblAmnt: UILabel!
    @IBOutlet weak var lblCurrencyAmnt: UILabel!
    @IBOutlet weak var lblTransactionType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommmonUI.initialLbl(lbl: lblAmnt, text: "€204", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTransactionType, text: L10n.Withdrawn.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCurrencyAmnt, text: "0.021 BTC", textColor: .TfBorderColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDate, text: "Aug 27, 2021", textColor: .TfBorderColor, font: .MontserratMedium(Size.Small.sizeValue()))
        viewBg.layer.cornerRadius = 24
        viewBg.layer.borderWidth = 1
        viewBg.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
