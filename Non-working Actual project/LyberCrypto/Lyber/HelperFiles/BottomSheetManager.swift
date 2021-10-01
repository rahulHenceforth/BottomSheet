//
//  BottomSheetManager.swift
//  Lyber
//
//  Created by Rahul's Mac on 30/09/21.
//

import Foundation
import UIKit

// MARK:- PROTOCOL FOR BOTTOM SHEET ACTIONS
protocol BottomSheetManagerDelegate: AnyObject {
    func dismissSheet()
}

class BottomSheetManager: NSObject{

    // MARK: - DELEGATE
    weak var delegate: BottomSheetManagerDelegate?


    // MARK: - Properties
    var bottomSheetVw: UIView?
    var presentedViewController: UIViewController?
    var panGesture: UIPanGestureRecognizer?
    var pointOrigin: CGPoint?

    init(delegate: BottomSheetManagerDelegate, bottomSheetVw: UIView, presentedViewController: UIViewController, sizeOfBottomSheet: [CGFloat]) {
        super.init()
        self.delegate = delegate
        self.bottomSheetVw = bottomSheetVw
        self.presentedViewController = presentedViewController
        k.DeviceInfo.sizeHeight = sizeOfBottomSheet
        self.pointOrigin = CGPoint(x: 0, y: presentedViewController.view.frame.height * k.DeviceInfo.sizeHeight[0])
        self.SetGesture()
    }

    // MARK:- ADDING PAN GESTURE OVER BOTTOM SHEET TO MANAGE ITS SWIPE ACTIONS
    func SetGesture(){
        self.bottomSheetVw?.isUserInteractionEnabled = true
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.bottomSheetVw?.addGestureRecognizer(panGesture ?? UIPanGestureRecognizer())
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector(tapped))
        self.bottomSheetVw?.addGestureRecognizer(tap)
    }


    // MARK:- ACTION THAT MANAGES THE SWIPE UP DOWN OF BOTTOM SHEET
    /*  "panGestureRecognizerAction" This is the function to handle the bottom sheet swipe up or down, i want to make it declared in one manager file so that if i have to implement this bottom sheet functionality at 10 places inside an app so i dont have to write this pan gesture handler in every file using bottom sheet, this is what i want to achieve*/
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetVw)

        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }

        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        bottomSheetVw?.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: bottomSheetVw)
            if dragVelocity.y >= 1300 {
                // Velocity fast enough to dismiss the uiview
                self.delegate?.dismissSheet()
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.bottomSheetVw?.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        print("tapped")
    }
}


// MARK:- HALF SHEET VIEW PRESENTING DELEGATE
extension BottomSheetManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
