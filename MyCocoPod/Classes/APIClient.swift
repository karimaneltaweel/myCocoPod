//
//  APICLient.swift
//  ResultTypeLBTA
//
//  Created by Es on 1/28/20.
//  Copyright © 2021 Es. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

struct CustomError: Error {
    var somethingBadHappened:String
    var statusCode: Int
    var code:AuthErrorEnum?
    var key:String = ""
}

struct APIError: Codable {
    let code: Int
    let error: String
    
    enum CodingKeys : String, CodingKey {
        case code
        case error
    }
}

public enum APIErrorCases: Error {
    case custom
    case customWith(statusCode: Int)
}

extension APIErrorCases: LocalizedError {
    
    var localizedDescription: String {
        switch self {
            
        case .custom:
            return ServerError
            
        case  .customWith(let statusCode):
            
            switch statusCode {
                
            case 0: return ServerError
            case 1: return NetworkError
            case 2: return requestCancelled
            case 401:
                return "Your session was expired. Please login again."
                
            case 402...500:
                return ServerError
                
            default:
                return ServerError
            }
        }
    }
}

class APICLient {
    
    typealias ReqCompleted = (String? , _ errorStr:CustomError?) -> ()
    typealias FullAttachmentCompleted = (Data? , _ errorStr:String?) -> ()

