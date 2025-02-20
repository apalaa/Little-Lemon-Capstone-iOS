//
//  MenuItem.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/4/25.
//

struct MenuItem: Decodable {
    
    let title: String
    let image: String
    let price: String
    
    // Optional Properties
    let description: String
    let category: String
    let id: Int
    
}
