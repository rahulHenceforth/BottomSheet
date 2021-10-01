//
//  LocalizationKeys.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 25/08/21.
//

import Foundation

// MARK:- Language key enum
enum L10n {
    
    // MARK:-  Walkthrough Screens
    case Skip
    case Next
    case Back
    case Login
    case LOGIN
    case SIGN_Up
    case Sign_Up
    case Splash_Content_1
    case Splash_Sub_Content_1_1
    case Splash_Sub_Content_1_2
    case Splash_Sub_Content_1_3
    case Splash_Sub_Content_1_4
    case Splash_Content_2
    case Splash_Sub_Content_2_1
    case Splash_Content_3
    case Splash_Sub_Content_3_1
    case Splash_Sub_Content_3_2
    case Splash_Content_4
    case Splash_Sub_Content_4_1
    case Splash_Sub_Content_4_2
    case Splash_Sub_Content_4_3
    case Splash_Sub_Content_4_4
    case Splash_Content_5
    case Splash_Sub_Content_5_1
    case Splash_Sub_Content_5_2
    case Splash_Sub_Content_5_3
    case Splash_Sub_Content_5_4
    
    // MARK:- LogIn Screen
    case Welcome_Back
    case Email_address
    case Password
    case Forgot_your_password
    case Dont_have_an_account
    case Forgot_Password
    case Forgot_Password_Desc
    case Reset_Password
    case Check_Your_Email
    case Check_Your_Email_Desc
    case Back_to_Login
    case Verification
    case Verification_Desc
    case Promo_Code
    case Current_Pin
    case New_Pin
    case Confirm_Pin
    
    // MARK:- SignUp Screen
    case Create_Account
    case First_Name
    case Last_Name
    case Lets_Get_Started
    case Already_have_an_account
    
    // MARK:- Email verification screen
    case Email_Verification
    case Email_verification_desc1
    case Email_verification_desc2
    case Next_Step

    // MARK:- Enter Mobile number screen
    case Enter_Phone_No
    case Mobile_no
    case SUBMIT_CAPS
    case Phone_no
    case Enter_Phone_Desc
    case Profile_phone_desc
    
    
    // MARK:- Enter Otp screen
    case Verify_Number
    case Verify_Number_Desc
    
    
    // MARK:- Add bank account screen
    case Add_Bank_Account
    case Add_Bank_Account_Desc
    case Name_On_Card
    case Card_Number
    case CVV
    case Expiry
    case AccountNum
    case RoutingNum
    case Address
    case PostalCode
    
    // MARK:- Verification In Progress
    case Welcome_to_Lyber
    case Welcome_to_lyber_desc
    case Verification_in_progress
    case Start_Profile_Verification
    case Welcome_to_lyber_desc2
    case Welcome_to_lyber_desc3
    
    // MARK:- Open your account screen
    case Open_your_secure_account
    case Open_your_secure_account_desc
    case Residential_Address
    case Investment_Experience
    case Identity_Verification
    case I_agree_with_the
    case Terms_of_Use
    case and_the
    case Privacy_Policy
    
    // MARK:- Personal Info
    case Personal_Information
    case Full_Name
    case Citizenship
    case City
    case ZIP_Area_code
    case Date_of_Birth
    case Select_Date
    case DONE
    case CANCEL
    
    // MARK:- Investment Experience
    case Investment_Experience_Desc
    case Investement_Expereince_SubTitle1
    case Investement_Expereince_SubTitle2
    case Investement_Expereince_SubTitle3
    case Investement_Expereince_SubTitle4
    case Please_Select
    
    // MARK:- Document Verification
    case Document_Verification
    case Document_Verification_Desc
    case Passport
    case Driving_License
    case Identity_Card
    case Residence_Permit
    case Scan_Front_Side
    case Scan_Back_Side
    case Scan_Now
    case Scan_Desc
    case Take_Selfie
    case Take_Selfie_Desc
    
    
    // MARK:- Enter Adress Screen
    case Enter_Address
    case House_Flat_no
    case Enter_locality
    
    // MARK:- Upload documents screen
    case Upload_ID_Proof
    case UPLOAD_PHOTO_CAPS
    case Upload_photo_description
    case Upload_photo_option1
    case Upload_photo_option2
    case Upload_photo_option3
    case Upload_photo_option4
    case Upload_photo_description2
    case Front_card_photo
    case Back_card_photo
    case UPLOAD_CAPS
    case RETAKE
    