    func stopTheDamnRequests() {
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getTasksWithCompletionHandler { (dataTasks, downloadTasks, a)  in
            dataTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
        sessionManager.cancelAllRequests()
        print("Request is cancelled")
    }
    
    public static func encode<T: Encodable>(_ value: T) throws -> Data? {
        do {
            let data = try JSONEncoder().encode(value)
            return data
        } catch {
            throw error
        }
    }
    
    
    
    func newexecuteObj<T,X>(_ Obj: X, mapTo:String,methodType:Alamofire.HTTPMethod = .post,completed: @escaping (Result<T, CustomError>) -> Void) where T: Codable , X:Codable{
        do {
            guard let data = try APICLient.encode(Obj) else {
                return
            }
            let serialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            var headers:HTTPHeaders = []
            
            headers = [   
                APIConstants.HttpHeaderField.AppVersion.rawValue: APIConstants.appVersion,
                APIConstants.HttpHeaderField.authorization.rawValue : "" ,
                           APIConstants.HttpHeaderField.SDKSecret.rawValue : APIConstants.sdkSecretKey,
                               APIConstants.HttpHeaderField.AcceptLanguage.rawValue: "en"
            ]

            print("HED;\(headers)")
            AF.request(APIConstants.baseURL+mapTo, method:methodType, parameters: serialized, encoding: JSONEncoding.default, headers: headers) .responseDecodable(of: T.self) { (response) in
                print("NEW RES:",response)
                print("response : ", response.result)
                print("RESULTTTT: ", response)
                print("status code:",response.response?.statusCode ?? "")
                
                do {
                    print("THE FULL REQUEST:", response.debugDescription)
                    switch response.result{
                    case .success( _):
                        if let code = response.response?.statusCode{
                            switch code {
                            case 200:
                                let json = try JSON(data: response.data!)
                                if json["status"].boolValue {
                                    //completion(.success(try JSONDecoder().decode(T.self, from: json["data"].rawData())))
                                    completed(.success(try JSONDecoder().decode(T.self, from: response.data!)))
                                } else {
                                    //TODO: Check it with eslam::
                                    // OLD: completion(.failure(CustomError.init(somethingBadHappened: json["data"].stringValue)))
                                    // In Verify : email already verified: {"message":"Email Already Verified !","status":false}
                                    completed(.failure(CustomError.init(somethingBadHappened: json["message"].stringValue, statusCode: code )))
                                }
                                
                            case 400:
                                let json = try JSON(data: response.data!)
                                let errorAll = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                print(errorAll)
                                let eA = try JSONDecoder().decode([APIError].self, from: json["errors"].rawData())
                                var errorList = ""
                                for val in eA {
                                    errorList += "\(val.error)"+"\r\n "
                                }
                                completed(.failure(CustomError.init(somethingBadHappened: errorList, statusCode: code )))
                                
                                
                            default:
                                let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                print("ErrorAPI:", error)
                                
                                completed(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription, statusCode: response.response?.statusCode ?? 0 )))
                                
                            }
                        }
                    case .failure(let error):
                        print("FAILURE ERROR:", error.localizedDescription)
                        if error.localizedDescription == "Request explicitly cancelled." {
                            break
                        } else {
                            
                            completed(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription, statusCode: response.response?.statusCode ?? 0 )))
                        }
                        
                    }
                    /////////////////
                } catch let error {
                    print("Catch ERROR:", error)
                    completed(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription , statusCode: response.response?.statusCode ?? 0 )))
                }
            }
            
            print(serialized?.description ?? "<no serialized description>")
        } catch {
            print("Encoding error: \(error.localizedDescription)")
        }
    }
    
    //MARK: Generic Request
    func executeQuery<T>(params:Parameters, mapTo: URLRequestConvertible,methodType:Alamofire.HTTPMethod = .post, completion: @escaping (Result<T, CustomError>) -> Void) where T: Codable {
        if Connectivity.isConnectedToInternet {
            print("Yes! Alamo internet is available.")
            do {
                let alamofireRequest = try Alamofire.URLEncoding().encode(mapTo, with: params)
                AF.request(alamofireRequest).responseData { (response) in
                    do {
                        print("THE FULL REQUEST:", response.debugDescription)
                        switch response.result{
                        case .success( _):
                            if let statusCode = response.response?.statusCode {
                                // Use the statusCode value here
                                print("Status code: \(statusCode)")
                            } else {
                                // Handle the case when statusCode is nil
                                print("Unable to determine the status code")
                            }

                            if let code = response.response?.statusCode {
                                switch code {
                                case 200:
                                    let json = try JSON(data: response.data!)
                                    if json["status"].boolValue {
                                      
                                        completion(.success(try JSONDecoder().decode(T.self, from: response.data!)))
                                    } else {
                                        completion(.failure(CustomError.init(somethingBadHappened: json["message"].stringValue, statusCode: code )))
                                    }
                                    
                                case 400:
                                    let json = try JSON(data: response.data!)
                                    let errorAll = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                    print(errorAll)
                                    let eA = try JSONDecoder().decode([APIError].self, from: json["errors"].rawData())
                                    var errorList = ""
                                    for val in eA {
                                        errorList += "\(val.error)"+"\r\n "
                                    }
                                    
                                    completion(.failure(CustomError.init(somethingBadHappened: errorList, statusCode: code )))
                                default:
                                    let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                    print("ErrorAPI:", error)
                                    completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.customWith(statusCode: code).localizedDescription , statusCode: code )))
                                }
                            }
                        case .failure(let error):
                            print("FAILURE ERROR:", error.localizedDescription)
                            if error.localizedDescription == "Request explicitly cancelled." {
                                break
                            } else {
                                completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription, statusCode: response.response?.statusCode ?? 0 )))
                            }
                            
                        }
                    } catch let error {
                        print("Catch ERROR:", error)
                        completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription , statusCode: response.response?.statusCode ?? 0 )))
                    }
                    
                }
            } catch {
                print("ERROR all locations ordersStatus ==>>", error.localizedDescription)
            }
        } else {
            completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.customWith(statusCode: 1).localizedDescription , statusCode: 1 )))
            
        }
    }
    
    //MARK: new executeObj with Generic response
    func newexecuteObjWithGenericResonse<T,X>(_ Obj: X, mapTo:String,methodType:Alamofire.HTTPMethod = .post,completed: @escaping (Result<T, CustomError>) -> Void) where T: Codable , X:Codable{
        do {
            guard let data = try APICLient.encode(Obj) else {
                return
            }
            let serialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            var headers:HTTPHeaders = []
            
            headers = [    APIConstants.HttpHeaderField.AppVersion.rawValue: APIConstants.appVersion,
                               APIConstants.HttpHeaderField.authorization.rawValue : "",
                           APIConstants.HttpHeaderField.SDKSecret.rawValue : APIConstants.sdkSecretKey,
                               APIConstants.HttpHeaderField.AcceptLanguage.rawValue: "en"]

            print("HED;\(headers)")
            AF.request(APIConstants.baseURL+mapTo, method:methodType, parameters: serialized, encoding: JSONEncoding.default, headers: headers) .responseDecodable(of: T.self) { (response) in
                print("NEW RES:",response)
                print("response : ", response.result)
                print("RESULTTTT: ", response)
                print("status code:",response.response?.statusCode ?? "")
                
                do {
                    print("THE FULL REQUEST:", response.debugDescription)
                    switch response.result{
                    case .success( _):
                        if let code = response.response?.statusCode{
                            switch code {
                            case 200:
                                let json = try JSON(data: response.data!)
                                if json["status"].boolValue {
                                    //completion(.success(try JSONDecoder().decode(T.self, from: json["data"].rawData())))
                                    completed(.success(try JSONDecoder().decode(T.self, from: response.data!)))
                                } else {
                                    //TODO: Check it with eslam::
                                    // OLD: completion(.failure(CustomError.init(somethingBadHappened: json["data"].stringValue)))
                                    // In Verify : email already verified: {"message":"Email Already Verified !","status":false}
                                    completed(.failure(CustomError.init(somethingBadHappened: json["message"].stringValue, statusCode: code )))
                                }
                                
                            case 400:
                                let json = try JSON(data: response.data!)
                                let errorAll = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                print(errorAll)
                                let eA = try JSONDecoder().decode([APIError].self, from: json["errors"].rawData())
                                var errorList = ""
                                for val in eA {
                                    errorList += "\(val.error)"+"\r\n "
                                }
                                completed(.failure(CustomError.init(somethingBadHappened: errorList, statusCode: code )))
                                
                                
                            default:
                                let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                print("ErrorAPI:", error)
                                
                                completed(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription, statusCode: response.response?.statusCode ?? 0 )))
                                
                            }
                        }
                    case .failure(let error):
                        print("FAILURE ERROR:", error.localizedDescription)
                        if error.localizedDescription == "Request explicitly cancelled." {
                            break
                        } else {
                            
                            completed(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription, statusCode: response.response?.statusCode ?? 0 )))
                        }
                        
                    }
                    /////////////////
                } catch let error {
                    print("Catch ERROR:", error)
                    completed(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription , statusCode: response.response?.statusCode ?? 0 )))
                }
            }
            
            print(serialized?.description ?? "<no serialized description>")
        } catch {
            print("Encoding error: \(error.localizedDescription)")
        }
    }
    
    //MARK: Upload Images
    func upload<T>(image: Data, type: String, fileName: String, to url: Alamofire.URLRequestConvertible, params: [String: Any], imgName: String, completion: @escaping (Result<T, CustomError>) -> Void) where T: Codable {
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(image, withName: imgName, fileName: fileName, mimeType: type)
        }, with: url)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
         .responseDecodable(of: T.self) { data in
            do {
                
                switch data.result {
                case .success( _):
                    if let code = data.response?.statusCode {
                        switch code {
                        case 200:
                            let json = try JSON(data: data.data!)
                            if json["status"].boolValue {
                                //                                    completion(.success(try JSONDecoder().decode(T.self, from: json["data"].rawData())))
                                completion(.success(try JSONDecoder().decode(T.self, from: data.data!)))
                            } else {
                                completion(.failure(CustomError.init(somethingBadHappened: json["message"].stringValue, statusCode: code )))
                            }
                            
                        case 400:
                            let json = try JSON(data: data.data!)
                            let errorAll = NSError(domain: data.debugDescription, code: code, userInfo: data.response?.allHeaderFields as? [String: Any])
                            print(errorAll)
                            let eA = try JSONDecoder().decode([APIError].self, from: json["errors"].rawData())
                            var errorList = ""
                            for val in eA {
                                errorList += "\(val.error)"+"\r\n "
                            }
                            
                            completion(.failure(CustomError.init(somethingBadHappened: errorList, statusCode: code )))
                        default:
                            let error = NSError(domain: data.debugDescription, code: code, userInfo: data.response?.allHeaderFields as? [String: Any])
                            print("ErrorAPI:", error)
                            completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.customWith(statusCode: code).localizedDescription, statusCode: data.response!.statusCode )))
                        }
                    }
                case .failure(let error):
                    print("FAILURE ERROR:", error)
                    if error.localizedDescription == "Request explicitly cancelled." {
                        break
                    } else {
                        completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription , statusCode: data.response?.statusCode ?? 0 )))
                    }
                }
            } catch let error {
                print("Catch ERROR:", error)
                completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription , statusCode: data.response?.statusCode ?? 0 )))
            }
            
        }
    }
    
    //MARK: FOr FP Step5
