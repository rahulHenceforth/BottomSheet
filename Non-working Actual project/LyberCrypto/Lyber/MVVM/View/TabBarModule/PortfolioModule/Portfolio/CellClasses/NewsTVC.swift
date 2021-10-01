//
//  NewsTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class NewsTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var vwRound1: UIView!
    @IBOutlet weak var vwRound2: UIView!
    @IBOutlet weak var lblNews: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- CONFIGURE CELL WITH DATA
extension NewsTVC{
    func configure(){
        vwRound1.layer.cornerRadius = vwRound1.bounds.height / 2
        vwRound2.layer.cornerRadius = vwRound2.bounds.height / 2
        CommmonUI.initialLbl(lbl: lblNews, text: L10n.News.description, textColor: .secondaryTextColor, font: .MontserratBold(Size.Header.sizeValue()))
    }
}

