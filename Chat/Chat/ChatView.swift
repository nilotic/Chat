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
        ZStack {
            VStack(spacing: 10) {
                // Messages
                ScrollView {
                    LazyVStack(spacing: 15) {
                        Spacer()
                            .frame(height: 30)
                        
                        ForEach(data.items) {
                            switch $0.data {
                            case let data as MyMessage:     MyMessageCell(data: data)
                            case let data as UserMessage:   UserMessageCell(data: data)
                            default:                        Text("")
                            }
                        }
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
        .alert(isPresented: $data.isAlertPresented) {
            Alert(title: Text("Error"), message: Text(data.error?.localizedDescription ?? ""), dismissButton: .default(Text("OK")))
        }
        .navigationTitle(data.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: barButtonItems)
        .onAppear {
            data.connect()
        }
    }
    
    // MARK: Private
    private var barButtonItems: some View {
        HStack {
            Button(action: { }) {
                ZStack {
                    Color("blue300")
                    
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 30, height: 30)
            .cornerRadius(15)

            Button(action: { }) {
                ZStack {
                    Color("blue300")
                    
                    Image(systemName: "video.fill")
                        .resizable()
                        .frame(width: 14, height: 10)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 30, height: 30)
            .cornerRadius(15)
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
            
                
                Button(action: { data.send() }) {
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
