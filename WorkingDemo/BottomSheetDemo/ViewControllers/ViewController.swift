//
//  ViewController.swift
//  BottomSheetDemo
//
//  Created by Rahul's Mac on 01/10/21.
//

import UIKit

class ViewController: UIViewController, BottomSheetManagerDelegate {
    
    var bottomSheetManager: BottomSheetManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnSheet1Tapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SheetOneVC") as! SheetOneVC
        vc.modalPresentationStyle = .custom
        bottomSheetManager = BottomSheetManager(delegate: self, bottomSheetVw: vc.view, presentedViewController: self)
        vc.transitioningDelegate = bottomSheetManager
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSheet2Tapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SheetTwoVC") as! SheetTwoVC
        vc.modalPresentationStyle = .custom
        bottomSheetManager = BottomSheetManager(delegate: self, bottomSheetVw: vc.view, presentedViewController: self)
        vc.transitioningDelegate = bottomSheetManager
        self.present(vc, animated: true, completion: nil)
    }
    

    func dismissSheet() {
        self.dismiss(animated: true, completion: nil)
    }
}








//
////
////  BottomSheetManager.swift
////  Lyber
////
////  Created by Rahul's Mac on 30/09/21.
////
//
//import Foundation
//import UIKit
//
//// MARK:- PROTOCOL FOR BOTTOM SHEET ACTIONS
//protocol BottomSheetManagerDelegate: AnyObject {
//    func dismissSheet()
//}
//
//class BottomSheetManager: NSObject{
//
//    // MARK: - DELEGATE
//    weak var delegate: BottomSheetManagerDelegate?
//
//
//    // MARK: - Properties
//    var bottomSheetVw: UIView?
//    var presentedViewController: UIViewController?
//    var panGesture: UIPanGestureRecognizer?
//    var pointOrigin: CGPoint?
//
//    init(delegate: BottomSheetManagerDelegate, bottomSheetVw: UIView, presentedViewController: UIViewController, sizeOfBottomSheet: [CGFloat]) {
//        super.init()
//        self.delegate = delegate
//        self.bottomSheetVw = bottomSheetVw
//        self.presentedViewController = presentedViewController
//        k.DeviceInfo.sizeHeight = sizeOfBottomSheet
//        self.pointOrigin = CGPoint(x: 0, y: presentedViewController.view.frame.height * k.DeviceInfo.sizeHeight[0])
//        self.SetGesture()
//    }
//
//    // MARK:- ADDING PAN GESTURE OVER BOTTOM SHEET TO MANAGE ITS SWIPE ACTIONS
//    func SetGesture(){
//        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
//        self.bottomSheetVw?.isUserInteractionEnabled = true
//        self.bottomSheetVw?.addGestureRecognizer(panGesture ?? UIPanGestureRecognizer())
//    }
//
//
//    // MARK:- ACTION THAT MANAGES THE SWIPE UP DOWN OF BOTTOM SHEET
//    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: bottomSheetVw)
//
//        // Not allowing the user to drag the view upward
//        guard translation.y >= 0 else { return }
//
//        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
//        bottomSheetVw?.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
//
//        if sender.state == .ended {
//            let dragVelocity = sender.velocity(in: bottomSheetVw)
//            if dragVelocity.y >= 1300 {
//                // Velocity fast enough to dismiss the uiview
//                self.delegate?.dismissSheet()
//            } else {
//                // Set back to original position of the view controller
//                UIView.animate(withDuration: 0.3) {
//                    self.bottomSheetVw?.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
//                }
//            }
//        }
//    }
//}
//
//// MARK:- HALF SHEET VIEW PRESENTING DELEGATE
//extension BottomSheetManager: UIViewControllerTransitioningDelegate {
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
//    }
//}
