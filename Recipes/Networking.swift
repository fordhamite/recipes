//
//  Networking.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/20/24.
//

import Foundation

class Networking {
    func getDesserts() async throws -> Desserts? {
        guard let endpoint = URL(string:"https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw NetworkingError.invalidEndpoint
        }
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.invalidDessertResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Desserts.self, from: data)
        } catch {
            throw NetworkingError.invalidDessertData
        }
    }
    
    func getRecipe(id: String) async throws -> Desserts? {
        guard let endpoint = URL(string:"https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw NetworkingError.invalidEndpoint
        }
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.invalidRecipeResponse
        }
        do {
            var decoded = try JSONDecoder().decode(Desserts.self, from: data)
            let topLevel = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            var ingredientsWithMeasuremeants = [Ingredients]()
            if let dictionary = topLevel?["meals"] as? [Any] {
                if let nestedDictionary = dictionary[0] as? [String: Any] {
                    for ingredient in 1...20 {
                        if let nestedIngredient = nestedDictionary["strIngredient\(ingredient)"] {
                            if nestedIngredient as? String != "" && nestedIngredient as? String != nil {
                                if let nestedMeasuremeant = nestedDictionary["strMeasure\(ingredient)"] {
                                    if nestedMeasuremeant as? String != "" && nestedMeasuremeant as? String != nil {
                                        ingredientsWithMeasuremeants.append(Ingredients(id: UUID(), ingredientName: nestedIngredient as? String ?? "Invalid ingredient", measuremeant: nestedMeasuremeant as? String ?? "Invalid measuremeant"))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            decoded.meals[0].ingredients = ingredientsWithMeasuremeants
            return decoded
        } catch {
            throw NetworkingError.invalidDessertData
        }
    }
}
