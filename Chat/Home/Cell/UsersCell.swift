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
            LazyHStack(spacing: 17) {
                searchIcon
                            
                ForEach(data) {
                    UserCell(data: $0)
                }
            }
            .padding(.horizontal, 38)
        }
        .frame(height: 78)
        .padding(.bottom, 14)
    }
    
    // MARK: Private
    private var searchIcon: some View {
        ZStack {
            Color("blue300")
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
        }
        .frame(width: 50, height: 50)
        .cornerRadius(25)
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
