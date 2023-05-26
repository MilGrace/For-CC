//
//  For_CCApp.swift
//  For CC
//
//  Created by grace on 4/13/23.
//

import SwiftUI

@main
struct For_CCApp: App {

    @StateObject var amount = AmountOfItems()
    @StateObject var allFoods = ArrayClass()
    @StateObject var foodItem = FoodItem(name:"",carbs:0,index:0,ounceOrServing:"",rounded:"")
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()

            }
            .environmentObject(amount)
            .environmentObject(allFoods)
            .environmentObject(foodItem)

        }
    }
}
