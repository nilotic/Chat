// 
//  EmojiCell.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct UserCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: User
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ImageView(url: data.imageURL)
            .frame(width: 32, height: 32)
            .background(Color("gray200"))
            .cornerRadius(24)
    }
}

#if DEBUG
struct EmojiCell_Previews: PreviewProvider {

    static var previews: some View {
        let view = UserCell(data: .placeholder)
        
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
