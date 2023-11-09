//
//  DessertApp.swift
//  Dessert
//
//  Created by Trung Nguyen on 11/7/23.
//

import SwiftUI

@main
struct DessertApp: App {
    @StateObject var model = DessertModel() // ViewModel
    var body: some Scene {
        WindowGroup {
            MealMainView(dessertData: model)
        }
    }
}
