//
//  ContentView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    let lastActionDateKey = "lastActionDate"
    @State private var showSummary = false
    @State private var isMonday = false
    @State private var newPointsGoalString = ""
    @Environment(\.dismiss) var dismiss
    @State private var pressedSaveButton = false
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "takeoutbag.and.cup.and.straw")
                }
            FoodListView()
                .tabItem {
                    Label("Food List", systemImage: "list.bullet.clipboard")
                }
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "circle.circle")
                }
        }
        .onAppear {
            performActionIfNeeded()
        }
        .sheet(isPresented: $showSummary, onDismiss: {
            if !pressedSaveButton {
                newPointsGoalString = ""
            } else {
                pressedSaveButton = false
            }
        }) {
            NavigationStack {
                Form {
                    Text("You achieved \(Int(Double(ingredientManager.totalPoints) / Double(ingredientManager.pointsGoal) * 100))% of your goal! Congratulations!")
                    TextField("New Goal", text: $newPointsGoalString)
                        .keyboardType(.numberPad)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", role: .destructive) {
                            newPointsGoalString = ""
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            ingredientManager.pointsGoal = Int(newPointsGoalString) ?? 0
                            newPointsGoalString = ""
                            dismiss()
                        }
                    }
                }
            }
        }
    }
    func performActionIfNeeded() {
        let calendar = Calendar.current
        let now = Date()

        // Check if today is Monday
        if calendar.component(.weekday, from: now) == 2 && !isMonday {
            isMonday = true
            showSummary = true
            print("Action performed on Monday!")

            // Update UserDefaults with the current date
            UserDefaults.standard.set(now, forKey: lastActionDateKey)
        }
        if calendar.component(.weekday, from: now) != 2 {
            isMonday = false
            print("can show sheet again")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(IngredientManager())
    }
}
