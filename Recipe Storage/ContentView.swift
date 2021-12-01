//
//  ContentView.swift
//  Recipe Storage
//
//  Created by Tim Randall on 11/11/21.
//

import SwiftUI

// Create view variables to store the name, ings and steps entered. Then display these
// use a String var and two list vars.

struct BossView: View {
    @StateObject var viewChanger: ViewChanger
    var body: some View {
        if viewChanger.num == 0 {
            ContentView(viewChanger: viewChanger)
        }
        else if viewChanger.num == 1 {
            RecipeView(viewChanger: viewChanger)
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var viewChanger: ViewChanger
    @FetchRequest(
        entity: RName.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RName.words, ascending: true )])var items: FetchedResults<RName>
    var body: some View {
        NavigationView {
                VStack{
                    Text("Recipe Storage")
                    HStack{
                        Spacer()
                        NavigationLink(destination: AddRecipeView(viewChanger: viewChanger)){
                            Text("add")
                            //Image(systemName: "plus")
                                //.resizable()
                                //.frame(width: 20, height: 20)
                                //.foregroundColor(Color.black)
                                //.padding(10)
                        }
                    }
                    List { ForEach(items, id: \.self) { item in
                        NavigationLink(destination: RecipeView(viewChanger: viewChanger)){
                            Text(item.words ?? "unknown")
                        }.onAppear(){
                            globalInt = item.id
                        }
                        }
                    //.onDelete(perform: removeItem)
                    }
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
    @StateObject var viewChanger: ViewChanger
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: RName.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RName.words, ascending: true )],
        predicate: NSPredicate(format: "id = %@", globalInt))var name: FetchedResults<RName>
    @FetchRequest(
        entity: Ing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Ing.words, ascending: true )],
        predicate: NSPredicate(format: "id = %@", globalInt))var ings: FetchedResults<Ing>
    @FetchRequest(
        entity: Step.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Step.words, ascending: true )],
        predicate: NSPredicate(format: "id = %@", globalInt))var steps: FetchedResults<Step>
    var body: some View {
        List {
            Section(header: Text("Recipe:")) {
                ForEach(name, id: \.self) { item in
                    Text(item.words ?? "unknown")
                }}
            Section(header: Text("Ingredients:")) {
                ForEach(ings, id: \.self) { item in
                    Text(item.words ?? "unknown")
                }}
            Section(header: Text("Method:")) {
                ForEach(steps, id: \.self) { item in
                    Text(item.words ?? "unknown")
                }}
        }
    }
    
}

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: RName.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RName.words, ascending: true )])var items: FetchedResults<RName>
    @StateObject var viewChanger: ViewChanger
    @State var nameEntry: String = ""
    @State var ingEntry: String = ""
    @State var stepEntry: String = ""
    @State var showName: Bool = true
    @State var nameDisplay: String = ""
    @State var ingDisplay = [String] ()
    @State var stepDisplay = [String] ()
    var body: some View {
        VStack{
            Text("Add Recipe")
            if showName == true {
                HStack {
                    TextField("Add name here", text:$nameEntry)
                    Button(action:{
                        let newObject = RName(context: managedObjectContext)
                        newObject.words = nameEntry
                        newObject.id = Int64(items.count + 1)
                        PersistenceController.shared.save()
                        showName = false
                        nameDisplay = nameEntry
                        nameEntry = ""
                    }, label:{
                        Text("Add")
                    })
                }
            }
            else {
                Text("Name Added!")
            }
            HStack {
                TextField("Add ingredient", text:$ingEntry)
                Button(action:{
                    let newObject = Ing(context: managedObjectContext)
                    newObject.words = ingEntry
                    newObject.id = Int64(items.count + 1)
                    PersistenceController.shared.save()
                    ingDisplay.append(ingEntry)
                    ingEntry = ""
                }, label:{
                    Text("Add")
                })
            }
            HStack {
                TextField("Add Step", text:$stepEntry)
                Button(action:{
                    let newObject = Step(context: managedObjectContext)
                    newObject.words = stepEntry
                    newObject.id = Int64(items.count + 1)
                    PersistenceController.shared.save()
                    stepDisplay.append(stepEntry)
                    stepEntry = ""
                }, label:{
                    Text("Add")
                })
            }
            Text(nameDisplay)
            List {
                Section(header: Text("Ingredients:")) {
                    ForEach(ingDisplay, id: \.self) { itm in
                        Text(itm)
                    }
                }
                Section(header: Text("Method:")) {
                    ForEach(stepDisplay, id: \.self) { item in
                        Text(item)
                    }
                }
            }
        }
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
        RecipeView(viewChanger: ViewChanger()).preferredColorScheme(.dark)
    }
}
     