//    static func getAttachmentNEW(attId:String, financialId: String, completed: @escaping FullAttachmentCompleted) {
//        do {
//            AF.request(APIRouter.previewAttachments(attachId: attId, financialId: financialId)).responseData { (response) -> Void in
//                print("ATTACH response : ", response.result)
//                print("RESULTTTT: ", response.data)
//                print("status code:",response.response?.statusCode)
//                 print("THE FULL REQUEST:", response.debugDescription)
//                
//                switch response.result {
//                    
//                case .failure(let error):
//                    completed(nil, "Fail Error: Please try again later")
//                    //completed(nil, "Fail Error: \(error)")
//                case .success:
//                    completed(response.data, nil)
//                }
//            }
//        } catch {
//            print("ERROR all locations ordersStatus ==>>", error.localizedDescription)
//        }
//        
//    }
    
    func newExecuteQuery<T>(params:Parameters, mapTo: String,methodType:Alamofire.HTTPMethod = .post, completion: @escaping (Result<T, CustomError>) -> Void) where T: Codable {
        if Connectivity.isConnectedToInternet {
            print("Yes! Alamo internet is available.")
            let token = ""
            _ = ""
            var headers:HTTPHeaders = []
            
            if token != ""{
                headers = ["Authorization":token,
                           "Accept-Language": "en", "appversion": "v3"]
            }else{
                headers = [    APIConstants.HttpHeaderField.AppVersion.rawValue: APIConstants.appVersion,
                                   APIConstants.HttpHeaderField.authorization.rawValue : "",
                               APIConstants.HttpHeaderField.SDKSecret.rawValue : APIConstants.sdkSecretKey,
                                   APIConstants.HttpHeaderField.AcceptLanguage.rawValue: "en"]
            }
            
            do {
                AF.request(APIConstants.baseURL+mapTo, method:.put, parameters: params, encoding: URLEncoding.queryString, headers: headers).responseData { (response) in
                    do {
                        print("THE FULL REQUEST:", response.debugDescription)
                        switch response.result{
                        case .success( _):
                            if let code = response.response?.statusCode{
                                switch code {
                                case 200:
                                    let json = try JSON(data: response.data!)
                                    if json["status"].boolValue {
                                        //completion(.success(try JSONDecoder().decode(T.self, from: json["data"].rawData())))
                                        completion(.success(try JSONDecoder().decode(T.self, from: response.data!)))
                                    } else {
                                        //TODO: Check it with eslam::
                                        // OLD: completion(.failure(CustomError.init(somethingBadHappened: json["data"].stringValue)))
                                        // In Verify : email already verified: {"message":"Email Already Verified !","status":false}
                                        completion(.failure(CustomError.init(somethingBadHappened: json["message"].stringValue, statusCode: code )))
                                    }
                                    
                                case 400:
                                    let json = try JSON(data: response.data!)
                                    let errorAll = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                    print(errorAll)
                                    let eA = try JSONDecoder().decode([APIError].self, from: json["errors"].rawData())
                                    var errorList = ""
                                    for val in eA {
                                        errorList += "\(val.error)"+"\r\n "
                                    }
                                    
                                    completion(.failure(CustomError.init(somethingBadHappened: errorList, statusCode: code )))
                                default:
                                    let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                    print("ErrorAPI:", error)
                                    completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.customWith(statusCode: code).localizedDescription , statusCode: code )))
                                }
                            }
                        case .failure(let error):
                            print("FAILURE ERROR:", error.localizedDescription)
                            if error.localizedDescription == "Request explicitly cancelled." {
                                break
                            } else {
                                completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription, statusCode: response.response?.statusCode ?? 0 )))
                            }
                            
                        }
                        /////////////////
                    } catch let error {
                        print("Catch ERROR:", error)
                        completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.custom.localizedDescription , statusCode: response.response?.statusCode ?? 0 )))
                    }
                    
                }
            } catch {
                print("ERROR all locations ordersStatus ==>>", error.localizedDescription)
            }
        } else {
            completion(.failure(CustomError.init(somethingBadHappened: APIErrorCases.customWith(statusCode: 1).localizedDescription , statusCode: 1 )))
            
        }
    }
}
