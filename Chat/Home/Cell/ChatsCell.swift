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
    @Binding var data: [Chat]
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            Color(.white)
            
            LazyVStack(spacing: 43) {
                ForEach(data.indices, id: \.self) { index in
                    NavigationLink(destination: ChatView(data: $data[index])) {
                        ChatCell(data: data[index])
                    }
                }
            }
            .padding(.vertical, 61)
        }
        .cornerRadius(38)
    }
}

#if DEBUG
struct ChatsCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = ChatsCell(data: .constant([.placeholder, .placeholder, .placeholder, .placeholder, .placeholder,
                                              .placeholder, .placeholder, .placeholder, .placeholder, .placeholder]))
        
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
