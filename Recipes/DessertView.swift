//
//  ContentView.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/19/24.
//

import SwiftUI

struct DessertView: View {
    
    @State private var meals = [FilteredMeals]()
    @State private var showSpinner = true
    
    var body: some View {
        NavigationView {
            if showSpinner {
                ProgressView()
            } else {
                List(meals, id: \.id) { meal in
                    NavigationLink(destination: DessertDetailView(id: meal.id, name: meal.strMeal)) {
                        HStack {
                            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 70, height: 70)
                            .background(Color.gray)
                            .scaledToFit()
                            .cornerRadius(4.0)
                            
                            Text(meal.strMeal)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                        }
                    }
                    .navigationTitle("Yummy Desserts")
                }
            }
        }
        .task {
            await meals = DessertViewModel().getDesserts()
            showSpinner = false
        }
    }
}

#Preview {
    DessertView()
}
