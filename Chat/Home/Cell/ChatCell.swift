// 
//  ChatCell.swift
//
//  Created by Den Jo on 2021/03/24.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ChatCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: Chat
    
    // MARK: Private
    private var name: String {
        var components = PersonNameComponents()
        components.givenName  = data.user.firstName
        components.familyName = data.user.lastName
        
        return PersonNameComponentsFormatter.localizedString(from: components, style: .long, options: [])
    }
        
    private var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMddHHmm")
        
        return dateFormatter.string(from: data.date)
    }
    
    private let colors = [Color("blue100"), Color("blue200"), Color("blue300"),
                          Color("orange100"),
                          Color("pink100"), Color("pink200"), Color("pink300"),
                          Color("purple100"), Color("purple200"),
                          Color("yellow100")]
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 10) {
            ImageView(url: data.user.imageURL)
                .frame(width: 66, height: 66)
                .background(colors.randomElement())
                .cornerRadius(33)

            VStack(spacing: 7) {
                HStack {
                    Text(name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("purple500"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(date)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color("purple300"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.leading, 10)
                }
                
                Text(data.message)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("purple400"))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(EdgeInsets(top: 0, leading: 3, bottom: 10, trailing: 0))
        }
        .padding(.horizontal, 38)
    }
}

#if DEBUG
struct ChatCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = ChatCell(data: .placeholder)
        
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
