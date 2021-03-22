// 
//  Chat.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Chat {
    let user: User
    let message: String
    let date: Date
}

extension Chat: Identifiable {
    
    var id: String {
        "\(user.id)\(message)\(date)"
    }
}

extension Chat: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Chat: Equatable {
    
    static func ==(lhs: Chat, rhs: Chat) -> Bool {
        lhs.user.id == rhs.user.id
    }
}

extension Chat: Decodable  {
    
    private enum Key: String, CodingKey {
        case user
        case message
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { user    = try container.decode(User.self,   forKey: .user) }    catch { throw error }
        do { message = try container.decode(String.self, forKey: .message) } catch { throw error }
        do { date    = try container.decode(Date.self,   forKey: .date) }    catch {
            throw error
            
        }
    }
}

#if DEBUG
extension Chat {
    
    static var placeholder: Chat {
        Chat(user: .placeholder, message: "Hey there! What's up? Is everthing...", date: Date())
    }
}
#endif
