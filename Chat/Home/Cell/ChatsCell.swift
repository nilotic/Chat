// 
//  ChatsCell.swift
//
//  Created by Den Jo on 2021/03/24.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ChatsCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: [Chat]
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            Color(.white)
            
            LazyVStack {
                ForEach(data) {
                    ChatCell(data: $0)
                }
            }
        }
        .clipShape(RoundedShape(radius: 30, corners: [.topLeft, .topRight]))
    }
}

#if DEBUG
struct ChatsCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = ChatsCell(data: [.placeholder, .placeholder, .placeholder, .placeholder, .placeholder,
                                    .placeholder, .placeholder, .placeholder, .placeholder, .placeholder])
        
        Group {
            view
                .previewDevice("iPhone 8")
                .preferredColorScheme(.light)
                
            view
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
