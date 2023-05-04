//
//  ArrayClass.swift
//  For CC
//
//  Created by grace on 4/21/23.
//

import Foundation
import SwiftUI

class ArrayClass: ObservableObject, Codable
{

    enum CodingKeys : CodingKey
    {
        case allFoods
    }
    
//    @Published var allFoods: Array<FoodItem> = Array()
    @Published var allFoods: [FoodItem] = []
    
    init()
    {
        allFoods = []
    }
    
    
    func encode(to encoder: Encoder) throws
    {
        print("encode called")
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(allFoods, forKey: .allFoods)
    }

    required init(from decoder: Decoder) throws {
        print("decoder init called")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        allFoods = try container.decode(Array.self, forKey: .allFoods)
    }
}
