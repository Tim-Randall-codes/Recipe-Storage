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
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink(destination: MotherView(page: page, name: name).onAppear {page.num = 0}){
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.black)
                                .padding(10)
                        }
                    }
                    List { ForEach(items, id: \.self) { item in
                        NavigationLink(destination: RecipeView(name: item.name ?? "unknown", ing1: item.ing1 ?? "unknown", ing2: item.ing2 ?? "unknown", ing3: item.ing3 ?? "unknown", ing4: item.ing4 ?? "unknown", ing5: item.ing5 ?? "unknown", ing6: item.ing6 ?? "unknown", ing7: item.ing7 ?? "unknown", ing8: item.ing8 ?? "unknown", ing9: item.ing9 ?? "unknown", ing10: item.ing10 ?? "unknown", step1: item.step1 ?? "unknown", step2: item.step2 ?? "unknown", step3: item.step3 ?? "unknown", step4: item.step4 ?? "unknown", step5: item.step5 ?? "unknown", step6: item.step6 ?? "unknown", step7: item.step7 ?? "unknown", step8: item.step8 ?? "unknown", step9: item.step9 ?? "unknown", step10: item.step10 ?? "unknown")){
                            Text(item.name ?? "unknown")}
                        }.onDelete(perform: removeItem)
                    }.navigationTitle("Recipe Storage")
                }
        }
    }
    func removeItem(at offsets: IndexSet) {
        for index in offsets {
            let itm = items[index]
            PersistenceController.shared.delete(itm)
            }
        } 
}

struct RecipeView: View {
    let name: String
    let ing1: String
    let ing2: String
    let ing3: String
    let ing4: String
    let ing5: String
    let ing6: String
    let ing7: String
    let ing8: String
    let ing9: String
    let ing10: String
    let step1: String
    let step2: String
    let step3: String
    let step4: String
    let step5: String
    let step6: String
    let step7: String
    let step8: String
    let step9: String
    let step10: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
            ZStack{
                if colorScheme == .dark {
                    Background(topColour: .black, bottomColour: Color("myGreen"))}
                else{
                    Background(topColour: .white, bottomColour: Color("myGreen"))}
                ScrollView{
                VStack{
                    Spacer()
                    SuperTitle(words: name)
                    Title(words: "Ingredients:")
                    Group{
                    if ing1 != "" {
                        Text(ing1)
                    }
                    if ing2 != "" {
                        Text(ing2)
                    }
                    if ing3 != "" {
                        Text(ing3)
                    }
                    if ing4 != "" {
                        Text(ing4)
                    }
                    if ing5 != "" {
                        Text(ing5)
                    }
                    if ing6 != "" {
                        Text(ing6)
                    }
                    if ing7 != "" {
                        Text(ing7)
                    }
                    if ing8 != "" {
                        Text(ing8)
                    }
                    if ing9 != "" {
                        Text(ing9)
                    }
                    if ing10 != "" {
                        Text(ing10)
                    }
                    }
                    Title(words: "Method:")
                    Group{
                        if step1 != "" {
                            Text(step1)
                        }
                        if step2 != "" {
                            Text(step2)
                        }
                        if step3 != "" {
                            Text(step3)
                        }
                        if step4 != "" {
                            Text(step4)
                        }
                        if step5 != "" {
                            Text(step5)
                        }
                        if step6 != "" {
                            Text(step6)
                        }
                        if step7 != "" {
                            Text(step7)
                        }
                        if step8 != "" {
                            Text(step8)
                        }
                        if step9 != "" {
                            Text(step9)
                        }
                        if step10 != "" {
                            Text(step10)
                        }
                    }
                    
                }
            }
        }
    }
}

struct MotherView: View {
    @StateObject var page: PageSelector
    @StateObject var name: Name
    var body: some View {
        if page.num == 0 {
            AddNameView(page: page, name: name).onAppear{name.word = ""}
        }
        else if page.num == 1 {
            AddRecipeView(page: page, name: name)
        }
        else if page.num == 2 {
            RecipeSaved(page: page)
        }
    }
}

