// 
//  ChatData.swift
//
//  Created by Den Jo on 2021/03/25.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

final class ChatData: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Binding var chat: Chat
    
    @Published var message = ""
    @Published var messages = [Message]()
    @Published var isProgressing = false
    
    let user: User = .placeholder
    
    var name: String {
        var components = PersonNameComponents()
        components.givenName  = chat.user.firstName
        components.familyName = chat.user.lastName
        
        return PersonNameComponentsFormatter.localizedString(from: components, style: .long, options: [])
    }
    
    // MARK: Private
    private let task = URLSession(configuration: .default).webSocketTask(with: URL(string: "ws://echo.websocket.org")!)
    
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    
    // MARK: - Initializer
    init(data: Binding<Chat>) {
        _chat = data
        
        task.resume()
        setReceiver()
    }
    
    
    // MARK: - Function
    // MARK: Public
    func send() {
        guard message != "" else { return }
        let message = Message(id: UUID(), text: self.message, user: .placeholder, date: Date())
       
        guard let data = try? encoder.encode(message) else { return }
        
        task.send(.data(data)) { [weak self] error in
            guard let self = self else { return }
            
            guard error == nil else {
                log(.error, error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async { self.messages.append(message) }
        }
    }
    
    // MARK: Private
    private func setReceiver() {
        task.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                switch data {
                case .data(let data):
                    log(.info, String(data: data, encoding: .utf8))
                
                case .string(let data):
                    log(.info, data)
                
                default:
                  break
                }
                
            case .failure(let error):
                log(.error, error.localizedDescription)
            }
    
            self.setReceiver()
        }
    }
}
