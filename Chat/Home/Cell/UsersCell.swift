// 
//  UsersCell.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct UsersCell: View {
    
    // MARK: - Value
    // MARK: Public
    let data: [User]
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                searchIcon
                            
                ForEach(data) {
                    UserCell(data: $0)
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 40)
        }
        .frame(height: 100)
    }
    
    // MARK: Private
    private var searchIcon: some View {
        ZStack {
            Color("blue300")
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
        }
        .frame(width: 40, height: 40)
        .cornerRadius(20)
    }
}

#if DEBUG
struct UsersCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let users: [User] = [.placeholder, .placeholder, .placeholder,
                             .placeholder, .placeholder, .placeholder,
                             .placeholder, .placeholder, .placeholder]
        
        let view = UsersCell(data: users)
        
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