struct RecipeSaved: View {
    @StateObject var page: PageSelector
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        ZStack{
            if colorScheme == .dark {
                Background(topColour: .black, bottomColour: Color("myGreen"))}
            else{
                Background(topColour: .white, bottomColour: Color("myGreen"))}
            Title(words: "Recipe Saved!")
        }
    }
}

struct AddNameView: View {
    @StateObject var page: PageSelector
    @StateObject var name: Name
    @State var displayMessage: String = ""
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        ZStack{
            if colorScheme == .dark {
                Background(topColour: .black, bottomColour: Color("myGreen"))}
            else{
                Background(topColour: .white, bottomColour: Color("myGreen"))}
        VStack{
            Title(words: "Please enter the name of your recipe:")
            Text(displayMessage).padding()
            TextField("enter name here", text: $name.word).padding()
        Button(action:{
            if name.word == "" {
                displayMessage = "Please enter a name"
            }
            else {
                page.num = 1
            }
        }, label: {
            ButtonWidget(words: "Add name")
        })
        }
        }
    }
}

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var page: PageSelector
    @ObservedObject var name: Name
    @State var ingCounter: Int = 0
    @State var stepCounter: Int = 0
    @State var step1: String = ""
    @State var ing1: String = ""
    @State var displayText: String = ""
    @State var data = RecipeUnstored()
    var body: some View {
        ZStack{
            if colorScheme == .dark {
                Background(topColour: .black, bottomColour: Color("myGreen"))}
            else{
                Background(topColour: .white, bottomColour: Color("myGreen"))}
            ScrollView{
                VStack{
                    Spacer()
                    Group{
                        SuperTitle(words: "\(name.word):")
                    Text(displayText).padding()
                    }
                    HStack{
                        TextField("Add ingredient here", text: $ing1).padding()
                        Button(action:{
                            if ing1 == "" {
                                displayText = "Please type in an ingredient"
                            }
                            else {
                                addIngToData()
                            }
                        }, label:{
                            ButtonWidget(words: "Add")
                        })
                    }
                    HStack{
                        TextField("Add step here", text: $step1).padding()
                        Button(action:{
                            if step1 == "" {
                                displayText = "Please type in a step"
                            }
                            else{
                                addStepToData()
                            }
                        }, label:{
                            ButtonWidget(words: "Add")
                        })
                    }
                    Title(words: "Ingredients:")
                    DisplayIngData(words: data)
                    Title(words: "Method:")
                    DisplayStepData(words: data)
                    Button(action:{
                        saveData()
                        page.num = 2
                    }, label:{
                        ButtonWidget(words: "Save Recipe")
                    })
                    Spacer()
                }
            }
        }
    }
    func addStepToData () {
        if stepCounter == 0 {
            data.step1 = step1
            displayText = ""
        }
        else if stepCounter == 1 {
            data.step2 = step1
            displayText = ""
        }
        else if stepCounter == 2 {
            data.step3 = step1
        }
        else if stepCounter == 3 {
            data.step4 = step1
            displayText = ""
        }
        else if stepCounter == 4 {
            data.step5 = step1
            displayText = ""
        }
        else if stepCounter == 5 {
            data.step6 = step1
            displayText = ""
        }
        else if stepCounter == 6 {
            data.step7 = step1
            displayText = ""
        }
        else if stepCounter == 7 {
            data.step8 = step1
            displayText = ""
        }
        else if stepCounter == 8 {
            data.step9 = step1
            displayText = ""
        }
        else if stepCounter == 9 {
            data.step10 = step1
            displayText = ""
        }
        else {
            displayText = "Sorry you can only enter 10 steps"
        }
        stepCounter += 1
        step1 = ""
    }
    func addIngToData () {
        if ingCounter == 0 {
            data.ing1 = ing1
            displayText = ""
        }
        else if ingCounter == 1 {
            data.ing2 = ing1
            displayText = ""
        }
        else if ingCounter == 2 {
            data.ing3 = ing1
            displayText = ""
        }
        else if ingCounter == 3 {
            data.ing4 = ing1
            displayText = ""
        }
        else if ingCounter == 4 {
            data.ing5 = ing1
            displayText = ""
        }
        else if ingCounter == 5 {
            data.ing6 = ing1
            displayText = ""
        }
        else if ingCounter == 6 {
            data.ing7 = ing1
            displayText = ""
        }
        else if ingCounter == 7 {
            data.ing8 = ing1
            displayText = ""
        }
        else if ingCounter == 8 {
            data.ing9 = ing1
            displayText = ""
        }
        else if ingCounter == 9 {
            data.ing10 = ing1
            displayText = ""
        }
        else {
            displayText = "Sorry you can only enter 10 ingredients"
        }
        ingCounter += 1
        ing1 = ""
    }
    func saveData () {
        let savedData = Recipe(context: managedObjectContext)
        savedData.name = name.word
        savedData.ing1 = data.ing1
        savedData.ing2 = data.ing2
        savedData.ing3 = data.ing3
        savedData.ing4 = data.ing4
        savedData.ing5 = data.ing5
        savedData.ing6 = data.ing6
        savedData.ing7 = data.ing7
        savedData.ing8 = data.ing8
        savedData.ing9 = data.ing9
        savedData.ing10 = data.ing10
        savedData.step1 = data.step1
        savedData.step2 = data.step2
        savedData.step3 = data.step3
        savedData.step4 = data.step4
        savedData.step5 = data.step5
        savedData.step6 = data.step6
        savedData.step7 = data.step7
        savedData.step8 = data.step8
        savedData.step9 = data.step9
        savedData.step10 = data.step10
        PersistenceController.shared.save()
    }
}

