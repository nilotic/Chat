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
    

    // MARK: - Iniitalizer
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        UINavigationBar.appearance().layoutMargins.left = 36
    }

    
    // MARK: - View
    // MARK: Public
    var body: some View {
        NavigationView {
            ZStack {
                Color("blue400")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(data.items) {
                            switch $0.data {
                            case let data as [User]:    UsersCell(data: data)
//                            case let data as [Chat]:    ChatsCell(data: data)
                            default:                    Text("")
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
            .navigationBarTitle("Chat", displayMode: .large)
        }
        .onAppear {
            data.request()
        }
    }
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
