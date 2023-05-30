//
//  ContentView.swift
//  For CC
//
//  Created by grace on 4/13/23.
//

import SwiftUI





struct ContentView: View {
    
    @EnvironmentObject var amount: AmountOfItems
    @EnvironmentObject var allFoods : ArrayClass
    @EnvironmentObject var foodItem : FoodItem
    
    @State var foodName = ""
    @State var carbs = ""
    @State var showingAC = false
    @State var showingAlert = false
    @State var  searchItem = ""
    @State var ounceOrServing = ""
    
    init()
    {
       
    }
    var body: some View {
        VStack
        {
            HStack
            {
                                
            }
            .toolbar {
                ToolbarItem(placement: .principal)
                {
                    TextField("Search...", text: $searchItem)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .onTapGesture {
                                  self.hideKeyboard()
                                }
                }
                
                
                
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button {
                        showingAC = true
                        //
                        
                        
                    }
                label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
                .confirmationDialog("Select measurement", isPresented: $showingAC, titleVisibility: .visible) {
                    Button("Per ounce") {
                        ounceOrServing = "Ounce"
                        showAlert()
                    }
                    
                    Button("Per serving") {
                        ounceOrServing = "Serving"
                        showAlert()
                    }
                    Button("Per tablespoon")
                    {
                        ounceOrServing = "Tablespoon"
                        showAlert()
                    }
                    Button("Per cup")
                    {
                        ounceOrServing = "Cup"
                        showAlert()
                    }
                    
                }
                .alert("Enter Info", isPresented: $showingAlert)
                    {
                        TextField("name of food", text: $foodName)
                            .foregroundColor(.black)
                        TextField("amount of carbs", text: $carbs)
                            .foregroundColor(.black)
                        Button("Ok", role: .none)
                        {
                            print("saved")
                            
                            
                            let newFood = FoodItem(name: foodName, carbs: Double(carbs) ?? 0, index: (allFoods.allFoods).count, ounceOrServing: ounceOrServing, rounded: "")
                            let rounded = String(format: "%.2f", newFood.carbs)
                            newFood.rounded = rounded
                            allFoods.allFoods.append(newFood)
                            newFood.index = allFoods.allFoods.count - 1
                            //amount.amountOfItems += 1
                            saveToUserDefaults()
                            foodName = ""
                            carbs = ""
                            
                        }
                        Button("Cancel", role: .cancel)
                        {
                            
                        }
                    }
                    
                }
            }
            
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    if (searchItem == "")
                    {
                        ForEach((allFoods.allFoods)) { item in
                            
                            NavigationLink {
                                FoodInfoView(currentFood: item)
                            } label: {
                                Text(item.name)
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(width: 300, height: 100)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(.gray)
                                    )
                                    
                            }
                            
                            //                        NavigationLink(item.name) {
                            //                            FoodInfoView(currentFood: item)
                            //                        }
                            
                        }
                        //
                    }
                    else
                    {
                        ForEach((allFoods.allFoods))
                        {
                            item in
                            
                            if ((item.name).lowercased().contains(searchItem.lowercased()))
                                
                                
                            {
                                
                                NavigationLink(item.name)
                                {
                                    FoodInfoView(currentFood: item)
                                }
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: 300, height: 100)
                                .background(.gray)
                                
                            }
                        }
                    }
                }
            }
        
            .frame(height: 500, alignment: .bottom)
            .padding()
            .offset(y:50)
            .onAppear(perform: loadFromUserDefaults)
            
            
            
        }
        
        
        .padding()
    }
    func showAlert()
    {
        showingAlert = true
        
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
    
    func loadFromUserDefaults()
    {
       
//        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        if let data1 = UserDefaults.standard.data(forKey: "allFoods") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let note = try decoder.decode(ArrayClass.self, from: data1)
                allFoods.allFoods = note.allFoods

            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
        
        }
        if let data2 = UserDefaults.standard.data(forKey: "amount") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let note = try decoder.decode(AmountOfItems.self, from: data2)
                amount.amountOfItems = note.amountOfItems

            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
        
        }
        
        print(amount.amountOfItems)
    }
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                
        }
        .environmentObject(AmountOfItems())
        .environmentObject(ArrayClass())
        .environmentObject(FoodItem(name:"", carbs: 0, index: 0, ounceOrServing: "", rounded:""))
        .preferredColorScheme(.dark)
        
    }
}
