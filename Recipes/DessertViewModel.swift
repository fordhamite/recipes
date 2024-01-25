//
//  DessertViewModel.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/21/24.
//

class DessertViewModel {
    func getDesserts() async -> [FilteredMeals] {
        do {
            var filteredMeals = [FilteredMeals]()
            let desserts = try await Networking().getDesserts()
            guard let dessertMeals = desserts?.meals else {
                throw NetworkingError.invalidDessertData
            }
            for dessertMeal in dessertMeals {
                guard let strMeal = dessertMeal.strMeal else { return filteredMeals }
                guard strMeal != ""  else { return filteredMeals }
                guard let strMealThumb = dessertMeal.strMealThumb else { return filteredMeals }
                guard strMealThumb != "" else { return filteredMeals }
                guard let dessertId = dessertMeal.idMeal else { return filteredMeals}
                guard dessertId != "" else { return filteredMeals }
                filteredMeals.append(FilteredMeals(id: dessertId,
                                                   strMeal: strMeal,
                                                   strMealThumb: strMealThumb))
            }
            return filteredMeals.sorted {
                $0.strMeal < $1.strMeal
            }
        } catch NetworkingError.invalidEndpoint {
            return [FilteredMeals(id: "", strMeal: NetworkingError.invalidEndpoint.errorMessage, strMealThumb: "")]
        } catch NetworkingError.invalidDessertResponse {
            return [FilteredMeals(id: "", strMeal: NetworkingError.invalidDessertResponse.errorMessage, strMealThumb: "")]
        } catch NetworkingError.invalidDessertData {
            return [FilteredMeals(id: "", strMeal: NetworkingError.invalidDessertData.errorMessage, strMealThumb: "")]
        } catch {
            return [FilteredMeals(id: "", strMeal: NetworkingError.unkownServiceError.errorMessage, strMealThumb: "")]
        }
    }
}
