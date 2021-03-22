//
//  Response.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct Response {
    let url: URL
    let headerFields: [AnyHashable: Any]
    var data: Data?                = nil
    var statusCode: HTTPStatusCode = .none
}

extension Response {
    
    init(data: Data?, urlResponse: URLResponse?) throws {
        guard let urlResponse = urlResponse as? HTTPURLResponse, let url = urlResponse.url else { throw URLError(.badServerResponse) }
        
        self.url          = url
        self.headerFields = urlResponse.allHeaderFields
        self.data         = data
        
        statusCode = HTTPStatusCode(rawValue: urlResponse.statusCode) ?? .none
    }
}

extension Response: CustomDebugStringConvertible {
    
    var debugDescription: String {
        """
        Response
        HTTP status: \(statusCode.rawValue)
        URL: \(url.absoluteString)\n
        HeaderField
        \(headerFields.debugDescription))\n
        Data
        \(String(data: data ?? Data(), encoding: .utf8) ?? "")
        \n
        """
    }
}
