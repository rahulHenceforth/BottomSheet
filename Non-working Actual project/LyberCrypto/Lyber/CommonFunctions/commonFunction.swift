




import Foundation
//import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
//import Toaster
//import PopupDialog
import Charts
import SwiftEntryKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class EntryAttributeWrapper {
    var attributes: EKAttributes
    init(with attributes: EKAttributes) {
        self.attributes = attributes
    }
}

class CommonFunctions {
    var attributes = EKAttributes()
    let kView = UIView()
    let lblTitle = UILabel()
    let tf = UITextField()
    let btn = UIButton()
    
    //    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    //        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
    //        label.numberOfLines = 0
    //        label.lineBreakMode = NSLineBreakMode.byWordWrapping
    //        label.font = font
    //        label.text = text
    //
    //        label.sizeToFit()
    //        return label.frame.height
    //    }
    
    // MARK: - UI SETTING
    static func setbuttonBoarder(_ radius : CGFloat, _ btns : [UIButton]){
        for btn in btns{
            btn.layer.cornerRadius = radius
        }
    }
    
    
    static func toster(_ txt : String){
        let attributesWrapper: EntryAttributeWrapper = {
            var attributes = EKAttributes()
            attributes.positionConstraints = .fullWidth
            attributes.hapticFeedbackType = .success
            attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
            attributes.entryBackground = .visualEffect(style: .dark)
            attributes.displayDuration = 3
            return EntryAttributeWrapper(with: attributes)
        }()
        let title = EKProperty.LabelContent(
            text: txt,
            style: EKProperty.LabelStyle(font: UIFont.boldSystemFont(ofSize: 16), color: EKColor.white, alignment: NSTextAlignment.center, displayMode: .light, numberOfLines: 0)
        )
        let description = EKProperty.LabelContent(
            text: "",
            style: EKProperty.LabelStyle(
                font: UIFont.systemFont(ofSize: 1, weight: .light),
                color: .black
            )
        )
        let simpleMessage = EKSimpleMessage(
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
    }
    
    static func logout(_ isLogout : Bool = true){
        var vc : UIViewController!
        
        if isLogout{
            vc = LogInVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        }else{
            vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        }
        CommonFunctions.getNavigationController().viewControllers.removeAll()
        CommonFunctions.getNavigationController().viewControllers.append(vc)
        CommonFunctions.getNavigationController().popToRootViewController(animated: true)
    }
    
    static func sendAttText( _ texts : [String], fonts: [UIFont], color: [UIColor], link: [URL?], alingment : NSTextAlignment) -> NSMutableAttributedString{
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alingment
        
        let mutString : NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for (num, text) in texts.enumerated() {
            let att = [NSAttributedString.Key.foregroundColor: color[num], NSAttributedString.Key.font: fonts[num]] as [NSAttributedString.Key : Any]
            let attString = NSAttributedString(string: text, attributes: att)
            
            mutString.append(attString)
            
            if link[num] != nil{
                mutString.addAttributes([.link: link[num]!], range: NSRange(location: mutString.length - text.count, length: text.count))
            }
            
        }
        mutString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraph], range: NSRange(location: 0, length: mutString.string.count))
        return mutString
    }
    
    static func sendAttText( _ texts : [String], fonts: [UIFont], color: [UIColor], alingment : NSTextAlignment, spacing : CGFloat = 4) -> NSMutableAttributedString{
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alingment
        paragraph.lineSpacing = spacing
        
        let mutString : NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for (num, text) in texts.enumerated() {
            let att = [NSAttributedString.Key.foregroundColor: color[num], NSAttributedString.Key.font: fonts[num]] as [NSAttributedString.Key : Any]
            let attString = NSAttributedString(string: text, attributes: att)
            
            mutString.append(attString)
            
        }
        mutString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraph], range: NSRange(location: 0, length: mutString.string.count))
        return mutString
    }
    
    static func getFont(fontName name : String, maximumFontValue size: CGFloat) -> UIFont{
        let font = UIFont(name: name, size: size)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font!)
    }
    
    // for getting navigation controller
    static func getNavigationController() -> UINavigationController{
        if let navVc = keyWindow?.rootViewController as? UINavigationController{
            return navVc
            //        }else{
            //            return UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        }else{
            return UINavigationController()
        }
    }
    
    // for getting top most view controller
    static func getTopMostViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
            // topController should now be your topmost view controller
        }
        return nil
    }
    
    // for Opening share screen and share anyThing From both ipad and ios
    static func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect: CGRect?){
        var objectsToShare = [AnyObject]()
        
        if let url = url {
            objectsToShare = [url as AnyObject]
        }
        
        if let image = image {
            objectsToShare = [image as AnyObject]
        }
        
        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = CommonFunctions.getTopMostViewController()?.view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        
        CommonFunctions.getTopMostViewController()?.present(activityVC, animated: true, completion: nil)
    }
    
    //TO TAKE SCREENSHOT OF WHOLE SCREEN
    static func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage :UIImage?
        
        if let keyWindow = keyWindow{
            let layer = keyWindow.layer
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(keyWindow.frame.size, false, scale)
            guard let context = UIGraphicsGetCurrentContext() else {return nil}
            layer.render(in:context)
            screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        return screenshotImage
    }
    
    
    static func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
        
        // call AlertController define its buttons and its functions and show it
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: button, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            buttonResult("")
        }
        if(destructive){
            
            let DestructiveAction = UIAlertAction(title: secondButton, style: UIAlertAction.Style.destructive) { (result : UIAlertAction) -> Void in
                secondButtonResult("")
            }
            alertController.addAction(DestructiveAction)
            
        }
        
        alertController.addAction(okAction)
        //    self.presentViewController(alertController, animated: true, completion: nil)
        return alertController
    }
    
    static func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func isValidPassword(_ checkpass:String) -> Bool{
        let passwordCheck = "(?=.*[A-Z])(?=.*[d$@$!%*?&#.><,)/+*(])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let password = NSPredicate(format:"SELF MATCHES %@", passwordCheck)
        return password.evaluate(with: checkpass)
    }
    
    static func isValidPhoneNumber(_ checkphone:String) -> Bool{
        let numberCheck = "^((\\+)|(00))[0-9]{6,14}$"
        let number = NSPredicate(format:"SELF MATCHES %@", numberCheck)
        return number.evaluate(with: checkphone)
    }
    
    // for showing error alert message
    static func showErrorAlert(message: String){
        showAlertWithTitle(title: "Error", message: message, firstBtn: "Close", firstButtonResult: { _ in }, firstBtnStyle: UIAlertAction.Style.cancel, secondBtn: nil, secondButtonResult: { _ in }, secondBtnStyle: UIAlertAction.Style.default)
    }
    
    // for showing any alert message
    static func showAlertWithTitle(title : String?,message : String?, firstBtn: String?, firstButtonResult: @escaping (String)->(), firstBtnStyle: UIAlertAction.Style = UIAlertAction.Style.default, secondBtn: String?, secondButtonResult: @escaping (String)->(), secondBtnStyle: UIAlertAction.Style = UIAlertAction.Style.default) {
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if firstBtn != nil{
            alertVc.addAction(UIAlertAction.init(title: firstBtn!, style: firstBtnStyle, handler: { _ in
                firstButtonResult("")
            }))
        }
        if secondBtn != nil{
            alertVc.addAction(UIAlertAction.init(title: secondBtn!, style: secondBtnStyle, handler: { _ in
                secondButtonResult("")
            }))
        }
        let currentVc = getTopMostViewController()
        currentVc!.present(alertVc, animated: true, completion: nil)
    }
    
    // for removing any alert message currently above screen
    static func removeAlert(){
        let currentVc = getTopMostViewController()
        if currentVc!.isKind(of: UIAlertController.self){
            currentVc?.dismiss(animated: true, completion: nil)
        }
        for subViews in (currentVc?.view.subviews)!{
            if subViews.isKind(of: UIAlertController.self){
                currentVc?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    static func hideLoader(){
        let topView = getTopMostViewController()?.view
        if topView != nil{
            for (num,subView) in topView!.subviews.enumerated(){
                if subView.tag == 111{
                    topView!.subviews[num].removeFromSuperview()
                }
            }
        }
    }
    
    static func hideLoader(_ onView : UIView){
        let topView = onView
        for (num,subView) in topView.subviews.enumerated(){
            if subView.tag == 111{
                topView.subviews[num].removeFromSuperview()
            }
        }
    }
    
    static func showLoader(){
        let topView = getTopMostViewController()?.view
        let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: topView?.frame.width ?? 0, height: topView?.frame.height ?? 0))
        loadingView.backgroundColor = UIColor.black
        loadingView.alpha = 0.6
        let laodingFrame = SpinnerView(frame: CGRect(x: (topView?.frame.width ?? 0)/2 - 20, y: (topView?.frame.height ?? 0)/2 - 20, width: 40, height: 40))
        loadingView.addSubview(laodingFrame)
        loadingView.tag = 111
        var present = false
        if topView != nil{
            for (_,subView) in topView!.subviews.enumerated(){
                if subView.tag == 111 || subView.tag == 191 {
                    present = true
                }
            }
        }
        if !present{
            topView?.addSubview(loadingView)
        }
    }
    
    static func showLoader(_ onView : UIView){
        let topView = onView
        let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: topView.frame.width, height: topView.frame.height))
        loadingView.backgroundColor = UIColor.black
        loadingView.alpha = 0.6
        let laodingFrame = SpinnerView(frame: CGRect(x: topView.frame.width/2 - 20, y: topView.frame.height/2 - 20, width: 40, height: 40))
        loadingView.addSubview(laodingFrame)
        loadingView.tag = 111
        var present = false
        for (_,subView) in topView.subviews.enumerated(){
            if subView.tag == 111 {
                present = true
            }
        }
        if !present{
            topView.addSubview(loadingView)
        }
    }
    
    static func heightForLabel(text:String, width:CGFloat, font : UIFont) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    static func decimalPlaceFromFloat(_ num: Float, decimalPlace: Int) -> String{
        return String(format: "%0.\(decimalPlace)f", num)
    }
    
    static func decimalPlaceFromDouble(_ num: Double, decimalPlace: Int) -> String{
        return String(format: "%0.\(decimalPlace)f", num)
    }
    
    static func decimalPlaceFromString(_ num: String, decimalPlace: Int) -> String{
        return String(format: "%0.\(decimalPlace)f", num)
    }
    
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@!@#$%^"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    static func randomIntWith() -> Int {
        return Int(arc4random_uniform(1000000))
    }
    
    static func convertDateToString(dateString: Date, withFormat format:String, inArabic: Bool? = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        if inArabic ?? true{
            //            (selectedLanguage.code == "en") ? (dateFormatter.locale = Locale(identifier: "en")) : (dateFormatter.locale = Locale(identifier: "ar"))
        }else{
            dateFormatter.locale = Locale(identifier: "en")
        }
        let dt = dateFormatter.string(from: dateString)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateFormatter.date(from: dt)!)
    }
    
    static func convertDateFormater(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        //        (selectedLanguage.code == "en") ? (dateFormatter.locale = Locale(identifier: "en")) : (dateFormatter.locale = Locale(identifier: "ar"))
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "h:mm a"
        return  dateFormatter.string(from: date!)
        
    }
    
    static func getFormattedDate(date: String) -> String {
        let inputFormatter = DateFormatter()
        //        (selectedLanguage.code == "en") ? (inputFormatter.locale = Locale(identifier: "en")) : (inputFormatter.locale = Locale(identifier: "ar"))
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "MMMM dd yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    static func getDateFormat(date: String, format: String, rqrdFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
        //        (selectedLanguage.code == "en") ? (inputFormatter.locale = Locale(identifier: "en")) : (inputFormatter.locale = Locale(identifier: "ar"))
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = rqrdFormat
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    static func headerShadow(view: UIView, color: UIColor, opacity: CGFloat, radius: CGFloat, viewRadii: CGFloat? = nil){
        view.layer.shadowColor = color.withAlphaComponent(opacity).cgColor
        view.clipsToBounds = false
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = radius
        if viewRadii != nil{
            view.layer.cornerRadius = viewRadii!
        }
        //        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
    }
    
    static func authVwShadow(view: UIView){
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 24, height: 24)).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.headerShadowColor.withAlphaComponent(1).cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 4
        view.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    static func autoFlexShadowTwo(demoView: UIView){
        let radius: CGFloat = demoView.frame.width / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: demoView.frame.height))
        //Change 2.1 to amount of spread you need and for height replace the code for height
        
        demoView.layer.cornerRadius = 4
        demoView.layer.shadowColor = UIColor.black.cgColor
        demoView.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
        demoView.layer.shadowOpacity = 0.5
        demoView.layer.shadowRadius = 5.0 //Here your control your blur
        demoView.layer.masksToBounds =  false
        demoView.layer.shadowPath = shadowPath.cgPath
    }
    
    static func drawChart(with data: [ChartDataEntry], on view: LineChartView, gradientColors: [UIColor], lineColor: UIColor){
        view.rightAxis.enabled = false
        view.xAxis.enabled = false
        view.leftAxis.enabled = false
        view.legend.enabled = false
        view.pinchZoomEnabled = false
        view.doubleTapToZoomEnabled = false
        view.scaleXEnabled = false
        view.scaleYEnabled = false
//        view.animate(xAxisDuration: 0.2)
        
        let set1 = LineChartDataSet(entries: data, label: nil)
        set1.mode = .linear
        set1.lineWidth = 1
        set1.drawCirclesEnabled = false
        set1.highlightEnabled = false
        set1.mode = .horizontalBezier
        set1.colors = [lineColor]
        
        let gradientColors = [gradientColors[0].cgColor, gradientColors[1].cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        set1.drawFilledEnabled = true // Draw the Gradient
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        view.data = data
    }
    
    static func drawDetailChart(with data: [ChartDataEntry], on view: LineChartView, gradientColors: [UIColor], lineColor: UIColor){
        view.rightAxis.enabled = false
        view.xAxis.enabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawAxisLineEnabled = false
        view.legend.enabled = false
        view.pinchZoomEnabled = false
        view.doubleTapToZoomEnabled = false
        view.scaleXEnabled = false
        view.scaleYEnabled = false
        view.leftAxis.axisLineColor = .borderColor
        view.leftAxis.labelFont = .MontserratRegular(Size.Medium.sizeValue())
        view.leftAxis.labelTextColor = .primaryTextColor
        
//        let valFormatter = NumberFormatter()
//        valFormatter.numberStyle = .currency
//        valFormatter.maximumFractionDigits = 0
//        valFormatter.currencySymbol = "$"
//        view.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
//
//        view.animate(xAxisDuration: 0.2)
        
        let set1 = LineChartDataSet(entries: data, label: nil)
        set1.mode = .linear
        set1.lineWidth = 1
        set1.drawCirclesEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false // hide horizontal line
        set1.highlightEnabled = true
        set1.mode = .horizontalBezier
        set1.highlightLineDashLengths = [8.0, 4.0]
        set1.highlightLineWidth = 2.0
        set1.highlightColor = lineColor
        set1.colors = [lineColor]
//        set1.circleColors = [lineColor]
//        set1.circleHoleRadius = 0
//        set1.circleRadius = 3.5
//        set1.drawCirclesEnabled = true
        
        let gradientColors = [gradientColors[0].cgColor, gradientColors[1].cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        set1.drawFilledEnabled = true // Draw the Gradient
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        view.data = data
    }
    
    
   static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
   }
    
    static func formattedCurrency(from value: String?) -> String {
        guard value != nil else { return "$0.00" }
        let doubleValue = Double(value!) ?? 0.0
        let formatter = NumberFormatter()
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
//        formatter.locale = .current
        formatter.minimumFractionDigits = ((value!.contains(".00")) || !(value!.contains("."))) ? 0 : 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
    }
    
    static func df2so(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
    
}


extension CommonFunctions{
    static func getImage(_ name : String, quality: Image_Quality) -> String{
        if name == ""{
            return ""
        }else{
            if name.contains("http") || name.contains("fb") || name.contains("google"){
                return name
            }else{
                return ""
                //                return "\(appConstantURL().BASE_URL)local/file?filename=\(name)\(quality.rawValue)"
                //                return "\(appConstantURL().BASE_URL_IMAGE)Uploads/Images/\(quality.rawValue)/\(name)"
            }
        }
    }
}

//MARK: - TO POP VIEW CONTROLLERS

extension UINavigationController {
    
    func  popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
    func hasViewController(ofKind kind: AnyClass) -> UIViewController? {
        return self.viewControllers.first(where: {$0.isKind(of: kind)})
    }
}

//MARK: - TO GET TODAY DATE IN DESIRED FORMAT
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: self)
    }
}
