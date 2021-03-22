//
//  URLRequestExtension.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

extension URLRequest {
    
    // MARK: - Initializer
    init(httpMethod: HTTPMethod, url: ServiceURL) {
        self.init(url: url.rawValue)
        
        // Set request
        self.httpMethod = httpMethod.rawValue
        timeoutInterval = 90
        
        guard let host = url.rawValue.host, server.rawValue.contains(host) else { return }
        let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        let userAgent = "ZigZag/\(appVersion) (\(UIDevice.current.model) iOS \(UIDevice.current.systemVersion))"
        
        setValue(userAgent, forHTTPHeaderField: HTTPHeaderField.userAgent.rawValue)
        setValue("gzip",    forHTTPHeaderField: "Accept-Encoding")
        
        #if DEBUG
        setValue("hK7h9kuCMvUxIim5x8enEY8q8GgFeQzQ", forHTTPHeaderField: "Croquis-Enable-Introspection")
        #endif
        
        guard let systemLanguageCode = Locale.preferredLanguages.first else { return }
        setValue(systemLanguageCode, forHTTPHeaderField: "Accept-Language")
    }
    
    
    // MARK: - Function
    // MARK: Public
    mutating func add(value: HTTPHeaderValue, field: HTTPHeaderField) {
        addValue(value.rawValue, forHTTPHeaderField: field.rawValue)
    }
    
    mutating func add(value: String, field: HTTPHeaderField) {
        addValue(value, forHTTPHeaderField: field.rawValue)
    }
}
 
extension URLRequest {
    
    var debugDescription: String {
        return """
               Request
               URL
               \(httpMethod ?? "") \(url?.absoluteString ?? "")\n
               HeaderField
               \(allHTTPHeaderFields?.debugDescription ?? "")\n
               Body
               \(String(data: httpBody ?? Data(), encoding: .utf8) ?? "")
               \n\n
               """
    }
}
