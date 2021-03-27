// 
//  MyMessageCell.swift
//
//  Created by Den Jo on 2021/03/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct MyMessageCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: MyMessage
    
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
            // Date
            Text(date)
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(Color("purple300"))
            
            Spacer()
                
            
            // Message
            Text(data.text)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color("purple500"))
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15))
                .background(Color("gray200"))
                .clipShape(RoundedShape(radius: 45, corners: [.topLeft, .topRight, .bottomLeft]))
        }
        .padding(.horizontal, 34)
    }
}

#if DEBUG
struct MessageCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = MyMessageCell(data: .placeholder)
        
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
