//
//  FoodItem.swift
//  For CC
//
//  Created by grace on 4/20/23.
//

import Foundation
import SwiftUI

class FoodItem : ObservableObject, Identifiable, Codable
{
    enum CodingKeys : CodingKey
    {
        case name
        case carbs
        case index
        case OunceOrServing
        case rounded
    }
    
    @Published var name : String = ""
    @Published var carbs : Double = 0
    @Published var index = 0
    @Published var ounceOrServing = ""
    @Published var rounded = ""
    
    var id: String = UUID().uuidString
    
    init(name: String, carbs: Double, index: Int, ounceOrServing: String, rounded: String)
    {
        self.name = name
        self.carbs = carbs
        self.index = index
        self.ounceOrServing = ounceOrServing
        self.rounded = rounded
        print(self.id)
    }
    
    
    func encode(to encoder: Encoder) throws
        {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encode(carbs, forKey: .carbs)
            try container.encode(index, forKey: .index)
            try container.encode(ounceOrServing, forKey: .OunceOrServing)
            try container.encode(rounded, forKey: .rounded)
        }
    

    required init(from decoder: Decoder) throws {
        print("decoder init called")
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        carbs = try values.decode(Double.self, forKey: .carbs)
        index = try values.decode(Int.self, forKey: .index)
        ounceOrServing = try values.decode(String.self, forKey: .OunceOrServing)
        rounded = try values.decode(String.self, forKey: .rounded)
        
    }
}