    // MARK:- Upload selfie screen
//    case Take_Selfie
    case Please_Upload_Your_Selfie
    
    // MARK:- Sign up complete
    case Sign_Up_Complete
    case Sign_up_Complete_Desc
    
    
    // MARK:- Forgot Pass
    case Forgotten_your_password
    case Please_Enter_Your_Email
    case SEND_RESET_LINK

    
    // MARK:- PROFILE SCREEN
    case Phone_Number
    case Update_Address
    case Linked_Bank_Account
    case Security
    case Contact_Us
    case Log_Out
    case BACK_TO_PROFILE
    case Well_Done
    case Profile_Change_Desc
    case Current_Phone_Number
    case Countries
    case Card_Details
    case Card_Details_Desc
    
    // MARK:- Edit profile screen
    case SAVE_CHANGES
    case English
    case French
    case Change_Language_Description
    case Yes
    case No
    case Current_Password
    case New_Password
    case Message
    case LogOut_Description
    case Cancel
    case Subject
    case Send_Message
    case Edit_Profile
    
    // MARK:- Home screen
    case Total_Balance
    case Deposit_Funds
    case Assets_Cash
    case Your_Assets
    case News
    case Bitcoin
    case Litecoin
    case Ethereum
    case Euro
    case BTC
    case EUR
    case ETH
    case Earn_up_to_€50_in_LYB_tokens
    case Invite_your_friends
    case Weekly_Newsletter
    case Chose_Payment_method
    case Chose_Withdrawal_method
    case Credit_Card
    case Wire_deposit
    case or
    case Earn_LYB_Tokens
    case Earn_LYB_Tokens_Desc1
    case Earn_LYB_Tokens_Desc2
    case Share_Your_Invite_Link
    case Copy
    case Terms_Conditions
    case Share
    case Notifications
    
    // MARK:- Portfolio Screen
    case ADD
    case WITHDRAW
    case SELL
    case Add_Money
    case Add_Money_Desc
    case Select_Card
    case Add_Card
    
    // MARK:- Coin detail screen
    case Wallet_Balance
    case High
    case Low
    case D
    case M
    case Y
    case W
    case All
    case Buy
    case Sell
    case Deposit
    case Exchange
    case You_successfully_bought
    case You_successfully_sold
    case You_successfully_exchange
    case You_successfully_Sent
    case CONTINUE
    case Updated_Balance
    case To_Crypto
    case I_have
    case I_want
    case No_of_tokens
    
    // MARK:- MARKET PLACE SCREEN
    case Watchlists
    case Assets
    case Transactions_type
    case Select_All
    case Clear_All
    case Deposited
    case Withdrawn
    case Withdraw
    case Sent
    case Exchanged
    case All_Transactions
    
    // MARK:- TRansaction screen
    case Transaction_Details
    case Date
    case Time
    case Total_amount
    case Total_amount_€
    case Withdraw_fee
    case Status
    case Transaction_ID
    case From
    case To
    case Transaction_confirmed
    case Back_to_Wallet
    case Friends
    case External_Wallet
    
    // MARK:- SEND
    case Send_Bitcoin
    case Phone_No
    case BTC_Available
    case Send_Desc
    case Send_Desc2
    case Send
    case Email
    case Send_To_Your_Friend
    case Confirm_your_transaction
    case Recepient
    case Amount
    case Amount_€
    case CONFIRM
    case Wallet_Address
    case Enter_wallet_address
    case Get_Wallet_Addres_Below
    case SCAN_QR_Code
    
    // MARK:- CHANGE PASSWORD
    case Change_Password
    case Current_password
    case New_password
    
