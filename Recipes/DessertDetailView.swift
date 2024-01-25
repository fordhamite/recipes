//
//  DessertDetailView.swift
//  Recipes
//
//  Created by Bibire, Andrew on 1/21/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    @State private var showSpinner = true
    @State private var recipe = Recipe(instructions: [Instructions](), ingredients: [Ingredients(id: UUID(), ingredientName: "", measuremeant: "")])
    
    var id: String
    var name: String
    
    var body: some View {
        VStack{
            if showSpinner {
                ProgressView()
            } else {
                VStack {
                    List {
                        Text(name)
                            .bold()
                            .padding(0)
                            .font(.title)
                        Section() {
                            Text("Ingredients")
                                .fontWeight(.semibold)
                                .padding(0)
                        }
                        ForEach(recipe.ingredients, id: \.id) { ingredient in
                            HStack {
                                Text(ingredient.ingredientName+",")
                                Text(ingredient.measuremeant)
                            }
                        }
                        Section() {
                            Text("Prep instructions")
                                .fontWeight(.semibold)
                                .padding(0)
                        }
                        ForEach(recipe.instructions, id: \.id) { instruction in
                            if instruction.instruction != "" {
                                Text(instruction.instruction)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listSectionSpacing(0)
                }
            }
        }
        .padding(.top, -8)
        .task {
            await recipe = DessertDetailViewModel().getRecipe(id: id)
            showSpinner = false
        }
    }
}
