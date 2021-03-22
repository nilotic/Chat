// 
//  ChatsResponse.swift
//
//  Created by Den Jo on 2021/03/22.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ChatsResponse {
    let chats: [Chat]
}

extension ChatsResponse: Decodable {
    
    private enum Key: String, CodingKey {
        case chats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { chats = try container.decode([Chat].self, forKey: .chats) } catch { chats = [] }
    }
}

