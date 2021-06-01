//
//  StorageManager.swift
//  PersonAndChildrenApp
//
//  Created by Aleksandr Rybachev on 31.05.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "child"
    
    private init() {}
    
    func saveChild(child: Child) {
        var children = fetchChildren()
        children.append(child)
        guard let data = try? JSONEncoder().encode(children) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchChildren() -> [Child] {
        guard let data = userDefaults.object(forKey: key) as? Data else { return [] }
        guard let children = try? JSONDecoder().decode([Child].self, from: data) else { return [] }
        return children
    }
    
    func deleteChild(at index: Int) {
        var children = fetchChildren()
        children.remove(at: index)
        guard let data = try? JSONEncoder().encode(children) else { return }
        userDefaults.set(data, forKey: key)
    }
}
