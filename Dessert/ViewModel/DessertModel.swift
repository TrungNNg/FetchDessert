//
//  DessertModel.swift
//  Dessert
//
//  Created by Trung Nguyen on 11/9/23.
//

import Foundation

// This view model will fetch JSON and save the data to mealsThumbNails
class DessertModel: ObservableObject {
    @Published var mealsThumpNails: [MealThumbnail] = []
    
    // Fetch List of dessert
    func fetchMealThumbNails() async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw FetchMealThumbnailsError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([String:[MealThumbnailDecode]].self, from: data)
            if let meals = result["meals"] {
                // updating UI need to be done in main thread
                DispatchQueue.main.async {
                    self.mealsThumpNails = meals.map{ MealThumbnail(mealDecode: $0) }
                }
            }
        } catch let error {
            throw error
        }
    }
    
    enum FetchMealThumbnailsError: Error {
        case invalidURL
    }
    
    // Fetch a dessert's detail using id
    func fetchMealWithID(id: String) async throws -> MealDetail? {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw FetchMealDetailError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([String:[MealDetailDecode]].self, from: data)
            if let meals = result["meals"], meals.count > 0 {
                return MealDetail(mealDecode: meals.first!)
            } else {
                throw FetchMealDetailError.invalidJSON
            }
        } catch let error {
            throw error
        }
    }
    
    enum FetchMealDetailError: Error {
        case invalidURL
        case invalidJSON
    }
    
    // Sort meal thumbnails
    enum SortOption: String, Identifiable, CaseIterable {
        case alphabetically = "alphabettically"
        case id = "id"
        var id: Self { self }
    }
    
    func changeSortOption(option: SortOption) {
        switch option {
        case .alphabetically:
            mealsThumpNails.sort { $0.strMeal < $1.strMeal }
        case .id:
            mealsThumpNails.sort { (obj1, obj2) in
                let id1 = obj1.idMeal
                let id2 = obj2.idMeal
                
                if id1.isEmpty {
                    return false
                } else if id2.isEmpty {
                    return true
                }
                
                if let numericId1 = Int(id1), let numbericId2 = Int(id2) {
                    return numericId1 < numbericId2
                }
                
                return false
            }
        }
    }
    
}