    // MARK:- Error Messages
    case PleaseEnterEmail
    case PleaseEnterPassword
    case PleaseEnterValidEmail
    case PleaseEnterValidPassword
    case PleaseEnterValidNewPassword
    case PleaseEnterName
    case PleaseEnterFullName
    case PleaseEnterFirstName
    case PleaseEnterLastName
    case PleaseEnterValidFullName
    case PleaseEnterValidName
    case PleaseEnterValidFirstName
    case PleaseEnterValidLastName
    case PleaseEnterMobileNum
    case PleaseEnterValidMobileNum
    case PleaseEnterOtp
    case PleaseEnterAccountNum
    case PleaseEnterCardNumber
    case PleaseEnterValidCardNumber
    case PleaseEnterExpiryDate
    case PleaseEnterValidExpiryDate
    case PleaseEnterCVV
    case PleaseEnterValidCVV
    case PleaseSelectCitizenship
    case PleaseEnterCity
    case PleaseEnterValidCity
    case PleaseEnterZip
    case PleaseEnterValidZip
    case PleaseeSelectDOB
    case PleaseEnterRoutingNum
    case PleaseEnterSsnNum
    case PleaseEnterValidSsnNum
    case PleaseEnterHouseNum
    case PleaseSelectLocality
    case PleaseSelectFrontCardPhoto
    case PleaseSelectBackCardPhoto
    case PleaseUploadSelfie
    case PleaseEnterCurrentPass
    case PleaseEnterValidPass
    case PleaseEnterNewPassword
    case PleaseEnterMessage
    case Minimum_age_required_is_18_years
    case Please_accpt_terms_and_conditions
    case Passcode_didnt_matched
    case PleaseEnterSubject
    case PleaseEnterAddress
    case PleaseEnterPostalCode
    
}




extension L10n: CustomStringConvertible{
    var description: String{ return self.string }
    
