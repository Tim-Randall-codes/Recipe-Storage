//
//  ContentView.swift
//  Recipe Storage
//
//  Created by Tim Randall on 11/11/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var name: Name
    @StateObject var page: PageSelector
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true )])var items: FetchedResults<Recipe>
    var body: some View {
        NavigationView {
            ZStack{
                Background()
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink(destination: MotherView(page: page, name: name)){
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.black)
                                .padding()
                        }
                    }
                    List { ForEach(items, id: \.self) { item in
                        NavigationLink(destination: RecipeView()){
                            Text(item.name ?? "unknown")
                        }
                    }
                        
                    }.navigationTitle("Recipe Storage")
                }
            }
        }
    }
}

struct RecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true )])var items: FetchedResults<Recipe>
    var body: some View {
        Text("hello world")
    }
}

struct MotherView: View {
    @ObservedObject var page: PageSelector
    @ObservedObject var name: Name
    var body: some View {
        if page.num == 0 {
            AddNameView(page: page, name: name)
        }
        else {
            AddRecipeView(page: page, name: name)
        }
    }
}

struct AddNameView: View {
    @StateObject var page: PageSelector
    @StateObject var name: Name
    var body: some View {
        ZStack{
            Background()
        VStack{
        Text("Please enter the name of your recipe:")
        TextField("enter name here", text: $name.word)
        Button(action:{
            page.num = 1
        }, label: {
            ButtonWidget(words: "Add name")
        })
        }
        }
    }
}

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var page: PageSelector
    @ObservedObject var name: Name
    @State var ingCounter: Int = 0
    @State var stepCounter: Int = 0
    @State var step1: String = ""
    @State var ing1: String = ""
    var body: some View {
        ScrollView{
            ZStack{
                Background()
                VStack{
                    Text("\(name.word):").padding()
                    HStack{
                        TextField("Add step here", text: $step1)
                    }
                    Text(step1)
                }
            }
        }
    }
    func addData () {
        
    }
}

struct Background: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, .green]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    }
}

struct ButtonWidget: View {
    var words: String
    var body: some View {
        Text(words)
            .padding()
            .foregroundColor(.black)
            .background(Color.green)
            .font(.system(size: 18, weight: .bold))
            .cornerRadius(30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddNameView(page: PageSelector(), name: Name())
    }
}
