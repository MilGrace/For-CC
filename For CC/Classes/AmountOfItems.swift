//
//  CurrentIndex.swift
//  For CC
//
//  Created by grace on 5/3/23.
//

import Foundation
import SwiftUI

class AmountOfItems: ObservableObject, Codable
{
    enum CodingKeys : CodingKey
    {
        case amountOfItems
    }
    
    @Published var amountOfItems = 0
    
    init()
    {
        amountOfItems = 0
    }
    
    func encode(to encoder: Encoder) throws
    {
        print("encode called")
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(amountOfItems, forKey: .amountOfItems)
    }

    required init(from decoder: Decoder) throws {
        print("decoder init called")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        amountOfItems = try container.decode(Int.self, forKey: .amountOfItems)
    }
}
