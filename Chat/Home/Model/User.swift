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
        User(id: 0, firstName: "Adney", lastName: "Bares", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji1.png?raw=true"))
    }
    
    static var random: User {
        let users = [User(id: 1,  firstName: "Adney",  lastName: "Barrell", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji2.png?raw=true")),
                     User(id: 2,  firstName: "Aldo",   lastName: "Bailey", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji3.png?raw=true")),
                     User(id: 3,  firstName: "Anson",  lastName: "Davies", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji4.png?raw=true")),
                     User(id: 4,  firstName: "Brice",  lastName: "Fisher", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji5.png?raw=true")),
                     User(id: 5,  firstName: "Corky",  lastName: "Ford", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji6.png?raw=true")),
                     User(id: 6,  firstName: "Daelen", lastName: "Gibson", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji7.png?raw=true")),
                     User(id: 7,  firstName: "Dana",   lastName: "Paul", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji8.png?raw=true")),
                     User(id: 8,  firstName: "Bryce",  lastName: "Hill", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji9.png?raw=true")),
                     User(id: 9,  firstName: "Gala",   lastName: "O'Moore", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji10.png?raw=true")),
                     User(id: 10, firstName: "Justin", lastName: "Cordova", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji11.png?raw=true")),
                     User(id: 11, firstName: "Alaya",  lastName: "Sheridan", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji12.png?raw=true")),
                     User(id: 12, firstName: "Cecily", lastName: "Trujillo", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji13.png?raw=true")),
                     User(id: 13, firstName: "Komal",  lastName: "Orr", imageURL: URL(string: "https://github.com/nilotic/Chat/blob/develop/memoji/memoji14.png?raw=true"))]
        
        return users.randomElement()!
    }
}
#endif
