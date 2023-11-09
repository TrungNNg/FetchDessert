//
//  MealMainView.swift
//  Dessert
//
//  Created by Trung Nguyen on 11/9/23.
//
// The start screen when the app launch

import SwiftUI

struct MealMainView: View {
    @ObservedObject var dessertData: DessertModel
    @State private var isLoading = true
    @State private var loadingFailed = false
    
    @State private var sortOption = DessertModel.SortOption.alphabetically
    @State private var darkMode = false
    
    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView()
            } else if loadingFailed {
                FailedView()
            } else {
                List {
                    Section {
                        SortPicker
                    }
                    Section {
                        DessertList
                    } header: {
                        Text("Dessert list")
                    }
                }
                .animation(.default, value: dessertData.mealsThumpNails)
                .navigationTitle("Fetch Dessert")
                .navigationBarTitleDisplayMode(.inline)
                .preferredColorScheme(darkMode ? .dark : .light)
                .toolbar {
                    Button(action: {
                        darkMode.toggle()
                    }) {
                        Label("", systemImage: darkMode ? "moon.fill" : "moon")
                            .font(.headline)
                            .padding()
                    }
                }
            }
        }
        .task {
            do {
                try await dessertData.fetchMealThumbNails()
                dessertData.changeSortOption(option: .alphabetically)
            } catch let error {
                // we can handle different type of error here
                print("fetch meal thumbnails error: \(error)")
                loadingFailed = true
            }
            isLoading = false
        }
    }
    
    var DessertList: some View {
        ForEach(dessertData.mealsThumpNails, id: \.self) { thumb in
            NavigationLink {
                MealDetailView(mealId: thumb.idMeal, model: dessertData)
            } label: {
                LoadAsyncImage(url: thumb.strMealThumb)
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                VStack(alignment: .leading) {
                    Text(thumb.strMeal)
                        .font(.headline)
                    Text("id:\(thumb.idMeal)")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    var SortPicker: some View {
        Picker(selection: $sortOption, content: {
            ForEach(DessertModel.SortOption.allCases) { option in
                Text(option.rawValue)
            }
        }) {
            Text("Sort option")
        }
        .onChange(of: sortOption) { newOption in
            dessertData.changeSortOption(option: newOption)
        }
    }
    
}

struct MealMainView_Previews: PreviewProvider {
    static var previews: some View {
        MealMainView(dessertData: DessertModel())
    }
}
