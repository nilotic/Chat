// 
//  Message.swift
//
//  Created by Den Jo on 2021/03/25.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct Message: Identifiable {
    let id: UUID
    let text: String
    let user: User
    let date: Date
}

extension Message: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Message: Equatable {
    
    static func ==(lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}

extension Message: Codable  {
    
    private enum Key: String, CodingKey {
        case id
        case user
        case text
        case date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(id,   forKey: .id) }   catch { throw error }
        do { try container.encode(text, forKey: .text) } catch { throw error }
        do { try container.encode(user, forKey: .user) } catch { throw error }
        do { try container.encode(date, forKey: .date) } catch { throw error }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        do { id   = try container.decode(UUID.self,   forKey: .id) }   catch { throw error }
        do { text = try container.decode(String.self, forKey: .text) } catch { throw error }
        do { user = try container.decode(User.self,   forKey: .user) } catch { throw error }
        do { date = try container.decode(Date.self,   forKey: .date) } catch { throw error }
    }
}

#if DEBUG
extension Message {
    
    static var placeholder: Message {
        Message(id: UUID(), text: "Nothing. Just chilling and watching YouTube. What about you?", user: .placeholder, date: Date())
    }
}
#endif
