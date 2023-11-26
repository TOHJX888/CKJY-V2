//
//  ProgressView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var newPointsGoal = 10
    @State private var showSummary = false
    let lastActionDateKey = "lastActionDate"
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("   Current points: \(ingredientManager.totalPoints)")
                        .font(.title2)
                    Image(systemName: "leaf.fill")
                    Spacer()
                }
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
                //            HStack {
                //                Stepper("\(ingredientManager.totalPoints)", value: $ingredientManager.totalPoints)
                //                    .padding(20)
                //                    .background(.blue)
                //                    .foregroundColor(.white)
                //                    .cornerRadius(30)
                //            Stepper("\(ingredientManager.pointsGoal)", value: $ingredientManager.pointsGoal)
                //                    .padding(20)
                //                    .background(.blue)
                //                    .foregroundColor(.white)
                //                    .cornerRadius(30)
                Spacer()
                HStack {
                    Text("Goal: \(ingredientManager.pointsGoal)")
                        .font(.title)
                    Image(systemName: "leaf.fill")
                }
                
                ////            }
                .padding()
                Spacer()
            }
            .navigationTitle("My Progress View")
            .onAppear {
                performActionIfNeeded()
            }
            .sheet(isPresented: $showSummary, onDismiss: {
                ingredientManager.pointsGoal = newPointsGoal
            }) {
                Form {
                    Text("You achieved \(Int(Double(ingredientManager.totalPoints) / Double(ingredientManager.pointsGoal) * 100))% of your goal! Congratulations!Set your goal for the new week!")
                    //                Button("inc") {
                    //                    ingredientManager.totalPoints += 1
                    //                }
                    //                Button("dec") {
                    //                    ingredientManager.totalPoints -= 1
                    //                }
                    Stepper("New Goal: \(newPointsGoal)", value: $newPointsGoal, step: 5)
                }
            }
        }
    }
        
    
    func performActionIfNeeded() {
        let calendar = Calendar.current
        let now = Date()

        // Check if today is Monday
        if calendar.component(.weekday, from: now) == 6 {
            showSummary = true
            print("Action performed on Monday!")

            // Update UserDefaults with the current date
            UserDefaults.standard.set(now, forKey: lastActionDateKey)
        }
    }
    
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(IngredientManager())
    }
}


