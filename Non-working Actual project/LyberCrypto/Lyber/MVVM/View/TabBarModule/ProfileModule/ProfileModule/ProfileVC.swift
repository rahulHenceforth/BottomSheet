//
//  ProfileVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var btnBell: UIButton!
    @IBOutlet weak var vwBell: UIView!
    @IBOutlet weak var lblBellCount: UILabel!
    @IBOutlet weak var vwProfileImg: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var tblVw: UITableView!
    
    // MARK:- VARIABLES
    private var dataSource : SetUpTableView<ProfileTVC, String>!
    var tblData = [L10n.Edit_Profile.description,L10n.Phone_Number.description,L10n.Update_Address.description,L10n.Linked_Bank_Account.description, L10n.Change_Password.description, L10n.Contact_Us.description, L10n.Log_Out.description]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        updateDataSource()
    }
}

//MARK:- INITIAL SET UP
extension ProfileVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblBellCount, text: "3", textColor: .appWhiteColor, font: .MontserratBold(Size.VSmall.sizeValue()))
        CommmonUI.initialLbl(lbl: lblName, text: "Alex Sotsky", textColor: .primaryTextColor, font: .MontserratBold(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblID, text: "ID : 54FSD545C", textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 2
        vwProfileImg.layer.cornerRadius = vwProfileImg.bounds.height / 2
        btnBell.layer.cornerRadius = 12
        btnBell.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        vwBell.layer.cornerRadius = vwBell.bounds.height / 2
        vwBell.backgroundColor = .AppRedColor
        
        btnBell.addTarget(self, action: #selector(btnBellTapped), for: .touchUpInside)
    }
}

// MARK:- TABLE VIEW SETUP
extension ProfileVC{
    
    func updateDataSource(){
        
        self.dataSource = SetUpTableView(cellIdentifier: TableViewCell.ProfileTVC.getValues(), items: tblData, configureCell: { (cell, data, index) in
            cell.selectionStyle = .none
            cell.configure(with: self.tblData[index.row], isLast: index.row == self.tblData.count-1 ? true : false)
        }, cellTap: { (indexPath, item) in
            print("Cell_Tapped at : \(indexPath), item = \(item)")
            
            switch indexPath.row{
            
            case 0:
                let vc = EditProfileVC.instantiateFromAppStoryboard(appStoryboard: .EditProfile)
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = EnterPhoneVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                vc.isFromEditProfile = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = EditAddressVC.instantiateFromAppStoryboard(appStoryboard: .EditProfile)
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = LinkBankVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                vc.isFromEditProfile = true
                self.navigationController?.pushViewController(vc, animated: true)
            case 4:
                let vc = ChangePassVC.instantiateFromAppStoryboard(appStoryboard: .EditProfile)
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                let vc = ContactUS.instantiateFromAppStoryboard(appStoryboard: .EditProfile)
                self.navigationController?.pushViewController(vc, animated: true)
            case 6:
                CommonFunctions.showAlertWithTitle(title: L10n.Log_Out.description, message: L10n.LogOut_Description.description, firstBtn: L10n.Yes.description, firstButtonResult: { btnTapped in
                    CommonFunctions.logout(true)
                }, secondBtn: L10n.No.description) { btnTapped in
                    
                }
                
            default:
                return
                
            }
            
        })
        
        DispatchQueue.main.async {
            self.tblVw.delegate = self.dataSource
            self.tblVw.dataSource = self.dataSource
            self.tblVw.reloadData()
        }
    }
}

// MARK:- BUTTON ACTIONS
extension ProfileVC{
    
    @objc func btnBellTapped(sender: UITapGestureRecognizer){
        let vc = NotificationVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


