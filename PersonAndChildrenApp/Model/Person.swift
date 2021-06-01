//
//  Person.swift
//  PersonAndChildrenApp
//
//  Created by Aleksandr Rybachev on 31.05.2021.
//

struct Person: Codable {
    let surname: String
    let firstName: String
    let middleName: String
    let age: String
    
    let children: [Child]
}

struct Child: Codable {
    let name: String
    let age: String
}
