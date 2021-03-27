// 
//  MyMessage.swift
//
//  Created by Den Jo on 2021/03/27.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct MyMessage: Identifiable {
    let id: UUID
    let text: String
    let user: User
    let date: Date
}

extension MyMessage {
    
    init(data: Message) {
        id   = data.id
        text = data.text
        user = data.user
        date = data.date
    }
}

extension MyMessage: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MyMessage: Equatable {
    
    static func ==(lhs: MyMessage, rhs: MyMessage) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension MyMessage {
    
    static var placeholder: MyMessage {
        MyMessage(id: UUID(), text: "Nothing. Just chilling and watching YouTube. What about you?", user: .placeholder, date: Date())
    }
}
#endif
