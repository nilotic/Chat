// 
//  UsersResponse.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct UsersResponse {
    let users: [User]
}

extension UsersResponse: Decodable {
    
    private enum Key: String, CodingKey {
        case users
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { users = try container.decode([User].self, forKey: .users) } catch { users = [] }
    }
}

