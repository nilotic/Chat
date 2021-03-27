// 
//  UserMessage.swift
//
//  Created by Den Jo on 2021/03/27.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct UserMessage: Identifiable {
    let id: UUID
    let text: String
    let user: User
    let date: Date
}

extension UserMessage: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension UserMessage: Equatable {
    
    static func ==(lhs: UserMessage, rhs: UserMessage) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension UserMessage {
    
    static var placeholder: UserMessage {
        UserMessage(id: UUID(), text: "Hey there! What's up?", user: User(id: 1, firstName: "Sam", lastName: "Tom", imageURL: nil), date: Date())
    }
}
#endif