    var string: String{
        switch self {
        case .Skip:
            return L10n.tr("Skip")
        case .Next:
            return L10n.tr("Next")
        case .Back:
            return L10n.tr("Back")
        case .Login:
            return L10n.tr("Login")
        case .LOGIN:
            return L10n.tr("LOGIN")
        case .SIGN_Up:
            return L10n.tr("SIGN_Up")
        case .Sign_Up:
            return L10n.tr("Sign_Up")
        case .Splash_Content_1:
            return L10n.tr("Splash_Content_1")
        case .Splash_Sub_Content_1_1:
            return L10n.tr("Splash_Sub_Content_1_1")
        case .Splash_Sub_Content_1_2:
            return L10n.tr("Splash_Sub_Content_1_2")
        case .Splash_Sub_Content_1_3:
            return L10n.tr("Splash_Sub_Content_1_3")
        case .Splash_Sub_Content_1_4:
            return L10n.tr("Splash_Sub_Content_1_4")
        case .Splash_Content_2:
            return L10n.tr("Splash_Content_2")
        case .Splash_Sub_Content_2_1:
            return L10n.tr("Splash_Sub_Content_2_1")
        case .Splash_Content_3:
            return L10n.tr("Splash_Content_3")
        case .Splash_Sub_Content_3_1:
            return L10n.tr("Splash_Sub_Content_3_1")
        case .Splash_Sub_Content_3_2:
            return L10n.tr("Splash_Sub_Content_3_2")
        case .Splash_Content_4:
            return L10n.tr("Splash_Content_4")
        case .Splash_Sub_Content_4_1:
            return L10n.tr("Splash_Sub_Content_4_1")
        case .Splash_Sub_Content_4_2:
            return L10n.tr("Splash_Sub_Content_4_2")
        case .Splash_Sub_Content_4_3:
            return L10n.tr("Splash_Sub_Content_4_3")
        case .Splash_Sub_Content_4_4:
            return L10n.tr("Splash_Sub_Content_4_4")
        case .Splash_Content_5:
            return L10n.tr("Splash_Content_5")
        case .Splash_Sub_Content_5_1:
            return L10n.tr("Splash_Sub_Content_5_1")
        case .Splash_Sub_Content_5_2:
            return L10n.tr("Splash_Sub_Content_5_2")
        case .Splash_Sub_Content_5_3:
            return L10n.tr("Splash_Sub_Content_5_3")
        case .Splash_Sub_Content_5_4:
            return L10n.tr("Splash_Sub_Content_5_4")
      
        case .Welcome_Back:
            return L10n.tr("Welcome_Back")
        case .Email_address:
            return L10n.tr("Email_address")
        case .Password:
            return L10n.tr("Password")
        case .Forgot_your_password:
            return L10n.tr("Forgot_your_password")
        case .Dont_have_an_account:
            return L10n.tr("Dont_have_an_account")
        case .Forgot_Password:
            return L10n.tr("Forgot_Password")
        case .Forgot_Password_Desc:
            return L10n.tr("Forgot_Password_Desc")
        case .Reset_Password:
            return L10n.tr("Reset_Password")
        case .Email_Verification:
            return L10n.tr("Email_Verification")
        case .Email_verification_desc1:
            return L10n.tr("Email_verification_desc1")
        case .Email_verification_desc2:
            return L10n.tr("Email_verification_desc2")
        case .Next_Step:
            return L10n.tr("Next_Step")
        case .Check_Your_Email:
            return L10n.tr("Check_Your_Email")
        case .Check_Your_Email_Desc:
            return L10n.tr("Check_Your_Email_Desc")
        case .Back_to_Login:
            return L10n.tr("Back_to_Login")
        case .Verification:
            return L10n.tr("Verification")
        case .Verification_Desc:
            return L10n.tr("Verification_Desc")
        case .Promo_Code:
            return L10n.tr("Promo_Code")
        case .Current_Pin:
            return L10n.tr("Current_Pin")
        case .New_Pin:
            return L10n.tr("New_Pin")
        case .Confirm_Pin:
            return L10n.tr("Confirm_Pin")
            
        case .Create_Account:
            return L10n.tr("Create_Account")
        case .First_Name:
            return L10n.tr("First_Name")
        case .Last_Name:
            return L10n.tr("Last_Name")
        case .Lets_Get_Started:
            return L10n.tr("Lets_Get_Started")
        case .Already_have_an_account:
            return L10n.tr("Already_have_an_account")
            
        
        case .Enter_Phone_No:
            return L10n.tr("Enter_Phone_No")
        case .Mobile_no:
            return L10n.tr("Mobile_no")
        case .SUBMIT_CAPS:
            return L10n.tr("SUBMIT_CAPS")
        case .Phone_no:
            return L10n.tr("Phone_no")
        case .Enter_Phone_Desc:
            return L10n.tr("Enter_Phone_Desc")
        case .Profile_phone_desc:
            return L10n.tr("Profile_phone_desc")
            
        case .Verify_Number:
            return L10n.tr("Verify_Number")
        case .Verify_Number_Desc:
            return L10n.tr("Verify_Number_Desc")
        
        case .Add_Bank_Account:
            return L10n.tr("Add_Bank_Account")
        case .Add_Bank_Account_Desc:
            return L10n.tr("Add_Bank_Account_Desc")
        case .Name_On_Card:
            return L10n.tr("Name_On_Card")
        case .Card_Number:
            return L10n.tr("Card_Number")
        case .CVV:
            return L10n.tr("CVV")
        case .Expiry:
            return L10n.tr("Expiry")
        case .AccountNum:
            return L10n.tr("AccountNum")
        case .RoutingNum:
            return L10n.tr("RoutingNum")
        case .Address:
            return L10n.tr("Address")
        case .PostalCode:
            return L10n.tr("PostalCode")
            
        case .Welcome_to_Lyber:
            return L10n.tr("Welcome_to_Lyber")
        case .Welcome_to_lyber_desc:
            return L10n.tr("Welcome_to_lyber_desc")
        case .Welcome_to_lyber_desc2:
            return L10n.tr("Welcome_to_lyber_desc2")
        case .Welcome_to_lyber_desc3:
            return L10n.tr("Welcome_to_lyber_desc3")
        case .Start_Profile_Verification:
            return L10n.tr("Start_Profile_Verification")
        case .Verification_in_progress:
            return L10n.tr("Verification_in_progress")
            
        case .Open_your_secure_account:
            return L10n.tr("Open_your_secure_account")
        case .Open_your_secure_account_desc:
            return L10n.tr("Open_your_secure_account_desc")
        case .Residential_Address:
            return L10n.tr("Residential_Address")
        case .Investment_Experience:
            return L10n.tr("Investment_Experience")
        case .Identity_Verification:
            return L10n.tr("Identity_Verification")
        case .I_agree_with_the:
            return L10n.tr("I_agree_with_the")
        case .Terms_of_Use:
            return L10n.tr("Terms_of_Use")
        case .and_the:
            return L10n.tr("and_the")
        case .Privacy_Policy:
            return L10n.tr("Privacy_Policy")
            
        case .Personal_Information:
            return L10n.tr("Personal_Information")
        case .Full_Name:
            return L10n.tr("Full_Name")
        case .Citizenship:
            return L10n.tr("Citizenship")
        case .City:
            return L10n.tr("City")
        case .ZIP_Area_code:
            return L10n.tr("ZIP_Area_code")
        case .Date_of_Birth:
            return L10n.tr("Date_of_Birth")
        case .Select_Date:
            return L10n.tr("Select_Date")
        case .DONE:
            return L10n.tr("DONE")
        case .CANCEL:
            return L10n.tr("CANCEL")
        
        case .Investment_Experience_Desc:
            return L10n.tr("Investment_Experience_Desc")
        case .Investement_Expereince_SubTitle1:
            return L10n.tr("Investement_Expereince_SubTitle1")
        case .Investement_Expereince_SubTitle2:
            return L10n.tr("Investement_Expereince_SubTitle2")
        case .Investement_Expereince_SubTitle3:
            return L10n.tr("Investement_Expereince_SubTitle3")
        case .Investement_Expereince_SubTitle4:
            return L10n.tr("Investement_Expereince_SubTitle4")
        case .Please_Select:
            return L10n.tr("Please_Select")
            
        case .Document_Verification:
            return L10n.tr("Document_Verification")
        case .Document_Verification_Desc:
            return L10n.tr("Document_Verification_Desc")
        case .Passport:
            return L10n.tr("Passport")
        case .Driving_License:
            return L10n.tr("Driving_License")
        case .Identity_Card:
            return L10n.tr("Identity_Card")
        case .Residence_Permit:
            return L10n.tr("Residence_Permit")
        case .Scan_Front_Side:
            return L10n.tr("Scan_Front_Side")
        case .Scan_Back_Side:
            return L10n.tr("Scan_Back_Side")
        case .Scan_Now:
            return L10n.tr("Scan_Now")
        case .Scan_Desc:
            return L10n.tr("Scan_Desc")
        case .Take_Selfie:
            return L10n.tr("Take_Selfie")
        case .Take_Selfie_Desc:
            return L10n.tr("Take_Selfie_Desc")
            
        case .Enter_Address:
            return L10n.tr("Enter_Address")
        case .House_Flat_no:
            return L10n.tr("House_Flat_no")
        case .Enter_locality:
            return L10n.tr("Enter_locality")
            
        case .Upload_ID_Proof:
            return L10n.tr("Upload_ID_Proof")
        case .UPLOAD_PHOTO_CAPS:
            return L10n.tr("UPLOAD_PHOTO_CAPS")
        case .Upload_photo_description:
            return L10n.tr("Upload_photo_description")
        case .Upload_photo_option1:
            return L10n.tr("Upload_photo_option1")
        case .Upload_photo_option2:
            return L10n.tr("Upload_photo_option2")
        case .Upload_photo_option3:
            return L10n.tr("Upload_photo_option3")
        case .Upload_photo_option4:
            return L10n.tr("Upload_photo_option4")
        case .Upload_photo_description2:
            return L10n.tr("Upload_photo_description2")
        case .Front_card_photo:
            return L10n.tr("Front_card_photo")
        case .Back_card_photo:
            return L10n.tr("Back_card_photo")
        case .UPLOAD_CAPS:
            return L10n.tr("UPLOAD_CAPS")
        case .RETAKE:
            return L10n.tr("RETAKE")
            
    
        case .Please_Upload_Your_Selfie:
            return L10n.tr("Please_Upload_Your_Selfie")
            
        case .Sign_Up_Complete:
            return L10n.tr("Sign_Up_Complete")
        case .Sign_up_Complete_Desc:
            return L10n.tr("Sign_up_Complete_Desc")
        
        case .Forgotten_your_password:
            return L10n.tr("Forgotten_your_password")
        case .Please_Enter_Your_Email:
            return L10n.tr("Please_Enter_Your_Email")
        case .SEND_RESET_LINK:
            return L10n.tr("SEND_RESET_LINK")
            
            
        case .Phone_Number:
            return L10n.tr("Phone_Number")
        case .Update_Address:
            return L10n.tr("Update_Address")
        case .Linked_Bank_Account:
            return L10n.tr("Linked_Bank_Account")
        case .Security:
            return L10n.tr("Security")
        case .Contact_Us:
            return L10n.tr("Contact_Us")
        case .Log_Out:
            return L10n.tr("Log_Out")
        case .BACK_TO_PROFILE:
            return L10n.tr("BACK_TO_PROFILE")
        case .Well_Done:
            return L10n.tr("Well_Done")
        case .Profile_Change_Desc:
            return L10n.tr("Profile_Change_Desc")
        case .Current_Phone_Number:
            return L10n.tr("Current_Phone_Number")
        case .Countries:
            return L10n.tr("Countries")
        case .Card_Details:
            return L10n.tr("Card_Details")
        case .Card_Details_Desc:
            return L10n.tr("Card_Details_Desc")
            
        case .SAVE_CHANGES:
            return L10n.tr("SAVE_CHANGES")
        case .English:
            return L10n.tr("English")
        case .French:
            return L10n.tr("French")
        case .Change_Language_Description:
            return L10n.tr("Change_Language_Description")
        case .Yes:
            return L10n.tr("Yes")
        case .No:
            return L10n.tr("No")
        case .Current_Password:
            return L10n.tr("Current_Password")
        case .New_Password:
            return L10n.tr("New_Password")
        case .Message:
            return L10n.tr("Message")
        case .LogOut_Description:
            return L10n.tr("LogOut_Description")
        case .Cancel:
            return L10n.tr("Cancel")
        case .Subject:
            return L10n.tr("Subject")
        case .Send_Message:
            return L10n.tr("Send_Message")
        case .Edit_Profile:
            return L10n.tr("Edit_Profile")
        
        case .Bitcoin:
            return L10n.tr("Bitcoin")
        case .Litecoin:
            return L10n.tr("Litecoin")
        case .Ethereum:
            return L10n.tr("Ethereum")
        case .Euro:
            return L10n.tr("Euro")
        case .BTC:
            return L10n.tr("BTC")
        case .EUR:
            return L10n.tr("EUR")
        case .ETH:
            return L10n.tr("ETH")
        case .Total_Balance:
            return L10n.tr("Total_Balance")
        case .Deposit_Funds:
            return L10n.tr("Deposit_Funds")
        case .Assets_Cash:
            return L10n.tr("Assets_Cash")
        case .Your_Assets:
            return L10n.tr("Your_Assets")
        case .News:
            return L10n.tr("News")
        case .Earn_up_to_€50_in_LYB_tokens:
            return L10n.tr("Earn_up_to_€50_in_LYB_tokens")
        case .Invite_your_friends:
            return L10n.tr("Invite_your_friends")
        case .Weekly_Newsletter:
            return L10n.tr("Weekly_Newsletter")
        case .Chose_Payment_method:
            return L10n.tr("Chose_Payment_method")
        case .Chose_Withdrawal_method:
            return L10n.tr("Chose_Withdrawal_method")
        case .Credit_Card:
            return L10n.tr("Credit_Card")
        case .Wire_deposit:
            return L10n.tr("Wire_deposit")
        case .or:
            return L10n.tr("or")
        case .Earn_LYB_Tokens:
            return L10n.tr("Earn_LYB_Tokens")
        case .Earn_LYB_Tokens_Desc1:
            return L10n.tr("Earn_LYB_Tokens_Desc1")
        case .Earn_LYB_Tokens_Desc2:
            return L10n.tr("Earn_LYB_Tokens_Desc2")
        case .Share_Your_Invite_Link:
            return L10n.tr("Share_Your_Invite_Link")
        case .Copy:
            return L10n.tr("Copy")
        case .Terms_Conditions:
            return L10n.tr("Terms_Conditions")
        case .Share:
            return L10n.tr("Share")
        case .Notifications:
            return L10n.tr("Notifications")
            
            
        case .Wallet_Balance:
            return L10n.tr("Wallet_Balance")
        case .ADD:
            return L10n.tr("ADD")
        case .WITHDRAW:
            return L10n.tr("WITHDRAW")
        case .D:
            return L10n.tr("D")
        case .M:
            return L10n.tr("M")
        case .Y:
            return L10n.tr("Y")
        case .W:
            return L10n.tr("W")
        case .All:
            return L10n.tr("All")
        case .SELL:
            return L10n.tr("SELL")
        case .Add_Money:
            return L10n.tr("Add_Money")
        case .Add_Money_Desc:
            return L10n.tr("Add_Money_Desc")
        case .Select_Card:
            return L10n.tr("Add_Money_Desc")
        case .Add_Card:
            return L10n.tr("Add_Card")
        case .High:
            return L10n.tr("High")
        case .Low:
            return L10n.tr("Low")
        case .Buy:
            return L10n.tr("Buy")
        case .Sell:
            return L10n.tr("Sell")
        case .Deposit:
            return L10n.tr("Deposit")
        case .Exchange:
            return L10n.tr("Exchange")
        case .You_successfully_bought:
            return L10n.tr("You_successfully_bought")
        case .You_successfully_sold:
            return L10n.tr("You_successfully_sold")
        case .You_successfully_exchange:
            return L10n.tr("You_successfully_exchange")
        case .You_successfully_Sent:
            return L10n.tr("You_successfully_Sent")
        case .CONTINUE:
            return L10n.tr("CONTINUE")
        case .Updated_Balance:
            return L10n.tr("Updated_Balance")
        case .To_Crypto:
            return L10n.tr("To_Crypto")
        case .I_have:
            return L10n.tr("I_have")
        case .I_want:
            return L10n.tr("I_want")
        case .No_of_tokens:
            return L10n.tr("No_of_tokens")
            
        case .Watchlists:
            return L10n.tr("Watchlists")
        case .Assets:
            return L10n.tr("Assets")
        case .Transactions_type:
            return L10n.tr("Transactions_type")
        case .Select_All:
            return L10n.tr("Select_All")
        case .Clear_All:
            return L10n.tr("Clear_All")
        case .Deposited:
            return L10n.tr("Deposited")
        case .Withdrawn:
            return L10n.tr("Withdrawn")
        case .Withdraw:
            return L10n.tr("Withdraw")
        case .Sent:
            return L10n.tr("Sent")
        case .Exchanged:
            return L10n.tr("Exchanged")
        case .All_Transactions:
            return L10n.tr("All_Transactions")
            
        case .Transaction_Details:
            return L10n.tr("Transaction_Details")
        case .Date:
            return L10n.tr("Date")
        case .Time:
            return L10n.tr("Time")
        case .Total_amount:
            return L10n.tr("Total_amount")
        case .Total_amount_€:
            return L10n.tr("Total_amount_€")
        case .Withdraw_fee:
            return L10n.tr("Withdraw_fee")
        case .Status:
            return L10n.tr("Status")
        case .Transaction_ID:
            return L10n.tr("Transaction_ID")
        case .From:
            return L10n.tr("From")
        case .To:
            return L10n.tr("To")
        case .Transaction_confirmed:
            return L10n.tr("Transaction_confirmed")
        case .Back_to_Wallet:
            return L10n.tr("Back_to_Wallet")
        case .Friends:
            return L10n.tr("Friends")
        case .External_Wallet:
            return L10n.tr("External_Wallet")
            
        case .Send_Bitcoin:
            return L10n.tr("Send_Bitcoin")
        case .Phone_No:
            return L10n.tr("Phone_No")
        case .BTC_Available:
            return L10n.tr("BTC_Available")
        case .Send_Desc:
            return L10n.tr("Send_Desc")
        case .Send_Desc2:
            return L10n.tr("Send_Desc2")
        case .Send:
            return L10n.tr("Send")
        case .Email:
            return L10n.tr("Email")
        case .Send_To_Your_Friend:
            return L10n.tr("Send_To_Your_Friend")
        case .Confirm_your_transaction:
            return L10n.tr("Confirm_your_transaction")
        case .Recepient:
            return L10n.tr("Recepient")
        case .Amount:
            return L10n.tr("Amount")
        case .Amount_€:
            return L10n.tr("Amount_€")
        case .CONFIRM:
            return L10n.tr("CONFIRM")
        case .Wallet_Address:
            return L10n.tr("Wallet_Address")
        case .Enter_wallet_address:
            return L10n.tr("Enter_wallet_address")
        case .Get_Wallet_Addres_Below:
            return L10n.tr("Get_Wallet_Addres_Below")
        case .SCAN_QR_Code:
            return L10n.tr("SCAN_QR_Code")
            
        case .Change_Password:
            return L10n.tr("Change_Password")
        case .Current_password:
            return L10n.tr("Current_password")
        case .New_password:
            return L10n.tr("New_password")

            
        case .PleaseEnterEmail:
            return L10n.tr("PleaseEnterEmail")
        case .PleaseEnterPassword:
            return L10n.tr("PleaseEnterPassword")
        case .PleaseEnterValidEmail:
            return L10n.tr("PleaseEnterValidEmail")
        case .PleaseEnterValidPassword:
            return L10n.tr("PleaseEnterValidPassword")
        case .PleaseEnterValidNewPassword:
            return L10n.tr("PleaseEnterValidNewPassword")
        case .PleaseEnterName:
            return L10n.tr("PleaseEnterName")
        case .PleaseEnterFullName:
            return L10n.tr("PleaseEnterFullName")
        case .PleaseEnterFirstName:
            return L10n.tr("PleaseEnterFirstName")
        case .PleaseEnterLastName:
            return L10n.tr("PleaseEnterLastName")
        case .PleaseEnterValidName:
            return L10n.tr("PleaseEnterValidName")
        case .PleaseEnterValidFirstName:
            return L10n.tr("PleaseEnterValidFirstName")
        case .PleaseEnterValidLastName:
            return L10n.tr("PleaseEnterValidLastName")
        case .PleaseEnterMobileNum:
            return L10n.tr("PleaseEnterMobileNum")
        case .PleaseEnterValidMobileNum:
            return L10n.tr("PleaseEnterValidMobileNum")
        case .PleaseEnterOtp:
            return L10n.tr("PleaseEnterOtp")
        case .PleaseEnterAccountNum:
            return L10n.tr("PleaseEnterAccountNum")
        case .PleaseEnterCardNumber:
            return L10n.tr("PleaseEnterCardNumber")
        case .PleaseEnterValidCardNumber:
            return L10n.tr("PleaseEnterValidCardNumber")
        case .PleaseEnterExpiryDate:
            return L10n.tr("PleaseEnterExpiryDate")
        case .PleaseEnterValidExpiryDate:
            return L10n.tr("PleaseEnterValidExpiryDate")
        case .PleaseEnterCVV:
            return L10n.tr("PleaseEnterCVV")
        case .PleaseEnterValidCVV:
            return L10n.tr("PleaseEnterValidCVV")
        case .PleaseEnterRoutingNum:
            return L10n.tr("PleaseEnterRoutingNum")
        case .PleaseEnterSsnNum:
            return L10n.tr("PleaseEnterSsnNum")
        case .PleaseEnterValidSsnNum:
            return L10n.tr("PleaseEnterValidSsnNum")
        case .PleaseEnterHouseNum:
            return L10n.tr("PleaseEnterHouseNum")
        case .PleaseSelectLocality:
            return L10n.tr("PleaseSelectLocality")
        case .PleaseSelectFrontCardPhoto:
            return L10n.tr("PleaseSelectFrontCardPhoto")
        case .PleaseSelectBackCardPhoto:
            return L10n.tr("PleaseSelectBackCardPhoto")
        case .PleaseUploadSelfie:
            return L10n.tr("PleaseUploadSelfie")
        case .PleaseEnterCurrentPass:
            return L10n.tr("PleaseEnterCurrentPass")
        case .PleaseEnterValidPass:
            return L10n.tr("PleaseEnterValidPass")
        case .PleaseEnterNewPassword:
            return L10n.tr("PleaseEnterNewPassword")
        case .PleaseEnterMessage:
            return L10n.tr("PleaseEnterMessage")
        case .Minimum_age_required_is_18_years:
            return L10n.tr("Minimum_age_required_is_18_years")
        case .Please_accpt_terms_and_conditions:
            return L10n.tr("Please_accpt_terms_and_conditions")
        case .Passcode_didnt_matched:
            return L10n.tr("Passcode_didnt_matched")
        case .PleaseEnterValidFullName:
            return L10n.tr("PleaseEnterValidFullName")
        case .PleaseSelectCitizenship:
            return L10n.tr("PleaseSelectCitizenship")
        case .PleaseEnterCity:
            return L10n.tr("PleaseEnterCity")
        case .PleaseEnterValidCity:
            return L10n.tr("PleaseEnterValidCity")
        case .PleaseEnterZip:
            return L10n.tr("PleaseEnterZip")
        case .PleaseEnterValidZip:
            return L10n.tr("PleaseEnterValidZip")
        case .PleaseeSelectDOB:
            return L10n.tr("PleaseeSelectDOB")
        case .PleaseEnterSubject:
            return L10n.tr("PleaseEnterSubject")
        case .PleaseEnterAddress:
            return L10n.tr("PleaseEnterAddress")
        case .PleaseEnterPostalCode:
            return L10n.tr("PleaseEnterPostalCode")
        
        
        }
    }
    
    private static func tr(_ key: String, _ args: CVarArg...) -> String{
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, locale: NSLocale.current , arguments: args)
//        if selectedLanguage.code == "en"{
//            return keyValEng[key] ?? ""
//        }else{
//            return keyValAr[key] ?? ""
//        }
    }
}
