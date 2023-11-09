//
//  MealDetailView.swift
//  Dessert
//
//  Created by Trung Nguyen on 11/9/23.
//

import SwiftUI

struct MealDetailView: View {
    @State private var meal: MealDetail? = nil
    @State private var isLoading = true
    @State private var loadingFailed = false
    let mealId: String
    let model: DessertModel
    
    @State private var favorite = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if loadingFailed {
                FailedView()
            } else if let meal = meal {
                ScrollView {
                    LoadAsyncImage(url: meal.strMealThumb)
                        .frame(minHeight: 300)
                    VStack(alignment: .leading) {
                        MealTitle
                        Divider()
                        Text("Ingredients:")
                            .font(.headline)
                        IngredientAndMeasureView(ingredients: meal.strIngredients, measurements: meal.strMeasures)
                        Divider()
                        Text("Instructions:")
                            .font(.headline)
                            .padding(.top)
                        Text(meal.strInstructions != "" ? meal.strInstructions : "Instruction unavailable")
                            .padding(.top,1)
                            .font(.body)
                    }
                    .padding()
                }
            }
        }
        .task {
            do {
                meal = try await model.fetchMealWithID(id: mealId)
            } catch let error {
                loadingFailed = true
                print("fetch meal detail using id error: \(error)")
            }
            isLoading = false
        }
    }
    
    var MealTitle: some View {
        HStack {
            Text(meal?.strMeal ?? "Meal name unavailable")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Spacer()
            Button(action: {
                favorite.toggle()
            }) {
                Label("", systemImage: favorite ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    struct IngredientAndMeasureView: View {
        let ingredients: [String]
        let measurements: [String]
        var body: some View {
            if !ingredients.isEmpty {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100)),
                    GridItem(.flexible(minimum: 100))
                ], spacing: 14) {
                    ForEach(0..<ingredients.count, id: \.self) { index in
                        if ingredients[index] != "" && measurements[index] != "" {
                            Text(ingredients[index])
                            Text(measurements[index])
                        }
                    }
                }
            } else {
                Text("Ingredient unavaialbe")
            }
        }
    }
    
}

/*
struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}*/
