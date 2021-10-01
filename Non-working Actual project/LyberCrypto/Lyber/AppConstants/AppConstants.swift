
import UIKit


//
//internal var bottomStatusHeight : CGFloat{
//    if UIDevice.isBigIphone{
//        return 34
//    }else{
//        return 4
//    }
//}

// MARK:- TO CHECK IF DEVICE HAS NOTCH (BIG SCREEN DEVICE)
extension UIDevice {
    var hasNotch: Bool {
        let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

internal struct Languages {
    static let Arabic = "ar"
    static let English = "en"
}

// MARK:- METHOD TO GET KEY WINDOW
public var keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }

// MARK:- COLLECTION VIEW CELLS
enum CollectionViewCell : String{
    case walkThroughCell = "WalkThroughCVC"
    case AssetsOptionsCVC = "AssetsOptionsCVC"
    case GraphTypeCVC = "GraphTypeCVC"
    case WatchlistCVC = "WatchlistCVC"
    
    func getValues() -> String{
        return self.rawValue
    }
}

// MARK:- TABLE VIEW CELLS
enum TableViewCell : String{
    case YourAssetsTVC = "YourAssetsTVC"
    case AssetsOptionsTVC = "AssetsOptionsTVC"
    case NotificationsTVC = "NotificationsTVC"
    case InviteTVC = "InviteTVC"
    case NewsTVC = "NewsTVC"
    case NewsListTVC = "NewsListTVC"
    case ToCryptoTVC = "ToCryptoTVC"
    case HeaderTVC = "HeaderTVC"
    case WatchListTVC = "WatchListTVC"
    case AssetsTVC = "AssetsTVC"
    case AllTransactionTVC = "AllTransactionTVC"
    case FriendsTVC = "FriendsTVC"
    case ProfileTVC = "ProfileTVC"
    case NotificationTVC = "NotificationTVC"
    
    func getValues() -> String{
        return self.rawValue
    }
}


// MARK:- ALL APP CONSTANTS
struct k {
    
    // MARK:- DEVICE RELATED CONSTANTS
    struct DeviceInfo {
        static var deviceId: String = UIDevice.current.identifierForVendor?.uuidString ?? NSUUID().uuidString
        static var deviceType: String = "2"
        //        var fcmId : String = userData.shared.fcmId
        static var screenWidth = UIScreen.main.bounds.width // current screen width
        static var screenHeight = UIScreen.main.bounds.height // current screen height
        static var sizeHeight: [CGFloat] = [0.4, 0.6]
        /*
         "sizeHeight" is height and top of bottom sheet coresponding to its parent view, here 1st value is Y coordinate of sheet that is it's top on the screen and 2nd value is bottom sheet's height, so if we want to increase height of bottom sheet we will decrease it's Y coordinate i.e frst value of array and increase the height of sheet i.e 2nd value of array.
        */
    }
    
    // MARK:- SOCIAL MEDIA CONSTANTS LIKE MAPS AND SOCIAL LOGIN
    struct Social {
        static let googleClientKey: String = "AIzaSyAtFdiHYVFJQAJ7fGqifVifqoMzgKbZMvQ"
    }
    
    // MARK:- ALL API KEYS
    struct ApiKeys {
        static let logIn = "Log_in"
    }
    
    // MARK:- ALL ERROR MESSAGES
    struct ErrorMsgs {
        static let PleaseEnterEmail = L10n.PleaseEnterEmail.description
        static let PleaseEnterPassword = L10n.PleaseEnterPassword.description
        static let PleaseEnterValidEmail = L10n.PleaseEnterValidEmail.description
        static let PleaseEnterValidPassword = L10n.PleaseEnterValidPassword.description
        static let PleaseEnterName = L10n.PleaseEnterName.description
        static let PleaseEnterValidName = L10n.PleaseEnterValidName.description
        static let PleaseEnterValidFirstName = L10n.PleaseEnterValidFirstName.description
        static let PleaseEnterValidLastName = L10n.PleaseEnterValidLastName.description
        static let PleaseEnterMobileNum = L10n.PleaseEnterMobileNum.description
        static let PleaseEnterValidMobileNum = L10n.PleaseEnterValidMobileNum.description
        static let PleaseEnterOtp = L10n.PleaseEnterOtp.description
        static let PleaseEnterAccountNum = L10n.PleaseEnterAccountNum.description
        static let PleaseEnterRoutingNum = L10n.PleaseEnterRoutingNum.description
        static let PleaseEnterSsnNum = L10n.PleaseEnterSsnNum.description
        static let PleaseEnterValidSsnNum = L10n.PleaseEnterValidSsnNum.description
        static let PleaseEnterHouseNum = L10n.PleaseEnterHouseNum.description
        static let PleaseSelectLocality = L10n.PleaseSelectLocality.description
        static let PleaseSelectFrontCardPhoto = L10n.PleaseSelectFrontCardPhoto.description
        static let PleaseSelectBackCardPhoto = L10n.PleaseSelectBackCardPhoto.description
        static let PleaseUploadSelfie =  L10n.PleaseUploadSelfie.description
        static let PleaseEnterCurrentPass =  L10n.PleaseEnterCurrentPass.description
        static let PleaseEnterValidPass =  L10n.PleaseEnterValidPass.description
        static let PleaseEnterNewPassword =  L10n.PleaseEnterNewPassword.description
        static let PleaseEnterMessage = L10n.PleaseEnterMessage.description
        static let MinimumAgeRequired = L10n.Minimum_age_required_is_18_years.description
        static let Please_accpt_terms_and_conditions = L10n.Please_accpt_terms_and_conditions.description
        static let Passcode_didnt_matched = L10n.Passcode_didnt_matched.description
        static let PleaseEnterFirstName = L10n.PleaseEnterFirstName.description
        static let PleaseEnterLastName = L10n.PleaseEnterLastName.description
        static let PleaseEnterCardNumber = L10n.PleaseEnterCardNumber.description
        static let PleaseEnterValidCardNumber = L10n.PleaseEnterValidCardNumber.description
        static let PleaseEnterExpiryDate = L10n.PleaseEnterExpiryDate.description
        static let PleaseEnterCVV = L10n.PleaseEnterCVV.description
        static let PleaseEnterValidCVV = L10n.PleaseEnterValidCVV.description
        static let PleaseEnterValidExpiryDate = L10n.PleaseEnterValidExpiryDate.description
        static let PleaseEnterFullName = L10n.PleaseEnterFullName.description
        static let PleaseEnterValidFullName = L10n.PleaseEnterValidFullName.description
        static let PleaseSelectCitizenship = L10n.PleaseSelectCitizenship.description
        static let PleaseEnterCity = L10n.PleaseEnterCity.description
        static let PleaseEnterValidCity = L10n.PleaseEnterValidCity.description
        static let PleaseEnterZip = L10n.PleaseEnterZip.description
        static let PleaseEnterValidZip = L10n.PleaseEnterValidZip.description
        static let PleaseeSelectDOB = L10n.PleaseeSelectDOB.description
        static let PleaseEnterValidNewPassword = L10n.PleaseEnterValidNewPassword.description
        static let PleaseEnterSubject = L10n.PleaseEnterSubject.description
        static let PleaseEnterAddress = L10n.PleaseEnterAddress.description
        static let PleaseEnterPostalCode = L10n.PleaseEnterPostalCode.description
        
    }
    
}
