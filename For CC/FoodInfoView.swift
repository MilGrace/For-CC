//
//  FoodInfoView.swift
//  For CC
//
//  Created by grace on 4/21/23.
//

import SwiftUI

struct FoodInfoView: View {
    
       
    @EnvironmentObject var allFoods : ArrayClass
    @EnvironmentObject var amount : AmountOfItems
    @Environment(\.dismiss) var dismiss
    @State var currentFood: FoodItem = FoodItem(name: "", carbs: 0, index: 0, ounceOrServing: "",rounded:"")
    @State var showingAlert = false
    
   
    
    var body: some View {
        VStack
        {
            
                Text("\(currentFood.name)")
                    .font(.system(size: 36))
                    .padding()
            Text("\(currentFood.rounded) carbs per \(currentFood.ounceOrServing)")
                    .font(.system(size: 25))
                    
                
                Button("Delete")
                {
                   showingAlert = true
                }
                
                .offset(y:100)
                .foregroundColor(.red)
                .alert("Are you sure?", isPresented: $showingAlert)
            {
                Button("Cancel", role: .cancel)
                {
                    
                }
                Button("Delete", role: .destructive)
                {
                    deleteItem()
                }
            }
            }
            
        }
    
    func saveToUserDefaults()
    {
//        var myNum = 12
//
//        UserDefaults.setValue(myNum, forKey: "highScore")
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data1 = try encoder.encode(allFoods)
            let data2 = try encoder.encode(amount)
            // Write/Set Data
                UserDefaults.standard.set(data1, forKey: "allFoods")
            UserDefaults.standard.set(data2, forKey: "amount")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func deleteItem()
    {
        allFoods.allFoods.removeAll(where: {
            $0.id == self.currentFood.id
        })
       
//        allFoods.allFoods.remove(at: currentFood.index)
        //amount.amountOfItems -= 1
        dismiss()
        
        saveToUserDefaults()
        

    }
    
    }
    
    struct FoodInfoView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                FoodInfoView()
                    
            }
           
            .environmentObject(ArrayClass())
            .environmentObject(AmountOfItems())
        }
    }

