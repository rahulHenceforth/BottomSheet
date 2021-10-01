//
//  WatchlistTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class HeaderTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    
    
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
extension HeaderTVC{
    func configure(with data: String){
        CommmonUI.initialLbl(lbl: lblHeader, text: data, textColor: .secondaryTextColor, font: .MontserratBold(Size.Header.sizeValue()))
    }
}
