//
//  DepositVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

import UIKit

class DepositVC: UIViewController{
    
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewCoin: UIView!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var imgBarCode: UIImageView!
    @IBOutlet weak var lblMyCode: UILabel!
    @IBOutlet weak var btnCopu: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var vwLine: UIView!
    
    
//    var pointOrigin: CGPoint?
//    var hasSetPointOrigin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupViews()
        initialSetUp()
    }
    
//    override func viewDidLayoutSubviews() {
//        if !hasSetPointOrigin {
//            hasSetPointOrigin = true
//            pointOrigin = self.view.frame.origin
//        }
//    }
//
}

//MARK:- INITIAL SET UP
extension DepositVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Deposit.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        viewCoin.layer.cornerRadius = viewCoin.bounds.height / 2
        viewCoin.backgroundColor = .WalkthroughBgColor.withAlphaComponent(0.64)
        vwLine.layer.cornerRadius = vwLine.bounds.height / 2
        CommmonUI.initialLbl(lbl: lblCoinName, text: "Ethereum", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblMyCode, text: "3M8w2knJKsr3jqMatY iyuraxVvZAmuZ", textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnCopu, title: L10n.Copy.description, titlecolor: .themeColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnShare, title: L10n.Share.description, titlecolor: .themeColor, font: .MontserratBold(Size.Large.sizeValue()))
        
        btnCopu.addTarget(self, action: #selector(btnCopyTapped), for: .touchUpInside)
        btnShare.addTarget(self, action: #selector(btnShareTapped), for: .touchUpInside)
        
    }
}

//// MARK:- SET UP PAN GESTURE
//extension DepositVC{
//    func setupViews() {
//        // 2.
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
//        self.view.addGestureRecognizer(panGesture)
//    }
//
//    // 3.
//    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: view)
//
//        // Not allowing the user to drag the view upward
//        guard translation.y >= 0 else { return }
//
//        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
//        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
//
//        if sender.state == .ended {
//            let dragVelocity = sender.velocity(in: view)
//            if dragVelocity.y >= 1300 {
//                // Velocity fast enough to dismiss the uiview
//                self.dismiss(animated: true, completion: nil)
//            } else {
//                // Set back to original position of the view controller
//                UIView.animate(withDuration: 0.3) {
//                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
//                }
//            }
//        }
//    }
//}

// MARK:- BUTTON ACTIONS
extension DepositVC{
    
    @objc func btnCopyTapped(sender: UIButton){
        UIPasteboard.general.string = lblMyCode.text ?? ""
        CommonFunctions.toster("Copied successfully")
    }
    
    @objc func btnShareTapped(sender: UIButton){
        CommonFunctions.showShareActivity(msg: "Share your ethereum code", image: nil, url: nil, sourceRect: nil)
    }
}
