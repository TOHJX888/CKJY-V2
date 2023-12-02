//
//  ContentView.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    @EnvironmentObject var recipeManager: RecipeManager
    let lastActionDateKey = "lastActionDate"
    @State private var showSummary = false
    @State private var newPointsGoal = 50
    @Environment(\.dismiss) var dismiss
    @State private var pressedSaveButton = false
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    @State private var showOnboardingSheet = false
    @State private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var selectedDay = "Monday"
    @State private var summaryDayInt = 7
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "takeoutbag.and.cup.and.straw")
                }
            FoodListView()
                .tabItem {
                    Label("Food List", systemImage: "list.clipboard")
                }
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "circle.circle")
                }
        }
        .onAppear {
            if !hasLaunchedBefore {
                showOnboardingSheet = true
                ingredientManager.isSummaryDay = true
            }
            performActionIfNeeded()
        }
        .sheet(isPresented: $showSummary) {
            NavigationStack {
                Form {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke( // 1
                                    Color.blue.opacity(0.5),
                                    lineWidth: 30
                                )
                            Circle() // 2
                                .trim(from: 0, to: CGFloat(ingredientManager.totalPoints) / CGFloat(ingredientManager.pointsGoal)) // 1
                                .stroke(Color.blue,
                                        style: StrokeStyle(
                                            lineWidth: 30,
                                            lineCap: .round
                                        )
                                )
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut, value: CGFloat(ingredientManager.totalPoints) / CGFloat(ingredientManager.pointsGoal))
                            
                        }
                        .frame(width: 200, height: 200)
                        .padding()
                        Spacer()
                    }
                    Section("") {
                        Text("You achieved \(Int(Double(ingredientManager.totalPoints) / Double(ingredientManager.pointsGoal) * 100))% of your goal! Congratulations!")
                        HStack {
                            Text("New Goal")
                            Spacer()
                            Stepper(value: $newPointsGoal, in: 0...99) {
                                HStack {
                                    Spacer()
                                    Text("\(newPointsGoal)")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Summary")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel", role: .destructive) {
                            showSummary = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            ingredientManager.pointsGoal = newPointsGoal
                            showSummary = false
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showOnboardingSheet, onDismiss: {
            hasLaunchedBefore = true
        }) {
            NavigationStack {
                Form {
                    Text("Hello User!")
                        .font(.title)
                    Text("This app uses a self-set goal method to help you on your healthy-eating journey. Before you start, please choose your preferences:")
                    HStack {
                        Text("Starting Goal")
                        Spacer()
                        Stepper(value: $newPointsGoal, in: 0...99) {
                            HStack {
                                Spacer()
                                Text("\(newPointsGoal)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Picker("Goal Reset Day", selection: $selectedDay) {
                        ForEach(days, id:\.self) {
                            Text($0)
                                .tag($0)
                        }
                    }
                    Button("Save") {
                        ingredientManager.pointsGoal = newPointsGoal
                        switch selectedDay {
                        case "Monday":
                            summaryDayInt = 2
                        case "Tuesday":
                            summaryDayInt = 3
                        case "Wednesday":
                            summaryDayInt = 4
                        case "Thursday":
                            summaryDayInt = 5
                        case "Friday":
                            summaryDayInt = 6
                        case "Saturday":
                            summaryDayInt = 7
                        case "Sunday":
                            summaryDayInt = 1
                        default:
                            summaryDayInt = 2
                        }
                        showOnboardingSheet = false
                        hasLaunchedBefore = true
                    }
                }
                .navigationTitle("Goal-Setting")
            }
        }
    }
    func performActionIfNeeded() {
        let calendar = Calendar.current
        let now = Date()

        // Check if today is Monday
        if calendar.component(.weekday, from: now) == summaryDayInt && !ingredientManager.isSummaryDay && hasLaunchedBefore {
            ingredientManager.isSummaryDay = true
            showSummary = true
            print("Action performed on Monday!")

            // Update UserDefaults with the current date
            UserDefaults.standard.set(now, forKey: lastActionDateKey)
        }
        if calendar.component(.weekday, from: now) != summaryDayInt {
            ingredientManager.isSummaryDay = false
            print("can show sheet again")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(IngredientManager())
            .environmentObject(RecipeManager())
    }
}
