//
//  ProgressView.swift
//  CKJY V2
//
//  Created by RGS on 22/11/23.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var ingredientManager: IngredientManager
    @State private var pointsGoal = 10
    let lastActionDateKey = "lastActionDate"
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke( // 1
                        Color.blue.opacity(0.5),
                        lineWidth: 30
                    )
                Circle() // 2
                    .trim(from: 0, to: CGFloat(ingredientManager.totalPoints) / CGFloat(pointsGoal)) // 1
                    .stroke(Color.blue,
                            style: StrokeStyle(
                                lineWidth: 30,
                                lineCap: .round
                            )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: CGFloat(ingredientManager.totalPoints) / CGFloat(pointsGoal))
            }
                .frame(width: 200, height: 200)
            HStack {
                Stepper("\(ingredientManager.totalPoints)", value: $ingredientManager.totalPoints)
                    .padding(20)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                Stepper("\(pointsGoal)", value: $pointsGoal)
                    .padding(20)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }
            .padding()
        }
        .onAppear {
            performActionIfNeeded()
        }
        
    }
    
    func performActionIfNeeded() {
        let calendar = Calendar.current
        let now = Date()

        // Check if today is Monday
        if calendar.component(.weekday, from: now) == 2 {
            // Perform your action here
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


