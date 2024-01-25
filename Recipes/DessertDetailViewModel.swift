//
//  DessertDetailViewModel.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/21/24.
//

import Foundation

class DessertDetailViewModel {
    func getRecipe(id: String) async -> Recipe {
        do {
            let recipeResponse = try await Networking().getRecipe(id: id)?.meals[0]
            guard let instructionArray = recipeResponse?.strInstructions?.replacingOccurrences(of: "\r\n\r\n", with: "\r\n").components(separatedBy: ("\r\n")) else {
                return Recipe(instructions: [Instructions(instruction: NetworkingError.invalidRecipeData.errorMessage, id: UUID())], ingredients: [Ingredients]())
            }
            var instructions = [Instructions]()
            var ingredients = [Ingredients]()
            instructionArray.forEach { instruction in
                instructions.append(Instructions(instruction: instruction, id: UUID()))
            }
            recipeResponse?.ingredients?.forEach({ ingredient in
                ingredients.append(ingredient)
            })
            return Recipe(instructions: instructions, ingredients: ingredients)
        } catch NetworkingError.invalidEndpoint {
            return Recipe(instructions: [Instructions(instruction: NetworkingError.invalidEndpoint.errorMessage, id: UUID())], ingredients: [Ingredients]())
        } catch NetworkingError.invalidRecipeResponse {
            return Recipe(instructions: [Instructions(instruction: NetworkingError.invalidRecipeResponse.errorMessage, id: UUID())], ingredients: [Ingredients]())
        } catch NetworkingError.invalidRecipeData {
            return Recipe(instructions: [Instructions(instruction: NetworkingError.invalidRecipeData.errorMessage, id: UUID())], ingredients: [Ingredients]())
        } catch {
            return Recipe(instructions: [Instructions(instruction: NetworkingError.unkownServiceError.errorMessage, id: UUID())], ingredients: [Ingredients]())
        }
    }
}
