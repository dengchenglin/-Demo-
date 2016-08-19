//
//  ConnectionServer.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit
public enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}

class ConnectionServer: NSObject,NSURLConnectionDataDelegate {
    var _URLConnection: NSURLConnection!
    var requetSuccessBlcok: ((jsonDict: Dictionary<String, AnyObject>) -> Void)?
    var requestErrorBlcok: ((errorCode: Int) -> Void)?
    var _jsonData = NSMutableData()
    func request(method: HttpMethod, baseURL: String, parameter: Dictionary<String , AnyObject>?) {
        var realURL = baseURL
        if method == HttpMethod.GET {
            realURL = connectParameter(baseURL, parameter: parameter)
        }
        let url = NSURL(string: realURL)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
       if method != HttpMethod.GET {
            let data =  NSJSONSerialization.dataWithJSONObject(parameter!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
            request.HTTPBody = data

//            do {
//                let data = try  NSJSONSerialization.dataWithJSONObject(parameter!, options: NSJSONWritingOptions.PrettyPrinted)
//                request.HTTPBody = data
//            }catch {
//                
//            }
        }
        _URLConnection = NSURLConnection(request: request, delegate: self)
    }
    
    func connectParameter(baseURL: String, parameter: Dictionary<String, AnyObject>?) -> String {
        if parameter == nil {
            return baseURL
        }else {
            let array = NSMutableArray()
            for (key,value) in parameter! {
                let str = "\(key)=\(value)"
                array.addObject(str)
            }
            let parameterStr = array.componentsJoinedByString("&")
            let realURL = "\(baseURL)?\(parameterStr)"
            return realURL
        }
    }
    
    
    //MARK: NSURLConnectionDataDelegate
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        _jsonData.appendData(data)
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        if requestErrorBlcok != nil {
            requestErrorBlcok!(errorCode: error.code)
        }
    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        let jsonDict = NSJSONSerialization.JSONObjectWithData(_jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Dictionary<String, AnyObject>
        if requetSuccessBlcok != nil {
            requetSuccessBlcok!(jsonDict: jsonDict)
        }
//        do {
//            let jsonDict = try NSJSONSerialization.JSONObjectWithData(_jsonData, options: NSJSONReadingOptions.MutableContainers)
//            if requetSuccessBlcok != nil {
//                requetSuccessBlcok!(jsonDict: jsonDict as! NSDictionary as! Dictionary<String, AnyObject>)
//            }
//        } catch {
//            
//        }
    }
    
    
    //MARK: Https支持
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool {
        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        challenge.sender.useCredential(NSURLCredential(trust: challenge.protectionSpace.serverTrust!), forAuthenticationChallenge: challenge)
    }
}
