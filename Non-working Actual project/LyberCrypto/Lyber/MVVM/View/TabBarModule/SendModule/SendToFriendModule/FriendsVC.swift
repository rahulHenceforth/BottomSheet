//
//  FriendsVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

enum SendScreenType {
    case externalWallet
    case friends
}

import UIKit

class FriendsVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var vwNotification: UIView!
    @IBOutlet weak var lblNotiificaionCount: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnBack: UIButton!

    
    // MARK:- VARIABLES
    private var dataSource : SetUpTableView<FriendsTVC, String>!
    var tblData = ["","","","","","","","",""]
    var screenType: SendScreenType = .externalWallet
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
        updateDataSource()
 
    }
}

//MARK:- INITIAL SET UP
extension FriendsVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblName, text: "Alex Sotsky", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblNotiificaionCount, text: "3", textColor: .appWhiteColor, font: .MontserratBold(Size.VSmall.sizeValue()))
        imgProfile.layer.cornerRadius = 12
        btnNotification.layer.cornerRadius = 12
        btnNotification.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        btnBack.layer.cornerRadius = 12
        btnBack.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        vwNotification.layer.cornerRadius = vwNotification.bounds.height / 2
        vwNotification.backgroundColor = .AppRedColor
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnNotification.addTarget(self, action: #selector(btnBellTapped), for: .touchUpInside)
        
    }
}


// MARK:- TABLE VIEW SETUP
extension FriendsVC{
    
    func updateDataSource(){
        
        self.dataSource = SetUpTableView(cellIdentifier: TableViewCell.FriendsTVC.getValues(), items: tblData, configureCell: { (cell, data, index) in
            cell.selectionStyle = .none
            cell.btnSend.setTitle(self.screenType == .friends ? L10n.Send.description : L10n.Withdraw.description , for: .normal)
            cell.btnSend.contentEdgeInsets = self.screenType == .friends ? UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36) : UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }, cellTap: { (indexPath, item) in
            print("Cell_Tapped at : \(indexPath), item = \(item)")
            if self.screenType == .friends{
                let vc = SendBitcoinVC.instantiateFromAppStoryboard(appStoryboard: .Send)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.screenType == .externalWallet{
                k.DeviceInfo.sizeHeight = UIDevice.current.hasNotch ? [0.43, 0.57] : [0.3, 0.7]
                let vc = SendToWalletVC.instantiateFromAppStoryboard(appStoryboard: .Send)
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true, completion: nil)
            }
        })
        
        DispatchQueue.main.async {
            self.tblView.delegate = self.dataSource
            self.tblView.dataSource = self.dataSource
            self.tblView.reloadData()
        }
    }
}

// MARK:- BUTTON ACTIONS
extension FriendsVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnBellTapped(sender: UITapGestureRecognizer){
        let vc = NotificationVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK:- HALF SHEET VIEW DELEGATE
extension FriendsVC: UIViewControllerTransitioningDelegate {
    // 2.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
