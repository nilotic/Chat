// 
//  MessageCell.swift
//
//  Created by Den Jo on 2021/03/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct MessageCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: Message
    
    // MARK: Private
    private let user: User = .placeholder
    
    private var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmm")

        return dateFormatter.string(from: data.date)
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        switch data.user == user {
        case true:  myMessageView
        case false: userMessageView
        }
    }
    
    // MARK: Private
    private var myMessageView: some View {
        HStack(alignment: .bottom, spacing: 10) {
            Text(date)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("purple300"))
            
            Spacer()
            
            ZStack {
                Color("purple100")
                Text(data.text)
                    .padding(30)
            }
            .clipShape(RoundedShape(radius: 50, corners: [.topLeft, .topRight, .bottomLeft]))
        }
    }
    
    private var userMessageView: some View {
        HStack(alignment: .bottom, spacing: 10) {
            ImageView(url: data.user.imageURL)
                .frame(width: 40, height: 40)
                .background(Color("purple100"))
                .cornerRadius(20)
            
            ZStack {
                Color("purple100")
                Text(data.text)
                    .padding(30)
            }
            .clipShape(RoundedShape(radius: 50, corners: [.topLeft, .topRight, .bottomRight]))
            
            Spacer()
            
            Text(date)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("purple300"))
        }
    }
}

#if DEBUG
struct MessageCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = MessageCell(data: .placeholder)
        
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
