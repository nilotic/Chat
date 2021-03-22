// 
//  User.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    let id: Int
    let name: String
    let imageURL: URL?
}

extension User: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension User: Equatable {
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

extension User: Decodable  {
    
    private enum Key: String, CodingKey {
        case id
        case name
        case imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { id       = try container.decode(Int.self,    forKey: .id) }       catch { throw error }
        do { name     = try container.decode(String.self, forKey: .name) }     catch { throw error }
        do { imageURL = try container.decode(URL.self,    forKey: .imageURL) } catch { imageURL = nil }
    }
}

#if DEBUG
extension User {
    
    static var placeholder: User {
        User(id: 0, name: "user0", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji6.png?raw=true"))
    }
}
#endif
