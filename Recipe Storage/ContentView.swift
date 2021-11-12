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
    @State var displayText: String = ""
    @State var data = RecipeUnstored()
    var body: some View {
        ScrollView{
            ZStack{
                Background()
                VStack{
                    Text("\(name.word):").padding()
                    Text(displayText).padding()
                    HStack{
                        TextField("Add step here", text: $step1)
                        Button(action:{
                            addStepToData()
                        }, label:{
                            ButtonWidget(words: "Add")
                        })
                    }
                    Text(step1)
                }
            }
        }
    }
    func addStepToData () {
        if stepCounter == 0 {
            data.step1 = step1
        }
        else if stepCounter == 1 {
            data.step2 = step1
        }
        else if stepCounter == 2 {
            data.step3 = step1
        }
        else if stepCounter == 3 {
            data.step4 = step1
        }
        else if stepCounter == 4 {
            data.step5 = step1
        }
        else if stepCounter == 5 {
            data.step6 = step1
        }
        else if stepCounter == 6 {
            data.step7 = step1
        }
        else if stepCounter == 7 {
            data.step8 = step1
        }
        else if stepCounter == 8 {
            data.step9 = step1
        }
        else if stepCounter == 9 {
            data.step10 = step1
        }
        else {
            displayText = "Sorry you can only enter 10 steps"
        }
        stepCounter += 1
    }
    func addIngToData () {
        
    }
}

// save the user entries to the data object. Then have a button that saves the data object's data and name to a permanently stored recipe object

struct RecipeUnstored {
    var name: String = ""
    var step1: String = ""
    var step2: String = ""
    var step3: String = ""
    var step4: String = ""
    var step5: String = ""
    var step6: String = ""
    var step7: String = ""
    var step8: String = ""
    var step9: String = ""
    var step10: String = ""
    var ing1: String = ""
    var ing2: String = ""
    var ing3: String = ""
    var ing4: String = ""
    var ing5: String = ""
    var ing6: String = ""
    var ing7: String = ""
    var ing8: String = ""
    var ing9: String = ""
    var ing10: String = ""
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
