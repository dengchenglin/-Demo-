//
//  HttpServer.swift
//  JD
//
//  Created by 岳坤 on 15/8/11.
//  Copyright © 2015年 YK. All rights reserved.
//

import UIKit
class HttpServer: NSObject {

//MARK: GET
    static func GET(baseURL: String, parameter: Dictionary<String , AnyObject>?, success:(jsonDict: Dictionary<String, AnyObject>) -> Void, fail:(errorCode: Int) -> Void) {
        let  connection = ConnectionServer()
        connection.request(HttpMethod.GET, baseURL: baseURL, parameter: parameter)
        connection.requetSuccessBlcok = {
            (jsonDict:Dictionary<String, AnyObject>) -> Void in
            success(jsonDict: jsonDict)
        }
        connection.requestErrorBlcok = {
            (errorCode: Int) -> Void in
            fail(errorCode: errorCode)
        }
    }
    
//MARK: POST
    static func POST(baseURL: String, parameter: Dictionary<String , AnyObject>?, success:(jsonDict: Dictionary<String, AnyObject>) -> Void, fail:(errorCode: Int) -> Void) {
        let  connection = ConnectionServer()
        connection.request(HttpMethod.POST, baseURL: baseURL, parameter: parameter)
        connection.requetSuccessBlcok = {
            (jsonDict:Dictionary<String, AnyObject>) -> Void in
            success(jsonDict: jsonDict)
        }
        connection.requestErrorBlcok = {
            (errorCode: Int) -> Void in
            fail(errorCode: errorCode)
        }
    }
    
//MARK: PUT
    static func PUT(baseURL: String, parameter: Dictionary<String , AnyObject>?, success:(jsonDict: Dictionary<String, AnyObject>) -> Void, fail:(errorCode: Int) -> Void) {
        let  connection = ConnectionServer()
        connection.request(HttpMethod.PUT, baseURL: baseURL, parameter: parameter)
        connection.requetSuccessBlcok = {
            (jsonDict:Dictionary<String, AnyObject>) -> Void in
            success(jsonDict: jsonDict)
        }
        connection.requestErrorBlcok = {
            (errorCode: Int) -> Void in
            fail(errorCode: errorCode)
        }
    }
    
//MARK: DELETE
    static func DELETE(baseURL: String, parameter: Dictionary<String , AnyObject>?, success:(jsonDict: Dictionary<String, AnyObject>) -> Void, fail:(errorCode: Int) -> Void) {
        let  connection = ConnectionServer()
        connection.request(HttpMethod.DELETE, baseURL: baseURL, parameter: parameter)
        connection.requetSuccessBlcok = {
            (jsonDict:Dictionary<String, AnyObject>) -> Void in
            success(jsonDict: jsonDict)
        }
        connection.requestErrorBlcok = {
            (errorCode: Int) -> Void in
            fail(errorCode: errorCode)
        }
    }

}
