//
//  Desserts.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/20/24.
//

import Foundation

struct Desserts: Decodable {
    var meals: [Meals]
}

struct Meals: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strMealThumb: String?
    let strInstructions: String?
    var ingredients: [Ingredients]?
}

struct FilteredMeals: Identifiable {
    let id: String
    let strMeal: String
    let strMealThumb: String
}

struct Recipe {
    let id = UUID()
    var instructions: [Instructions]
    var ingredients: [Ingredients]
}

struct Instructions: Identifiable {
    let instruction: String
    let id: UUID
}

struct Ingredients: Identifiable, Decodable {
    let id: UUID
    let ingredientName: String
    let measuremeant: String
}
