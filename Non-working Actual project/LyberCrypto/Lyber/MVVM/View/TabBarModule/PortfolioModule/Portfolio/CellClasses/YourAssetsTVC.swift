//
//  YourAssetsTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class YourAssetsTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblYourAssets: UILabel!
    
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
extension YourAssetsTVC{
    func configure(){
        CommmonUI.initialLbl(lbl: lblYourAssets, text: L10n.Your_Assets.description, textColor: .secondaryTextColor, font: .MontserratBold(Size.Header.sizeValue()))
    }
}

