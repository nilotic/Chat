//
//  Host.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

var server: Host.Server = .alpha

enum Host {
    enum Server {
        case alpha
        case beta
        case production
    }
    
    case chat(server: Server)
    case s3
}

extension Host {
    
     var rawValue: String {
         switch self {
     #if DEBUG
         case .chat(let server):  return server.rawValue
         
     #else
         case .chat(_):           return "https://github.com"
     #endif
         
         case .s3:                return "https://s3.ap-northeast-2.amazonaws.com"
         }
     }
     
     var url: URL {
        URL(string: self.rawValue)!
     }
}

extension Host {
   
    init?(rawValue: String?) {
        guard let rawValue = rawValue else { return nil }
        
        switch rawValue {
    #if DEBUG
        case Host.chat(server: .alpha).rawValue:         self = .chat(server: .alpha)
        case Host.chat(server: .beta).rawValue:          self = .chat(server: .beta)
        case Host.chat(server: .production).rawValue:    self = .chat(server: .production)
            
    #else
        case Host.chat(server: .alpha).rawValue:         self = .chat(server: .production)
        case Host.chat(server: .beta).rawValue:          self = .chat(server: .production)
        case Host.chat(server: .production).rawValue:    self = .chat(server: .production)
    #endif
        
        case Host.s3.rawValue:                             self = .s3
        default:                                           return nil
        }
    }
}

extension Host.Server {
    
    var rawValue: String {
        switch self {
        #if DEBUG
        case .alpha:       return "https://github.com"
        case .beta:        return "https://github.com"
        case .production:  return "https://github.com"
        
        #else
        default:           return "https://github.com"
        #endif
        }
    }
}

extension Host.Server: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension Host.Server: CustomDebugStringConvertible {
    
    var debugDescription: String {
        #if DEBUG
        switch self {
        case .alpha:        return "Alpha server"
        case .beta:         return "Beta server"
        case .production:   return "Production server"
        }
        
        #else
        return ""
        #endif
    }
}
