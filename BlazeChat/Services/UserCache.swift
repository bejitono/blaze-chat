//
//  UserCache.swift
//  BlazeChat
//
//  Created by De MicheliStefano on 12.01.21.
//

import Foundation

protocol UserCachable {
    
    func set<Data>(_ data: Data) where Data: UserCacheStringConvertible
    func get<Data>() -> Data? where Data: UserCacheStringConvertible
}

protocol UserCacheStringConvertible: Codable {
    static var key: String { get }
}

final class UserCache: UserCachable {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func set<Data>(_ data: Data) where Data: UserCacheStringConvertible {
        if let encoded = try? JSONEncoder().encode(data) {
            userDefaults.set(encoded, forKey: Data.key)
        }
    }
    
    func get<Data>() -> Data? where Data: UserCacheStringConvertible {
        guard let data = userDefaults.object(forKey: Data.key) as? Foundation.Data,
              let decoded = try? JSONDecoder().decode(Data.self, from: data) else {
            return nil
        }
        return decoded
    }
}
