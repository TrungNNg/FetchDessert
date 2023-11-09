//
//  Model.swift
//  Dessert
//
//  Created by Trung Nguyen on 11/9/23.
//
// MealThumbnailDecode and MealDetailDecode are used for decoding JSON, which will then
// convert into MealThumbnail and MealDetail for easier use in View. Null values in JSON will
// be convert to empty string ("") by default.

import Foundation

struct MealThumbnail: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    init(mealDecode: MealThumbnailDecode) {
        self.idMeal = mealDecode.idMeal ?? ""
        self.strMeal = mealDecode.strMeal ?? ""
        self.strMealThumb = mealDecode.strMealThumb ?? ""
    }
}

struct MealThumbnailDecode: Decodable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}

struct MealDetail {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String
    let strCategory: String
    let strArea: String
    let strInstructions : String
    let strMealThumb: String
    let strTags: [String]
    let strYoutube: String
    
    let strIngredients: [String]
    let strMeasures: [String]
    
    let strSource: String
    let strImageSource: String
    let strCreativeCommonsConfirmed: String
    let dataModified: String
    
    init(mealDecode: MealDetailDecode) {
        self.idMeal = mealDecode.idMeal ?? ""
        self.strMeal = mealDecode.strMeal ?? ""
        self.strDrinkAlternate = mealDecode.strDrinkAlternate ?? ""
        self.strCategory = mealDecode.strCategory ?? ""
        self.strArea = mealDecode.strArea ?? ""
        self.strInstructions = mealDecode.strInstructions ?? ""
        self.strMealThumb = mealDecode.strMealThumb ?? ""
        self.strTags = mealDecode.strTags?.components(separatedBy: ",") ?? []
        self.strYoutube = mealDecode.strYoutube ?? ""
        
        // Ingredient and its measurement will be match using index from 0 -> 19
        // perhaps a better way is to build a map with [Ingredient : Measure]
        var temp: [String] = []
        temp.append(mealDecode.strIngredient1 ?? "")
        temp.append(mealDecode.strIngredient2 ?? "")
        temp.append(mealDecode.strIngredient3 ?? "")
        temp.append(mealDecode.strIngredient4 ?? "")
        temp.append(mealDecode.strIngredient5 ?? "")
        temp.append(mealDecode.strIngredient6 ?? "")
        temp.append(mealDecode.strIngredient7 ?? "")
        temp.append(mealDecode.strIngredient8 ?? "")
        temp.append(mealDecode.strIngredient9 ?? "")
        temp.append(mealDecode.strIngredient10 ?? "")
        temp.append(mealDecode.strIngredient11 ?? "")
        temp.append(mealDecode.strIngredient12 ?? "")
        temp.append(mealDecode.strIngredient13 ?? "")
        temp.append(mealDecode.strIngredient14 ?? "")
        temp.append(mealDecode.strIngredient15 ?? "")
        temp.append(mealDecode.strIngredient16 ?? "")
        temp.append(mealDecode.strIngredient17 ?? "")
        temp.append(mealDecode.strIngredient18 ?? "")
        temp.append(mealDecode.strIngredient19 ?? "")
        temp.append(mealDecode.strIngredient20 ?? "")
        self.strIngredients = temp
        temp.removeAll()
        temp.append(mealDecode.strMeasure1 ?? "")
        temp.append(mealDecode.strMeasure2 ?? "")
        temp.append(mealDecode.strMeasure3 ?? "")
        temp.append(mealDecode.strMeasure4 ?? "")
        temp.append(mealDecode.strMeasure5 ?? "")
        temp.append(mealDecode.strMeasure6 ?? "")
        temp.append(mealDecode.strMeasure7 ?? "")
        temp.append(mealDecode.strMeasure8 ?? "")
        temp.append(mealDecode.strMeasure9 ?? "")
        temp.append(mealDecode.strMeasure10 ?? "")
        temp.append(mealDecode.strMeasure11 ?? "")
        temp.append(mealDecode.strMeasure12 ?? "")
        temp.append(mealDecode.strMeasure13 ?? "")
        temp.append(mealDecode.strMeasure14 ?? "")
        temp.append(mealDecode.strMeasure15 ?? "")
        temp.append(mealDecode.strMeasure16 ?? "")
        temp.append(mealDecode.strMeasure17 ?? "")
        temp.append(mealDecode.strMeasure18 ?? "")
        temp.append(mealDecode.strMeasure19 ?? "")
        temp.append(mealDecode.strMeasure20 ?? "")
        self.strMeasures = temp
        
        self.strSource = mealDecode.strSource ?? ""
        self.strImageSource = mealDecode.strImageSource ?? ""
        self.strCreativeCommonsConfirmed = mealDecode.strCreativeCommonsConfirmed ?? ""
        self.dataModified = mealDecode.dataModified ?? ""
    }
}

struct MealDetailDecode: Codable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions : String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dataModified: String?
}
