//
//  NetworkUtils.swift
//  chatTest_BuntiNizama
//
//  Copyright © 2018 BuntiNizama. All rights reserved.
//

import UIKit



class NetworkUtils: NSObject {

    static let BaseURL =  "https://chat.promactinfo.com/api/"
    static let LoginAPI =  "user/login"
    static let GetUsers =  "user"
    static let APIName =  "APIName"
    static let Name =  "name"
    static let Token =  "token"
    static let UserId =  "id"
    static let GetChat =  "chat"
    static let FromUserId =  "fromUserId"
    
    static let Message = "message"
    static let ToUserId = "toUserId"
    
    static func postApiCall(params: Dictionary<String, String>,postCompleted: @escaping (_ status : Bool, _ msg:NSDictionary) -> ()){
        
        let myUrl = URL(string: "\(BaseURL)\(params[APIName]!)");
        
        var request = URLRequest(url:myUrl!)
        
        let param : NSMutableDictionary = NSMutableDictionary()
        param.setValue(params[Name], forKey: Name)
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        
        request.httpMethod = "POST"// Compose a query string
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error!)")
                return
            }
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                postCompleted(true, json!)

                
            } catch {
                print(error)
            }
        }
        task.resume()

        
    }
    
    static func SendChat(apiName :String,params: Dictionary<String, String>,postCompleted: @escaping ( _ status : Bool,  _ msg:String) -> ()){
        
        let myUrl = URL(string: "\(BaseURL)\(apiName)");
        
        let request = NSMutableURLRequest(url: myUrl!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        let headers = [
            "content-type": "application/json",
            "authorization": MyMacro.sharedInstance.getFromPreferences(key: NetworkUtils.Token) as! String,
            ]
        
        let parameters = [
            Message: params[Message],
            ToUserId : params[ToUserId]
            ] as [String : Any]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        request.httpBody = httpBody as Data
        
        
        
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                postCompleted(true, "")
                
            }
        })
        
        dataTask.resume()
        
    }
    
    static func GetAPI(apiName :String,postCompleted: @escaping ( _ status : Bool,  _ msg:NSMutableArray) -> ()){
        
        let myUrl = URL(string: "\(BaseURL)\(apiName)");
        
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"// Compose a query string
        request.addValue(MyMacro.sharedInstance.getFromPreferences(key: NetworkUtils.Token) as! String, forHTTPHeaderField: "Authorization")
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error!)")
                return
            }
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
                postCompleted(true, json)
            } catch {
                print(error)
            }
            
        }
        task.resume()
        
        
    }
    
    
}

