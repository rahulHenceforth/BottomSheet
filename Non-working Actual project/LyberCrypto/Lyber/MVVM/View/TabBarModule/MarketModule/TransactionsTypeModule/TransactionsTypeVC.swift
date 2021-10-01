//
//  TransactionsVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class TransactionsTypeVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblTransactiontype: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnClearAll: UIButton!
    @IBOutlet weak var btnDeposited: UIButton!
    @IBOutlet weak var imgDeposited: UIImageView!
    @IBOutlet weak var btnWithdrawn: UIButton!
    @IBOutlet weak var imgWithdrawn: UIImageView!
    @IBOutlet weak var btnSent: UIButton!
    @IBOutlet weak var imgSent: UIImageView!
    @IBOutlet weak var btnExchanged: UIButton!
    @IBOutlet weak var imgExchanged: UIImageView!
    @IBOutlet var vwImgs: [UIView]!
    
    var transactionTypeStatus = [false, false, false, false]
    var pointOrigin: CGPoint?
    var hasSetPointOrigin = false
    var doneTapped: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
}

//MARK:- INITIAL SET UP
extension TransactionsTypeVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblTransactiontype, text: L10n.Transactions_type.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnDone, title: L10n.DONE.description, titlecolor: .themeColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnSelectAll, title: L10n.Select_All.description, titlecolor: .themeColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnClearAll, title: L10n.Clear_All.description, titlecolor: .themeColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        btnSelectAll.layer.cornerRadius = btnSelectAll.bounds.height / 2
        btnClearAll.layer.cornerRadius = btnClearAll.bounds.height / 2
        CommmonUI.unBorderdBtn(btn: btnDeposited, title: L10n.Deposited.description, titlecolor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnWithdrawn, title: L10n.Withdrawn.description, titlecolor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnSent, title: L10n.Sent.description, titlecolor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnExchanged, title: L10n.Exchanged.description, titlecolor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        
        btnDeposited.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        btnSent.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        btnExchanged.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        btnWithdrawn.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        btnDone.addTarget(self, action: #selector(btnDoneTapped), for: .touchUpInside)
        btnSelectAll.addTarget(self, action: #selector(btnSelectAllTapped), for: .touchUpInside)
        btnClearAll.addTarget(self, action: #selector(btnClearAllTapped), for: .touchUpInside)
        
        for vw in vwImgs{
            vw.layer.cornerRadius = vw.bounds.height / 2
        }
    }
}

// MARK:- SET UP PAN GESTURE
extension TransactionsTypeVC{
    func setupViews() {
        // 2.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.view.addGestureRecognizer(panGesture)
    }
    
    // 3.
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                // Velocity fast enough to dismiss the uiview
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

// MARK:- BUTTON ACTIONS
extension TransactionsTypeVC{
    
    @objc func optionSelected(sender: UIButton){
        transactionTypeStatus[sender.tag].toggle()
        
        switch sender.tag {
        case 0:
            imgDeposited.image = transactionTypeStatus[sender.tag] ? Asset.check.image() : Asset.uncheck.image()
        case 1:
            imgWithdrawn.image = transactionTypeStatus[sender.tag] ? Asset.check.image() : Asset.uncheck.image()
        case 2:
            imgSent.image = transactionTypeStatus[sender.tag] ? Asset.check.image() : Asset.uncheck.image()
        case 3:
            imgExchanged.image = transactionTypeStatus[sender.tag] ? Asset.check.image() : Asset.uncheck.image()
        default:
            return
        }
        
    }
    
    @objc func btnDoneTapped(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        self.doneTapped?()
    }
    
    @objc func btnSelectAllTapped(sender: UIButton){
        setFilter(isSelectAll: true)
    }
    
    @objc func btnClearAllTapped(sender: UIButton){
        setFilter(isSelectAll: false)
    }
    
    func setFilter(isSelectAll: Bool){
        for (num, _) in self.transactionTypeStatus.enumerated(){
            self.transactionTypeStatus[num] = isSelectAll ? true : false
        }
        imgDeposited.image = isSelectAll ? Asset.check.image() : Asset.uncheck.image()
        imgWithdrawn.image = isSelectAll ? Asset.check.image() : Asset.uncheck.image()
        imgSent.image = isSelectAll ? Asset.check.image() : Asset.uncheck.image()
        imgExchanged.image = isSelectAll ? Asset.check.image() : Asset.uncheck.image()
    }
}


