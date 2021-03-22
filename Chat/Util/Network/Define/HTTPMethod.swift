//
//  HTTPMethod.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case put    = "PUT"
    case post   = "POST"
    case get    = "GET"
    case delete = "DELETE"
}

extension HTTPMethod {
    
    init?(request: URLRequest?) {
        guard let string = request?.httpMethod, let method = HTTPMethod(rawValue: string) else { return nil }
        self = method
    }
}
