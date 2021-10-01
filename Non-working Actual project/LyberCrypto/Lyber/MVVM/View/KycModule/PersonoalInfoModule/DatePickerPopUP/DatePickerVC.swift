//
//  DatePickerVC.swift
//  Traxi(Driver)
//
//  Created by IOS on 20/01/21.
//

import UIKit

class DatePickerVC: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet var viewBG: UIView!
    @IBOutlet var viewPopUp: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnDone: AppBlueButton!
    @IBOutlet var viewTop: UIView!
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var lblSelectDate: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var sendValue: ((String) -> ())?
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetUp()
    }
}


extension DatePickerVC {
    
    
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblSelectDate, text: L10n.Select_Date.description, textColor: .appWhiteColor, font: .MontserratBold(Size.Header.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnCancel, title: L10n.CANCEL.description, titlecolor: .primaryTextColor, font: UIFont.MontserratBold(Size.Medium.sizeValue()))
        btnCancel.layer.cornerRadius = 20
        btnCancel.backgroundColor = .WalkthroughBgColor

        btnDone.setTitle( L10n.DONE.description, for: .normal)
        self.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        self.btnDone.addTarget(self, action: #selector(btnSubmitTapped), for: .touchUpInside)
        self.btnCancel.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
        self.datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        
        if #available(iOS 14.0, *) {
            datePicker?.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
        }
        
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        self.datePicker.tintColor = .themeColor
        self.datePicker.datePickerMode = .date
        self.datePicker.locale = .current
        self.viewPopUp.backgroundColor = .white
        self.viewTop.backgroundColor = .themeColor
        self.viewPopUp.layer.cornerRadius = 12
        self.viewTop.layer.cornerRadius = 12
        self.viewTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        tapGesture.delegate = self
        CommmonUI.ViewOpenTransition(viewPopUp: viewPopUp)
    }
}

// MARK: GESTURE FOR CLOSE POP UP ON OUTSIDE TAP
extension DatePickerVC: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == viewBG {
            CommmonUI.ViewCloseTransition(viewPopUp: self.viewPopUp, ViewToRemove: self.view)
            return false
        }
        return false
    }
}

//MARK: BUTTON ACTIONS
extension DatePickerVC {
    
    @objc func btnCloseTapped(sender: UIButton){
        CommmonUI.ViewCloseTransition(viewPopUp: self.viewPopUp, ViewToRemove: self.view)
    }
    
    @objc func btnSubmitTapped(sender: UIButton){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let myString = formatter.string(from: Calendar.current.date(byAdding: .year, value: -18, to: Date())!)
        
        if self.date > myString{
            CommonFunctions.toster(k.ErrorMsgs.MinimumAgeRequired)
            return
        }
        
        if self.date == ""{
            self.sendValue?(self.getFormattedDate(date: myString))
        }else{
            self.sendValue?(self.getFormattedDate(date: self.date))
        }
        CommmonUI.ViewCloseTransition(viewPopUp: self.viewPopUp, ViewToRemove: self.view)
    }
    
    @objc func btnCancelTapped(sender: UIButton){
        
        CommmonUI.ViewCloseTransition(viewPopUp: self.viewPopUp, ViewToRemove: self.view)
    }
    
//    @objc func dateChanged(_ sender: UIDatePicker) {
//        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
//        if let day = components.day, let month = components.month, let year = components.year {
//            print("\(day) \(month) \(year)")
//        }
//    }
    
    @objc func handleDateSelection() {
        print("Selected date/time:", self.datePicker.date)
        self.date = "\(self.datePicker.date)"
    }
    
}

// MARK:- DATE FORMATTER FUNCTION
extension DatePickerVC{
    func getFormattedDate(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "dd-MMM-yyyy"
        let resultString = inputFormatter.string(from: showDate ?? NSDate() as Date)
        return resultString
    }
}
