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
    
    // MARK: Private
    private let colors = [Color("blue100"), Color("blue200"), Color("blue300"), Color("blue400"),
                          Color("orange100"),
                          Color("pink100"), Color("pink200"), Color("pink300"),
                          Color("purple100"), Color("purple200"),
                          Color("yellow100")]
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ImageView(url: data.imageURL)
            .frame(width: 40, height: 40)
            .background(colors.randomElement())
            .cornerRadius(20)
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
