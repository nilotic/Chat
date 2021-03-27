// 
//  UserMessageCell.swift
//
//  Created by Den Jo on 2021/03/27.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct UserMessageCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: UserMessage
    
    // MARK: Private
    private var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmm")

        return dateFormatter.string(from: data.date)
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .bottom, spacing: 8) {
                // Image
                ImageView(url: data.user.imageURL)
                    .frame(width: 34, height: 34)
                    .background(Color("purple100"))
                    .cornerRadius(17)
                
                
                // Message
                Text(data.text)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("purple500"))
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15))
                    .background(Color("gray100"))
                    .clipShape(RoundedShape(radius: 45, corners: [.topLeft, .topRight, .bottomRight]))
            }
            
            Spacer()
            
            
            // Date
            Text(date)
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(Color("purple300"))
        }
        .padding(.horizontal, 34)
    }
}

#if DEBUG
struct UserMessageCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = UserMessageCell(data: .placeholder)
        
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

