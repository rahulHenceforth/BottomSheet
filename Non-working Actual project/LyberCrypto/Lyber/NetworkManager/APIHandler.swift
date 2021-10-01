
//
//  ApiHandler.swift
//  Created by RAHUL MACBOOK on 24/08/2021.
//  Copyright © 2021 MAC. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum ApiMethod {
    case GET
    case POST
    case PostWithImage
    case PostString
    case GetString
    case PostWithJSON
    case PUT
    case PUTWithImage
    case DELETE
    case DELETEWithJSON
    case PUTWithJSON
}

//if let navCon = keyWindow?.rootViewController as? UINavigationController{
//                               print(navCon.viewControllers)
//                           }
//if let navCon = UIWindow.key?.rootViewController as? UINavigationController{
//    print(navCon.viewControllers)
//}

class ApiHandler: NSObject {

    // MARK:- THIS METHOD RETURN RESPONSE IN CODEABLE
    
    static func callApiWithParameters<T:Codable>(url: String , withParameters parameters:[String:AnyObject], ofType : T.Type, onSuccess:@escaping (T)->(), onFailure: @escaping (Bool, String)->(), method: ApiMethod, img: [UIImage]? , imageParamater: [String]?, headerPresent: Bool){
        
        var header : HTTPHeaders = [
            
        ]
        //        coredata.shared.getdata()
        
        // MARK:- HEADER CREATED, YOU CAN ALSO SEND YOUR CUSTOM HEADER
        if headerPresent{
            //                        header = [.authorization("coredata.shared.accessToken"), .accept("application/json")]
//                        header = [.authorization(coredata.shared.accessToken)]
            
        }
        
        // MARK:- PRINT ALL REQUESTED DATA
        print("Requested data :-\n  \(NetworkURL().BASE_URL)\(url)\n\(method)\n\(header)\n\(parameters)\n\n\n\n\n")
        print("\(NetworkURL().BASE_URL)\(url)")
        print(parameters)
        print(header)
        print(method)
        
        // MARK:- CHECK WHETHER INTERNET IS CONNECTED OR NOT
        if !Reachability.isConnectedToNetwork(){
            onFailure(false, "Internet not found")
            return
        }
        
        // MARK:- REQUESTED METHODS
        if method == .GET || method == .POST || method == .PUT || method == .DELETE{
            
            var kMehod: HTTPMethod?
            
            switch method {
            case .GET:
                kMehod = .get
            case .POST:
                kMehod = .post
            case .PUT:
                kMehod = .put
            case .DELETE:
                kMehod = .delete
            default:
                break
            }
            
            AF.sessionConfiguration.timeoutIntervalForRequest = 60              //FOR TIMEOUT SETTINGS
            AF.request("\(NetworkURL().BASE_URL)\(url)", method: kMehod ?? .get, parameters: parameters, encoding: URLEncoding.default, headers: header).response{ response in
                print(response)
                
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(_):
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSONDecoder().decode(T.self, from: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
            
        }else if method == .PostWithJSON || method == .PUTWithJSON || method == .DELETEWithJSON{
            
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var request = URLRequest(url: URL(string: "\(NetworkURL().BASE_URL)\(url)")!)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.headers = header
            
            if method == .PostWithJSON{
                request.httpMethod = "POST"
            }else if method == .PUTWithJSON{
                request.httpMethod = "PUT"
            }else{
                request.httpMethod = "DELETE"
            }
            
            AF.request(request).responseJSON{response in
                print(response)
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(_):
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSONDecoder().decode(T.self, from: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
        }else if method == .GetString || method == .PostString{
            var kMehod: HTTPMethod?
            
            switch method {
            case .GetString:
                kMehod = .get
            case .PostString:
                kMehod = .post
            default:
                break
            }
            
            AF.request("\(NetworkURL().BASE_URL)\(url)", method: kMehod ?? .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseString{ response in
                print(response)
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(_):
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSONDecoder().decode(T.self, from: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
            
        }else{       // MARK:- UPLOAD IMAGE IN THIS CASE, However it is better to make upload 1 by 1 instead of uploading all at once.
            //                        because if it failed, it will only failed on 1 image. but upload all at once,
            //                         if 1 file failed user need to restart the uploading process from the beginning.
            //                         nevertheless here is what you going have to do if you want to upload multiple data at once.
            
            // MARK:- IMAGES AND IMAGE PARAMS MUST BE EQUAL
            if img?.count != imageParamater?.count{
                print("\nNumber of images and number of image parameters must be same.")
                return
            }
            
            var kMehod: HTTPMethod = .post
            
            if method == .PUTWithImage{
                kMehod = .put
            }
            
            AF.upload(multipartFormData: {multipartFormData in
                
                for (num, value) in (imageParamater ?? []).enumerated() {
                    guard let compressedImg = img?[num].jpegData(compressionQuality: 0.2)else{
                        return
                    }
                    multipartFormData.append(compressedImg, withName: value, fileName: "File-\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, to: "\(NetworkURL().BASE_URL)\(url)", method: kMehod, headers: header).uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }).responseJSON(completionHandler: { data in
                print("upload finished: \(data)")
            }).response { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(let resut):
                    print("upload success result: \(resut ?? Data())")
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSONDecoder().decode(T.self, from: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
        }
    }
    
    // MARK:- THIS METHOD RETURN RESPONSE IN JSON
    static func callApiWithParametersJson(url: String , withParameters parameters:[String:AnyObject], onSuccess:@escaping (JSON)->(), onFailure: @escaping (Bool, String)->(), method: ApiMethod, img: [UIImage]? , imageParamater: [String]?, headerPresent: Bool){
        
        var header : HTTPHeaders = [
            
        ]
        //        coredata.shared.getdata()
        
        // MARK:- HEADER CREATED, YOU CAN ALSO SEND YOUR CUSTOM HEADER
        if headerPresent{
            //                        header = [.authorization("coredata.shared.accessToken"), .accept("application/json")]
            //            header = [.authorization(coredata.shared.accessToken)]
            
        }
        
        // MARK:- PRINT ALL REQUESTED DATA
        print("Requested data :-\n  \(NetworkURL().BASE_URL)\(url)\n\(method)\n\(header)\n\(parameters)\n\n\n\n\n")
        print("\(NetworkURL().BASE_URL)\(url)")
        print(parameters)
        print(header)
        print(method)
        
        // MARK:- CHECK WHETHER INTERNET IS CONNECTED OR NOT
        if !Reachability.isConnectedToNetwork(){
            onFailure(false, "Internet not found")
            return
        }
        
        // MARK:- REQUESTED METHODS
        if method == .GET || method == .POST || method == .PUT || method == .DELETE{
            
            var kMehod: HTTPMethod?
            
            switch method {
            case .GET:
                kMehod = .get
            case .POST:
                kMehod = .post
            case .PUT:
                kMehod = .put
            case .DELETE:
                kMehod = .delete
            default:
                break
            }
            
            AF.sessionConfiguration.timeoutIntervalForRequest = 60              //FOR TIMEOUT SETTINGS
            AF.request("\(NetworkURL().BASE_URL)\(url)", method: kMehod ?? .get, parameters: parameters, encoding: URLEncoding.default, headers: header).response{ response in
                print(response)
                
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(_):
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSON(data: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
            
        }else if method == .PostWithJSON || method == .PUTWithJSON || method == .DELETEWithJSON{
            
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var request = URLRequest(url: URL(string: "\(NetworkURL().BASE_URL)\(url)")!)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.headers = header
            
            if method == .PostWithJSON{
                request.httpMethod = "POST"
            }else if method == .PUTWithJSON{
                request.httpMethod = "PUT"
            }else{
                request.httpMethod = "DELETE"
            }
            
            AF.request(request).responseJSON{response in
                print(response)
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(_):
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSON(data: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
        }else if method == .GetString || method == .PostString{
            var kMehod: HTTPMethod?
            
            switch method {
            case .GetString:
                kMehod = .get
            case .PostString:
                kMehod = .post
            default:
                break
            }
            
            AF.request("\(NetworkURL().BASE_URL)\(url)", method: kMehod ?? .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseString{ response in
                print(response)
                let statusCode = response.response?.statusCode
                switch response.result{
                case .success(_):
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSON(data: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
            
        }else{       // MARK:- UPLOAD IMAGE IN THIS CASE, However it is better to make upload 1 by 1 instead of uploading all at once.
//                        because if it failed, it will only failed on 1 image. but upload all at once,
//                         if 1 file failed user need to restart the uploading process from the beginning.
//                         nevertheless here is what you going have to do if you want to upload multiple data at once.
            
            // MARK:- IMAGES AND IMAGE PARAMS MUST BE EQUAL
            if img?.count != imageParamater?.count{
                print("\nNumber of images and number of image parameters must be same.")
                return
            }
            
            var kMehod: HTTPMethod = .post
            
            if method == .PUTWithImage{
                kMehod = .put
            }
            
            AF.upload(multipartFormData: {multipartFormData in
                
                for (num, value) in (imageParamater ?? []).enumerated() {
                    guard let compressedImg = img?[num].jpegData(compressionQuality: 0.2)else{
                        return
                    }
                    multipartFormData.append(compressedImg, withName: value, fileName: "File-\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, to: "\(NetworkURL().BASE_URL)\(url)", method: kMehod, headers: header).uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }).responseJSON(completionHandler: { data in
                print("upload finished: \(data)")
            }).response { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(let resut):
                    print("upload success result: \(resut ?? Data())")
                    if (200...299).contains(statusCode ?? 0){
                        if let data = response.data{
                            do{
                                let json = try JSON(data: data)
                                onSuccess(json)
                            }
                            catch let error as NSError {
                                print("Could not save error named - \n\(error)\n\(error.userInfo)\n\(error.userInfo.debugDescription)")
                                print("\(error.localizedFailureReason ?? "")\n", error.localizedDescription)
                                onFailure(false, error.userInfo.debugDescription)
                            }
                        }
                    }else{
                        let dict = JSON(response.data ?? Data())
                        if (statusCode == 400 || statusCode == 401 || statusCode == 403 || statusCode == 404){
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }else if (statusCode == 500 || statusCode == 503){
                            print("Server Error")
                            onFailure(false,"Server Error")
                        }else{
                            if dict["error"].stringValue != ""{
                                print(dict["error"].stringValue, dict["error_description"].stringValue)
                                onFailure(false,dict["error_description"].stringValue )
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    onFailure(false, error.localizedDescription)
                }
            }
        }
    }
}





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD CODEABLE METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////
////  ApiHandler.swift
////  dreamtrack
////
////  Created by MACBOOK on 06/12/17.
////  Copyright © 2017 MAC. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class Connectivity {
//    class var isConnectedToInternet:Bool {
//        return NetworkReachabilityManager()!.isReachable
//    }
//}
//
//class ApiHandler: NSObject {
//    static func callApiWithParameters(url: String , withParameters parameters:[String:AnyObject], success:@escaping (JSON)->(), failure: @escaping (String)->(), method: ApiMethod, img: UIImage? , imageParamater: String,headers: [String:String]){
//
//        switch method {
//        case .GET:
//            Alamofire.request("\(BASEURL)\(url)" ,method : .get,parameters:parameters,encoding:URLEncoding.default ,headers: headers).responseJSON { response
//                in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON?
//                do{
//                    json = try? JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//
//                switch response.result{
//
//                case .success(_):
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success(json!)
//                        }
//                    }
//                    else{
//                        if let data = response.result.value{
//                            let dict=data as! NSDictionary
//                            if statusCode == 403 || statusCode == 401{
//                                loginModal.sharedInstance.deleteData()
//                                let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                navCon.viewControllers[0] = firstVC
//                                navCon.popToRootViewController(animated: true)
//                            }else{
//                                if let value = dict.value(forKey: "error_description"){
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "message") as! String)
//                                }
//                            }
//                        }
//                    }
//                    break
//                case .failure(_):
//                    if let error = response.result.error{
//                        let str = error.localizedDescription as String
//                        if str.isEqual("JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format."){
//                            return
//                        }
//
//                        failure(str)
//                    }
//
//                }
//            }
//            break
//        case .POST:
//
//            Alamofire.request( "\(BASEURL)\(url)", method : .post, parameters:parameters,encoding: URLEncoding.default,headers: headers).responseJSON {
//                response in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON?
//                do{
//                    json = try? JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//                switch response.result{
//
//                case .success(_):
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success(json!)
//                        }
//                    }
//                    else{
//                        if json!["error_description"].stringValue == "" {
//                            failure(json!["message"].stringValue)
//                        }
//                        else {
//                            failure(json!["error_description"].stringValue)
//                        }
//
//                        if let data = response.result.value{
//                            let dict = data as! NSDictionary
//                            if statusCode == 403 || statusCode == 401{
//                                loginModal.sharedInstance.deleteData()
//                                let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                navCon.viewControllers[0] = firstVC
//                                navCon.popToRootViewController(animated: true)
//                            }else{
//                                if dict.value(forKey: "error_description") != nil{
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "message") as! String)
//                                }
//                            }
//                        }
//                    }
//                    break
//
//                case .failure(_):
//                    if let error = response.result.error{
//                        //                        failure(json)
//                        failure(error.localizedDescription as String)
//                    }
//                }}
//            break
//        case .PostWithImage:
//            guard let img = img else{return}
//            guard let imageData = UIImageJPEGRepresentation(img, 0.5)else{return}
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imageData, withName: imageParamater ,fileName: "file.jpeg", mimeType: "image/jpeg")
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                }
//            },
//                             to:"\(BASEURL)\(url)", headers:headers)
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//                    upload.responseJSON { response in
//                        let statusCode = response.response?.statusCode
////                        let json = JSON(data: response.data!)
//                        let json: JSON?
//                        do{
//                            json = try? JSON(data: response.data!)
//                        }
//                        catch let error as NSError {
//                            print("Could not save\(error),\(error.userInfo)")
//                        }
//                        if(statusCode==200){
//                            if let data = response.result.value{
//                                success(json!)
//                                //                                success((data as AnyObject) as! NSDictionary)
//                            }
//                        }
//                        else{
//                            //                            failure(json)
//                            if let data = response.result.value{
//                                let dict=data as! NSDictionary
//                                if statusCode == 403 || statusCode == 401{
//                                    loginModal.sharedInstance.deleteData()
//                                    let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                    navCon.viewControllers[0] = firstVC
//                                    navCon.popToRootViewController(animated: true)
//                                }else{
//                                    if let value = dict.value(forKey: "error_description"){
//                                        failure(dict.value(forKey: "error_description") as! String)
//                                    }else{
//                                        failure(dict.value(forKey: "message") as! String)
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                case .failure(let encodingError):
//                    //                    encodingError.
//                    //                    let json = JSON(data: response.data!)
//                    //                    failure(json)
//                    failure(encodingError.localizedDescription as String)
//                }
//            }
//            break
//        case .PostWithJSON:
//
//            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//
//            var request = URLRequest(url: URL(string: "\(BASEURL)\(url)")!)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            request.httpBody = jsonData
//
//            Alamofire.request(request).responseJSON { response in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON?
//                do{
//                    json = try? JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//                if(statusCode==200){
//                    if let data = response.result.value{
//                        success(json!)
//                        //                                success((data as AnyObject) as! NSDictionary)
//                    }
//                }
//                else{
//                    //                            failure(json)
//                    if let data = response.result.value{
//                        let dict=data as! NSDictionary
//                        if statusCode == 403 || statusCode == 401{
//                            loginModal.sharedInstance.deleteData()
//                            let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                            let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                            navCon.viewControllers[0] = firstVC
//                            navCon.popToRootViewController(animated: true)
//                        }else{
//                            if let value = dict.value(forKey: "error_description"){
//                                failure(dict.value(forKey: "error_description") as! String)
//                            }else{
//                                failure(dict.value(forKey: "message") as? String ?? "")
//                            }
//                        }
//                    }
//                }
//            }
//            break
//
//        case .PUT:
//            Alamofire.request( "\(BASEURL)\(url)", method : .put, parameters:parameters,encoding: JSONEncoding.default,headers: headers).responseJSON {
//                response in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON
//                do{
//                    json = try! JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//                switch response.result{
//
//                case .success(_):
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success(json)
//                            //                            success((data as AnyObject) as! NSDictionary)
//                        }
//                    }
//                    else{
//                        //                        failure(json)
//                        if let data = response.result.value{
//                            let dict=data as! NSDictionary
//                            if statusCode == 403 || statusCode == 401{
//                                loginModal.sharedInstance.deleteData()
//                                let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                navCon.viewControllers[0] = firstVC
//                                navCon.popToRootViewController(animated: true)
//                            }else{
//                                if let value = dict.value(forKey: "error_description"){
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "message") as! String)
//                                }
//                            }
//                        }
//                    }
//                    break
//
//                case .failure(_):
//                    //                    failure(json)
//                    if let error = response.result.error{
//                        failure(error.localizedDescription as String)
//                    }
//                    break
//                }}
//            break
//
//        default:
//            break
//        }
//    }
//
//    static func callApiForMultipleImagesWithParameters(url: String , withParameters parameters:[String:AnyObject], success:@escaping (NSDictionary)->(), failure: @escaping (NSString)->(), method: ApiMethod, images: NSArray? ,headers: [String:String]){
//
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            var i:Int=0
//            for image in images!{
//                i += 1
//                guard let imageData = UIImageJPEGRepresentation(image as! UIImage, 1) else {return }
//                let imgName : NSString?
//                imgName = String(format: "image_%d",i) as NSString?
//                multipartFormData.append(imageData, withName: imgName as! String, fileName: "file.jpeg", mimeType: "image/jpeg")
//            }
//
//            for (key, value) in parameters {
//                //if value is NSString{
//                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                //                }
//                //                else{
//                ////                    let stringsData = NSMutableData()
//                ////                    for string in value as! NSArray{
//                ////
//                ////                         let stringData = (string as AnyObject).data(using: String.Encoding.utf8.rawValue)!
//                ////                          stringsData.append(stringData)
//                ////
//                ////                    }
//                //                 //   let data = stringsData.copy() as! NSData
//                //
//                //                }
//            }
//        },
//                         to:url)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                upload.responseJSON { response in
//                    let statusCode = response.response?.statusCode
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success((data as AnyObject) as! NSDictionary)
//                        }
//                    }
//                    else{
//                        if let data = response.result.value{
//                            let dict=data as! NSDictionary
//                            failure(dict.value(forKey: "message") as! NSString)
//                        }
//                    }
//                }
//
//            case .failure(let encodingError):
//                failure(encodingError.localizedDescription as NSString)
//            }
//        }
//
//    }
//}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////OLD JSON AND MULTIPLE IMAGES METHOD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//    static func callApiWithParameters(url: String , withParameters parameters:[String:AnyObject], success:@escaping (JSON)->(), failure: @escaping (String)->(), method: ApiMethod, img: UIImage? , imageParamater: String,headers: [String:String]){
//
//        //debug Print Used bcz simple Print takes memory every time but this debug print takes memory only at the time of debugging.
//        debugPrint("****************************")
//        debugPrint("Link:-      \(BASEURL)\(url)")
//        debugPrint("Param:-     \(parameters)")
//        debugPrint("headers:-   \(headers)")
//        debugPrint("****************************")
//
//
//        switch method {
//        case .GET:
//            Alamofire.request("\(BASEURL)\(url)" ,method : .get,parameters:parameters,encoding:URLEncoding.default ,headers: headers).responseJSON { response
//                in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON?
//                do{
//                    json = try? JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//
//                switch response.result{
//
//                case .success(_):
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success(json!)
//                        }
//                    }
//                    else{
//                        if let data = response.result.value{
//                            let dict=data as! NSDictionary
//                            if statusCode == 403 || statusCode == 401{
//                                loginModal.sharedInstance.deleteData()
//                                let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                CommonFunctions.toster("Session Expired")
////                                let alertController = alertView(title: "ERROR", message: "Session Expired" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
//
//                                navCon.viewControllers[0] = firstVC
//                                navCon.popToRootViewController(animated: true)
//                                //navCon.viewControllers[0].present(alertController, animated: true, completion: nil)
//                            }else{
//                                if let value = dict.value(forKey: "error_description"){
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "message") as! String)
//                                }
//                            }
//                        }
//                    }
//                    break
//                case .failure(_):
//                    if let error = response.result.error{
//                        let str = error.localizedDescription as String
//                        if str.isEqual("JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format."){
//                            return
//                        }
//
//                        failure(str)
//                    }
//
//                }
//            }
//            break
//        case .POST:
//
//            Alamofire.request( "\(BASEURL)\(url)", method : .post, parameters:parameters,encoding: URLEncoding.default,headers: headers).responseJSON {
//                response in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                var json: JSON?
//
//                do{
//                    json = try? JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//                switch response.result{
//
//                case .success(_):
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success(json!)
//                        }
//                    }
//                    else{
//                        if json!["error_description"].stringValue == "" {
//                            failure(json!["message"].stringValue)
//                        }
//                        else {
//                            failure(json!["error_description"].stringValue)
//                        }
//
//                        if let data = response.result.value{
//                            let dict = data as! NSDictionary
//                            if statusCode == 403 || statusCode == 401{
//                                if (dict.value(forKey: "error") as! String == "INVALID_OTP") || (dict.value(forKey: "error") as! String == "INCORRECT_PASSWORD") ||
//                                    (dict.value(forKey: "error") as! String ==  "ACCOUNT_NOT_REGISTERED") || (dict.value(forKey: "error") as! String ==  "MOBILE_REGISTERED")  {
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                    return
//                                }
//                                loginModal.sharedInstance.deleteData()
//                                let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                navCon.viewControllers[0] = firstVC
//                                navCon.popToRootViewController(animated: true)
//                            }else{
//                                if dict.value(forKey: "error_description") != nil{
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "error") as! String)
//                                }
//                            }
//                        }
//                    }
//                    break
//
//                case .failure(_):
//                    if let error = response.result.error{
//                        //                        failure(json)
//                        failure(error.localizedDescription as String)
//                    }
//                }}
//            break
//        case .PostWithImage:
//            guard let img = img else{return}
//            guard let imageData = UIImageJPEGRepresentation(img, 0.5)else{return}
//
//            if !Connectivity.isConnectedToInternet{
//               // CommonFunctions.toster("Internet Connection not Available!")
//                failure("The Internet connection appears to be offline.")
//                return
//            }
//
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imageData, withName: imageParamater ,fileName: "file.jpeg", mimeType: "image/jpeg")
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                }
//            },
//                             to:"\(BASEURL)\(url)", headers:headers)
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//                    upload.responseJSON { response in
//                        let statusCode = response.response?.statusCode
////                        let json = JSON(data: response.data!)
//                        let json: JSON?
//                        do{
//                            json = try? JSON(data: response.data!)
//                        }
//                        catch let error as NSError {
//                            print("Could not save\(error),\(error.userInfo)")
//                        }
//                        if(statusCode==200){
//                            if let data = response.result.value{
//                                success(json!)
//                                //                                success((data as AnyObject) as! NSDictionary)
//                            }
//                        }
//                        else{
//                            //                            failure(json)
//                            if let data = response.result.value{
//                                let dict=data as! NSDictionary
//                                if statusCode == 403 || statusCode == 401{
//                                    loginModal.sharedInstance.deleteData()
//                                    let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                    navCon.viewControllers[0] = firstVC
//                                    navCon.popToRootViewController(animated: true)
//                                }else{
//                                    if let value = dict.value(forKey: "error_description"){
//                                        failure(dict.value(forKey: "error_description") as! String)
//                                    }else{
//                                        failure(dict.value(forKey: "message") as! String)
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                case .failure(let encodingError):
//                    //                    encodingError.
//                    //                    let json = JSON(data: response.data!)
//                    //                    failure(json)
//                    failure(encodingError.localizedDescription as String)
//                }
//
//            }
//
//            break
//        case .PostWithJSON:
//
//            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//
//            var request = URLRequest(url: URL(string: "\(BASEURL)\(url)")!)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            request.httpBody = jsonData
//
//            Alamofire.request(request).responseJSON { response in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON?
//                do{
//                    json = try? JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//                if(statusCode==200){
//                    if let data = response.result.value{
//                        success(json!)
//                        //                                success((data as AnyObject) as! NSDictionary)
//                    }
//                }
//                else{
//                    //                            failure(json)
//                    if let data = response.result.value{
//                        let dict=data as! NSDictionary
//                        if statusCode == 403 || statusCode == 401{
//                            loginModal.sharedInstance.deleteData()
//                            let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                            let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                            navCon.viewControllers[0] = firstVC
//                            navCon.popToRootViewController(animated: true)
//                        }else{
//                            if let value = dict.value(forKey: "error_description"){
//                                failure(dict.value(forKey: "error_description") as! String)
//                            }else{
//                                failure(dict.value(forKey: "message") as? String ?? "")
//                            }
//                        }
//                    }
//                }
//            }
//            break
//
//        case .PUT:
//            Alamofire.request( "\(BASEURL)\(url)", method : .put, parameters:parameters,encoding: JSONEncoding.default,headers: headers).responseJSON {
//                response in
//                let statusCode = response.response?.statusCode
////                let json = JSON(data: response.data!)
//                let json: JSON
//                do{
//                    json = try! JSON(data: response.data!)
//                }
//                catch let error as NSError {
//                    print("Could not save\(error),\(error.userInfo)")
//                }
//                switch response.result{
//
//                case .success(_):
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success(json)
//                            //                            success((data as AnyObject) as! NSDictionary)
//                        }
//                    }
//                    else{
//                        //                        failure(json)
//                        if let data = response.result.value{
//                            let dict=data as! NSDictionary
//                            if statusCode == 403 || statusCode == 401{
//                                loginModal.sharedInstance.deleteData()
//                                let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                navCon.viewControllers[0] = firstVC
//                                navCon.popToRootViewController(animated: true)
//                            }else{
//                                if let value = dict.value(forKey: "error_description"){
//                                    failure(dict.value(forKey: "error_description") as! String)
//                                }else{
//                                    failure(dict.value(forKey: "message") as! String)
//                                }
//                            }
//                        }
//                    }
//                    break
//
//                case .failure(_):
//                    //                    failure(json)
//                    if let error = response.result.error{
//                        failure(error.localizedDescription as String)
//                    }
//                    break
//                }}
//            break
//
//        default:
//            break
//        }
//    }
//
//    static func callApiWithParametersImgs(url: String , withParameters parameters:[String:AnyObject], success:@escaping (JSON)->(), failure: @escaping (String)->(), method: ApiMethod, img: [UIImage?] , imageParamater: [String],headers: [String:String]){
//
//            guard let img1 = img[0] else{return}
//            guard let imageData = UIImageJPEGRepresentation(img1, 0.5)else{return}
//            guard let img2 = img[1] else{return}
//            guard let imageData2 = UIImageJPEGRepresentation(img2, 0.5)else{return}
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imageData, withName: imageParamater[0] ,fileName: "file.jpeg", mimeType: "image/jpeg")
//                multipartFormData.append(imageData2, withName: imageParamater[1] ,fileName: "file.jpeg", mimeType: "image/jpeg")
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                }
//            },
//                             to:"\(BASEURL)\(url)", headers:headers)
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//                    upload.responseJSON { response in
//                        let statusCode = response.response?.statusCode
////                        let json = JSON(data: response.data!)
//                        let json: JSON?
//                        do{
//                            json = try? JSON(data: response.data!)
//                        }
//                        catch let error as NSError {
//                            print("Could not save\(error),\(error.userInfo)")
//                        }
//                        if(statusCode==200){
//                            if let data = response.result.value{
//                                success(json!)
//                                //                                success((data as AnyObject) as! NSDictionary)
//                            }
//                        }
//                        else{
//                            //                            failure(json)
//                            if let data = response.result.value{
//                                let dict=data as! NSDictionary
//                                if statusCode == 403 || statusCode == 401{
//                                    loginModal.sharedInstance.deleteData()
//                                    let firstVC = UIStoryboard(name: storyboardIdentifier.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier.loginVC.rawValue) as! loginVC
//                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
//                                    navCon.viewControllers[0] = firstVC
//                                    navCon.popToRootViewController(animated: true)
//                                }else{
//                                    if let value = dict.value(forKey: "error_description"){
//                                        failure(dict.value(forKey: "error_description") as! String)
//                                    }else{
//                                        failure(dict.value(forKey: "message") as! String)
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                case .failure(let encodingError):
//                    //                    encodingError.
//                    //                    let json = JSON(data: response.data!)
//                    //                    failure(json)
//                    failure(encodingError.localizedDescription as String)
//                }
//            }
//
//
//    }
//
//    static func callApiForMultipleImagesWithParameters(url: String , withParameters parameters:[String:AnyObject], success:@escaping (NSDictionary)->(), failure: @escaping (NSString)->(), method: ApiMethod, images: NSArray? ,headers: [String:String]){
//
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            var i:Int=0
//            for image in images!{
//                i += 1
//                guard let imageData = UIImageJPEGRepresentation(image as! UIImage, 1) else {return }
//                let imgName : NSString?
//                imgName = String(format: "image_%d",i) as NSString?
//                multipartFormData.append(imageData, withName: imgName as! String, fileName: "file.jpeg", mimeType: "image/jpeg")
//            }
//
//            for (key, value) in parameters {
//                //if value is NSString{
//                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                //                }
//                //                else{
//                ////                    let stringsData = NSMutableData()
//                ////                    for string in value as! NSArray{
//                ////
//                ////                         let stringData = (string as AnyObject).data(using: String.Encoding.utf8.rawValue)!
//                ////                          stringsData.append(stringData)
//                ////
//                ////                    }
//                //                 //   let data = stringsData.copy() as! NSData
//                //
//                //                }
//            }
//        },
//                         to:url)
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                upload.responseJSON { response in
//                    let statusCode = response.response?.statusCode
//                    if(statusCode==200){
//                        if let data = response.result.value{
//                            success((data as AnyObject) as! NSDictionary)
//                        }
//                    }
//                    else{
//                        if let data = response.result.value{
//                            let dict=data as! NSDictionary
//                            failure(dict.value(forKey: "message") as! NSString)
//                        }
//                    }
//                }
//
//            case .failure(let encodingError):
//                failure(encodingError.localizedDescription as NSString)
//            }
//        }
//
//    }



