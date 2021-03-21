//
//  HomeData.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Value
    // MARK: Public
    @ObservedObject var data = HomeData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        NavigationView {
         
            Group {
                ScrollView(.horizontal, showsIndicators: false) {
                    List(0..<10) { number in
                        Text("\(number)")
                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundColor(data.type == page.type ? Color("gray900") : Color("gray600"))
                            .frame(maxWidth: .infinity)
                    }
                }
                
            }
            .navigationBarTitle("Test", displayMode: .large)
        }
    }
    
    // MARK: Private
    
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = HomeView()
        
        Group {
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
}
#endif
