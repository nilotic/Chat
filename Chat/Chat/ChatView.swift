// 
//  ChatView.swift
//
//  Created by Den Jo on 2021/03/24.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    // MARK: - Value
    // MARK: Public
    @ObservedObject var data: ChatData
    
    
    // MARK: - Initializer
    init(data: Binding<Chat>) {
        self.data = ChatData(data: data)
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        NavigationView {
            VStack {
                // Messages
                ScrollView {
                    ForEach(data.messages) {
                        MessageCell(data: $0)
                    }
                }
            
                Spacer()
                
                // TextField
                textField
            }
            
            // Progress
            if data.isProgressing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.2, anchor: .center)
            }
        }
        .navigationTitle(data.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: barButtonItems)
    }
    
    // MARK: Private
    private var barButtonItems: some View {
        HStack {
            Button(action: { }) {
                ZStack {
                    Color("blue300")
                    
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 32, height: 32)
            .cornerRadius(16)

            Button(action: { }) {
                ZStack {
                    Color("blue300")
                    
                    Image(systemName: "video.fill")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 32, height: 32)
            .cornerRadius(16)
        }
    }
    
    private var textField: some View {
        ZStack {
            Color("purple100")
            HStack {
                TextField("Type your message...", text: $data.message) { isChanged in
                    
                } onCommit: {
                    data.send()
                }
                .font(.system(size: 14, weight: .regular))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 21)
            
                
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    data.send()
                    
                }) {
                    ZStack {
                        Color("blue400")
                        
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: 45))
                            .offset(x: -1, y: 0)
                    }
                }
                .frame(width: 32, height: 32)
                .cornerRadius(16)
                .padding(.trailing, 10)
            }
        }
        .frame(height: 58)
        .cornerRadius(29)
        .padding(EdgeInsets(top: 0, leading: 26, bottom: 13, trailing: 26))
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = ChatView(data: .constant(.placeholder))
        
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
