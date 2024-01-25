//
//  NetworkingError.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/20/24.
//

enum NetworkingError: Error {
    case invalidEndpoint
    case invalidDessertResponse
    case invalidRecipeResponse
    case invalidDessertData
    case invalidRecipeData
    case unkownServiceError
    
    var errorMessage: String {
        switch self {
        case .invalidEndpoint:
            return "invalid url"
        case .invalidDessertResponse:
            return "unable to reach dessert service"
        case .invalidRecipeResponse:
            return "unable to reach recipe service"
        case .invalidDessertData:
            return "invalid dessert data"
        case .invalidRecipeData:
            return "invalid recipe data"
        case .unkownServiceError:
            return "unkown error has occured"
        }
    }
}
