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
    @Published var items = [Item]()
    @Published var isProgressing = false
    
    @Published var isAlertPresented = false
    var error: Error? = nil
    
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
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    
    // MARK: - Initializer
    init(data: Binding<Chat>) {
        _chat = data
    }
    
    
    // MARK: - Function
    // MARK: Public
    func connect() {
        task.resume()
        setReceiver()
    }
    
    func send() {
        guard message != "" else { return }
        let data = Message(id: UUID(), text: self.message, user: .placeholder, date: Date())
        message = ""
       
        do {
            task.send(.data(try encoder.encode(data))) { [weak self] error in
                guard let self = self else { return }
                
                guard error == nil else {
                    log(.error, error?.localizedDescription ?? "")
                    return
                }
                
                let item = Item(data: MyMessage(data: data))
                DispatchQueue.main.async { self.items.append(item) }
            }
            
        } catch {
            log(.error, error.localizedDescription)
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
                    do {
                        let message = try self.decoder.decode(Message.self, from: data)
                        let item = Item(data: UserMessage(id: UUID(), text: "Echo :  \(message.text)", user: User.random, date: Date()))
                            
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.items.append(item)
                        }
                    
                    } catch {
                        log(.error, error.localizedDescription)
                    }
                
                case .string(let data):
                    let item = Item(data: UserMessage(id: UUID(), text: "Echo :  \(data)", user: User.random, date: Date()))
                    DispatchQueue.main.async { self.items.append(item) }
                
                default:
                  break
                }
                
                self.setReceiver()
                
            case .failure(let error):
                self.error = error
                self.isAlertPresented = true
            }
        }
    }
}
