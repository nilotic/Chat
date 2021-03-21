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

#if DEBUG
extension User {
    
    static var placeholder: User {
        User(id: 0, name: "user0", imageURL: URL(fileURLWithPath: Bundle.main.path(forResource: "memoji1", ofType: "png") ?? ""))
    }
}
#endif
