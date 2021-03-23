// 
//  HomeData.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

final class HomeData: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Published var items         = [Item]()
    @Published var isProgressing = false
    
    // MARK: Private
    private var cancellable: AnyCancellable? = nil
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        cancellable?.cancel()
        cancellable = Publishers.Zip(requestUsers(), requestChats())
            .eraseToAnyPublisher()
            .tryMap { (response: (users: [User], chats: [Chat])) -> [Item] in
                var items = [Item]()
                items.append(Item(data: response.users))
                items.append(Item(data: response.chats))
                
                return items
            }
            .receive(on: DispatchQueue.main)
            .sink {
                switch $0 {
                case .finished:             break
                case .failure(let error):   log(.error, error.localizedDescription)
                }
                
            } receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.isProgressing = false

                guard self.items != items else { return }
                self.items = items
            }
        
    }
    
    // MARK: Private
    private func requestUsers() -> AnyPublisher<[User], Error> {
        let request = URLRequest(httpMethod: .get, url: .users)
        
        return NetworkManager.shared.request(urlRequest: request)
            .tryMap { response -> [User] in
                guard let responseData = response.data else { throw URLError(.badServerResponse) }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                return (try decoder.decode(UsersResponse.self, from: responseData)).users
            }
            .eraseToAnyPublisher()
    }
    
    private func requestChats() -> AnyPublisher<[Chat], Error> {
        let request = URLRequest(httpMethod: .get, url: .chats)
        
        return NetworkManager.shared.request(urlRequest: request)
            .tryMap { response -> [Chat] in
                guard let responseData = response.data else { throw URLError(.badServerResponse) }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                return (try decoder.decode(ChatsResponse.self, from: responseData)).chats
            }
            .eraseToAnyPublisher()
    }
}