struct DisplayIngData: View {
    var words: RecipeUnstored
    var body: some View {
        if words.ing1 != "" {
            Text(words.ing1)
        }
        if words.ing2 != "" {
            Text(words.ing2)
        }
        if words.ing3 != "" {
            Text(words.ing3)
        }
        if words.ing4 != "" {
            Text(words.ing4)
        }
        if words.ing5 != "" {
            Text(words.ing5)
        }
        if words.ing6 != "" {
            Text(words.ing6)
        }
        if words.ing7 != "" {
            Text(words.ing7)
        }
        if words.ing8 != "" {
            Text(words.ing8)
        }
        if words.ing9 != "" {
            Text(words.ing9)
        }
        if words.ing10 != "" {
            Text(words.ing10)
        }
    }
}

struct DisplayStepData: View {
    var words: RecipeUnstored
    var body: some View {
        if words.step1 != "" {
            Text(words.step1)
        }
        if words.step2 != "" {
            Text(words.step2)
        }
        if words.step3 != "" {
            Text(words.step3)
        }
        if words.step4 != "" {
            Text(words.step4)
        }
        if words.step5 != "" {
            Text(words.step5)
        }
        if words.step6 != "" {
            Text(words.step6)
        }
        if words.step7 != "" {
            Text(words.step7)
        }
        if words.step8 != "" {
            Text(words.step8)
        }
        if words.step9 != "" {
            Text(words.step9)
        }
        if words.step10 != "" {
            Text(words.step10)
        }
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
    var topColour: Color
    var bottomColour: Color
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColour, bottomColour]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    }
}

struct Title: View {
    var words: String
    var body: some View {
        Text(words)
            .padding()
            .font(.system(size:18, weight: .bold))
    }
}

struct SuperTitle: View {
    var words: String
    var body: some View {
        Text(words)
            .padding()
            .font(.system(size:22, weight: .bold))
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
        RecipeSaved(page: PageSelector()).preferredColorScheme(.dark)
    }
}
     
