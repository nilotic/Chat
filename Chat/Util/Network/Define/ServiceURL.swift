//
//  ServiceURL.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ServiceURL {
    case users
    case chats
}

extension ServiceURL {
    
    var rawValue: URL {
        switch self {
        case .users:  return URL(string: "\(Host.chat(server: server).rawValue)/nilotic/Chat/blob/master/json/users.json")!
        case .chats:  return URL(string: "\(Host.chat(server: server).rawValue)/nilotic/Chat/blob/master/json/chats.json")!
        }
    }
}
