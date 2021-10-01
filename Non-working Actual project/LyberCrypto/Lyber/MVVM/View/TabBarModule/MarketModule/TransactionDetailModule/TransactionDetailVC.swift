//
//  TransactionDetailVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class TransactionDetailVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDare: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!
    @IBOutlet weak var lblTym: UILabel!
    @IBOutlet weak var lblTymValue: UILabel!
    @IBOutlet weak var lblTotalAmnt: UILabel!
    @IBOutlet weak var lblTotalAmntValue: UILabel!
    @IBOutlet weak var lblTotalAmntMoney: UILabel!
    @IBOutlet weak var lblTotalAmntMoneyValue: UILabel!
    @IBOutlet weak var lblWithdrawFee: UILabel!
    @IBOutlet weak var lblWithdrawFeeValue: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnTransactionStatus: UIButton!
    @IBOutlet weak var lblTransactionId: UILabel!
    @IBOutlet weak var lblTransactionIdValue: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblFromValue: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblToValue: UILabel!
    @IBOutlet weak var btnBackToWallet: AppBlueButton!
    @IBOutlet weak var vwLogo: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var viewRound: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}


//MARK:- INITIAL SET UP
extension TransactionDetailVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Transaction_Details.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDare, text: L10n.Date.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTym, text: L10n.Time.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDateValue, text: "Aug 27, 2021", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTymValue, text: "11:38 AM", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTotalAmnt, text: L10n.Total_amount.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTotalAmntValue, text: "0.021 BTC", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTotalAmntMoney, text: L10n.Total_amount_€.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTotalAmntMoneyValue, text: "€204.48", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblWithdrawFee, text: L10n.Withdraw_fee.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblWithdrawFeeValue, text: "0.0015 BTC", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblStatus, text: L10n.Status.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnTransactionStatus, title: L10n.Transaction_confirmed.description, titlecolor: .themeColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTransactionId, text: L10n.Transaction_ID.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTransactionIdValue, text: "3M8w2knJKsr3jqMatYiyuraxVvZA", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblFrom, text: L10n.From.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblFromValue, text: "3M8w2knJKsr3jqMatYiyuraxVvZA", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTo, text: L10n.Withdraw_fee.description, textColor: .TfBorderColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblToValue, text: "3M8w2knJKsr3jqMatYiyuraxVvZA", textColor: .primaryTextColor, font: .MontserratMedium(Size.Header.sizeValue()))
        
        btnBackToWallet.setTitle(L10n.Back_to_Wallet.description, for: .normal)
        btnBack.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnBackToWallet.addTarget(self, action: #selector(btnBackToWalletTapped), for: .touchUpInside)
            
        
        DispatchQueue.main.async {
            self.viewRound.roundCorners([.topLeft, .topRight], radius: 20)
        }
    }
}

// MARK:- BUTTON ACTIONS
extension TransactionDetailVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnBackToWalletTapped(sender: UIButton){
        self.navigationController?.popToViewController(ofClass: TabBarVC.self)
    }
}


