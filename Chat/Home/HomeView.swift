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
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(data.items) {
                            switch $0.data {
                            case let data as [User]:
                                Text("\(data.count)")

                            default:
                                Text("")
                            }
                        }
                    }
                }
                
                
                // Progress
                if data.isProgressing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.2, anchor: .center)
                }
            }
            .navigationBarTitle("Chat with your friends", displayMode: .large)
            
        }
        .onAppear {
            data.request()
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
