// 
//  User.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let imageURL: URL?
}

extension User: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension User: Equatable {
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

extension User: Codable {
    
    private enum Key: String, CodingKey {
        case id
        case firstName
        case lastName
        case imageURL
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(id,        forKey: .id) }        catch { throw error }
        do { try container.encode(firstName, forKey: .firstName) } catch { throw error }
        do { try container.encode(lastName,  forKey: .lastName) }  catch { throw error }
        do { try container.encode(imageURL,  forKey: .imageURL) }  catch { throw error }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { id        = try container.decode(Int.self,    forKey: .id) }        catch { throw error }
        do { firstName = try container.decode(String.self, forKey: .firstName) } catch { throw error }
        do { lastName  = try container.decode(String.self, forKey: .lastName) }  catch { throw error }
        do { imageURL  = try container.decode(URL.self,    forKey: .imageURL) }  catch { imageURL = nil }
    }
}

#if DEBUG
extension User {
    
    static var placeholder: User {
        User(id: 0, firstName: "Adney", lastName: "Bares", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji6.png?raw=true"))
    }
}
#endif
