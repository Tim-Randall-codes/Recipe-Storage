//
//  ContentView.swift
//  Recipe Storage
//
//  Created by Tim Randall on 11/11/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true )],
        predicate: NSPredicate(format: "order == @%", 0))var items: FetchedResults<Recipe>
    var body: some View {
        NavigationView {
            ZStack{
                Background()
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink(destination: AddRecipeView()){
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.black)
                                .padding()
                        }
                    }
                    Spacer()
                }
            }
        }//.navigationTitle("Recipe Storage")
    }
}

struct RecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        Text("hello world")
    }
}

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        Text("hello world")
    }
}

struct Background: View {
    var body: some View {
        Color(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
