# Recipes

SwiftUI Application written using MVVM design pattern that displays desserts and their preparation ingredients/instructions.

## Functionality

Application loads an initial view and creates a GET request to a public repository which fetches desserts and alphabetizes them in a list.

List rows navigate to a new SwiftUI view that makes another call to the api using the dessert in question's ID.

JSON from requests is parsed using Decodable protocol, recipe instructions are separated by line breaks in the response and filtered of nulls and empty values.

Ingredients and their measuremeants are iterated through and parsed using manual JSON serialization due to ingredient information being returned in separate dictionaries.

The application includes custom error handling.