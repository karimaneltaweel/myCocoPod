//
//  WebAPIConstants.swift
//  Jibley Customer App
//
//  Copyright © 2018 ES Inc. All rights reserved.
//

import Foundation

struct APIConstants {
    
    // API base URL
    static var sdkURL = "https://sdktest.advaeg.net/"
    static var baseURL = "https://sdktest.advaeg.net/sdk/api/v1"
    static var appVersion = "v3"
    static var sdkSecretKey = ""
    
    // Header
    enum HttpHeaderField: String {
        case AcceptLanguage = "Accept-Language"
        case authorization = "Authorization"
        case userGuestID = "GuestId"
        case AppVersion = "AppVersion"
        case SDKSecret = "SDK-Secret"
        case UserAgent = "User-Agent"
    }
    
}
