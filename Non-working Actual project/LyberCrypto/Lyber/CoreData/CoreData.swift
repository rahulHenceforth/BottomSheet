//
//  CoreData.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 16/09/21.
//

import Foundation
import UIKit
import CoreData

class CoreData: NSObject{
    
    private let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let entityName = User.entity().name ?? ""
    
    class var shared: CoreData{
        struct singleTon {
            static let instance = CoreData()
        }
        return singleTon.instance
    }
    
//    var id = 0
//    var name = ""
//    var profile_Image = ""
//    var email = ""
//    var country_Code = ""
//    var phone = 0
//    var lat = 0.0
//    var lng = 0.0
//    var last_Lat = 0.0
//    var last_Lng = 0.0
//    var fcm_ID = ""
//    var isEmail_Verified = 0
//    var isPhone_Verifed = 0
//    var stripe_Customer_ID = ""
//    var update = 0
//    var access_Token = ""
//    var stripe_acnt_id = ""
//    var available_Credits = 0.0
    
    
    func dataSave(){
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName))
        do {
            try self.context.execute(DelAllReqVar)
        } catch {
            print(error)
        }
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context)
//        newData.setValue(access_Token, forKey: "accessToken")
//        newData.setValue(name, forKey: "name")
//        newData.setValue(id, forKey: "id")
//        newData.setValue(fcm_ID, forKey: "fcmID")
//        newData.setValue(email, forKey: "email")
//        newData.setValue(profile_Image, forKey: "profileImage")
//        newData.setValue(isEmail_Verified, forKey: "isEmailVerified")
//        newData.setValue(isPhone_Verifed, forKey: "isPhoneVerifed")
//        newData.setValue(stripe_Customer_ID, forKey: "stripeCustomerID")
//        newData.setValue(country_Code, forKey: "countryCode")
//        newData.setValue(phone, forKey: "phone")
//        newData.setValue(lat, forKey: "lat")
//        newData.setValue(lng, forKey: "lng")
//        newData.setValue(update, forKey: "upDate")
//        newData.setValue(stripe_acnt_id, forKey: "stripeAcntID")
//        newData.setValue(last_Lat, forKey: "lastLat")
//        newData.setValue(last_Lng, forKey: "lastLng")
//        newData.setValue(available_Credits, forKey: "availableCredits")
        
        do {
            try context.save()
            print(newData)
            print("new data saved")
        }catch{
            print("new data save error")
            print(error.localizedDescription)
        }
    }
    
    func getdata() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        request.returnsObjectsAsFaults = true
        do{
            let results = try self.context.fetch(request)
            if(results.count > 0){
                for result in results as![NSManagedObject]{
//                    if let name = result.value(forKey: "name") as? String{
//                        self.name = name
//                        print("data name \(name)")
//                    }
//                    if let image = result.value(forKey: "profileImage") as? String{
//                        self.profile_Image = image
//                        print("data profileImage \(image)")
//                    }
//                    if let email = result.value(forKey: "email") as? String{
//                        self.email = email
//                        print("data email\(email)")
//                    }
//                    if let id = result.value(forKey: "id") as? Int{
//                        self.id = id
//                        print("data id \(id)")
//                    }
//                    if let isEmailVerified = result.value(forKey: "isEmailVerified") as? Int{
//                        self.isEmail_Verified = isEmailVerified
//                        print("data isEmail_Verified \(isEmailVerified)")
//                    }
//                    if let stripeCustomerID = result.value(forKey: "stripeCustomerID") as? String{
//                        self.stripe_Customer_ID = stripeCustomerID
//                        print("data stripe_Customer_ID \(stripeCustomerID)")
//                    }
//                    if let accesstoken = result.value(forKey: "accessToken") as? String{
//                        self.access_Token = accesstoken
//                        print("data access_Token \(accesstoken)")
//                    }
//                    if let fcm_id = result.value(forKey: "fcmID") as? String{
//                        self.fcm_ID = fcm_id
//                        print("data fcm_ID \(fcm_id)")
//                    }
//                    if let countryCode = result.value(forKey: "countryCode") as? String{
//                        self.country_Code = countryCode
//                        print("data country_Code \(countryCode)")
//                    }
//                    if let isPhoneVerifed = result.value(forKey: "isPhoneVerifed") as? Int{
//                        self.isPhone_Verifed = isPhoneVerifed
//                        print("data isPhone_Verifed \(isPhoneVerifed)")
//                    }
//                    if let lat = result.value(forKey: "lat") as? Double{
//                        self.lat = lat
//                        print("data lat \(lat)")
//                    }
//                    if let lng = result.value(forKey: "lng") as? Double{
//                        self.lng = lng
//                        print("data lng \(lng)")
//                    }
//                    if let update = result.value(forKey: "upDate") as? Int{
//                        self.update = update
//                        print("data update \(update)")
//                    }
//                    if let phone = result.value(forKey: "phone") as? Int{
//                        self.phone = phone
//                        print("data phone \(phone)")
//                    }
//                    if let stripeAcntID = result.value(forKey: "stripeAcntID") as? String{
//                        self.stripe_acnt_id = stripeAcntID
//                        print("data stripeAcntID \(stripeAcntID)")
//                    }
//                    if let lastLat = result.value(forKey: "lastLat") as? Double{
//                        self.last_Lat = lastLat
//                        print("data lastLat \(lastLat)")
//                    }
//                    if let lastLng = result.value(forKey: "lastLng") as? Double{
//                        self.last_Lng = lastLng
//                        print("data lastLng \(lastLng)")
//                    }
//                    if let availableCredits = result.value(forKey: "availableCredits") as? Double{
//                        self.available_Credits = availableCredits
//                        print("data availableCredits \(available_Credits)")
//                    }
                }
            }
        }
        catch
        {
            print("something error during getting data")
            print(error.localizedDescription)
        }
    }
    
    func deleteProfile() {
        
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName))
        
//        id = 0
//        name = ""
//        profile_Image = ""
//        email = ""
//        country_Code = ""
//        phone = 0
//        lat = 0.0
//        lng = 0.0
//        isEmail_Verified = 0
//        isPhone_Verifed = 0
//        stripe_Customer_ID = ""
//        update = 0
//        access_Token = ""
//        stripe_acnt_id = ""
//        last_Lat = 0.0
//        last_Lng = 0.0
//        available_Credits = 0.0
        
        do {
            try self.context.execute(DelAllReqVar)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
