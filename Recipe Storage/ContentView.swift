//
//  ContentView.swift
//  Recipe Storage
//
//  Created by Tim Randall on 11/11/21.
//

import SwiftUI

struct BossView: View {
    @StateObject var viewChanger: ViewChanger
    var body: some View {
        if viewChanger.num == 0 {
            ContentView(viewChanger: viewChanger)
        }
        else if viewChanger.num == 1 {
            RecipeView(viewChanger: viewChanger)
        }
        else if viewChanger.num == 2 {
            AddRecipeView(viewChanger: viewChanger)
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var viewChanger: ViewChanger
    @FetchRequest(
        entity: Thing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Thing.words, ascending: true )],
        predicate: NSPredicate(format: "type = %@", "name"))var items: FetchedResults<Thing>
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
                        Button(action:{
                            viewChanger.num = 1
                            globalInt = item.id
                        }, label:{
                            Text(item.words ?? "unknown")
                        })
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
        entity: Thing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Thing.words, ascending: true )],
        predicate: NSPredicate(format: "(id = globalInt) AND (type = %@)", "name"))var name: FetchedResults<Thing>
    @FetchRequest(
        entity: Thing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Thing.words, ascending: true )],
        predicate: NSPredicate(format: "(id = globalInt) AND (type = %@)", "ing"))var ings: FetchedResults<Thing>
    @FetchRequest(
        entity: Thing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Thing.words, ascending: true )],
        predicate: NSPredicate(format: "(id = globalInt) AND (type = %@)", "step"))var steps: FetchedResults<Thing>
    var body: some View {
        Text("hello world")
    }
}

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var viewChanger: ViewChanger
    @State var name: String = ""
    @State var ing: String = ""
    @State var step: String = ""
    @State var showName: Bool = true
    var body: some View {
        VStack{
            Text("Add Recipe")
            if showName == true {
                HStack {
                    TextField("Add name here", text:$name)
                    Button(action:{
                        let newObject = Thing(context: managedObjectContext)
                        newObject.words = name
                        newObject.id = globalInt
                        newObject.type = "name"
                        showName = false
                        name = ""
                    }, label:{
                        Text("Add")
                    })
                }
            }
            else {
                Text("Name Added!")
            }
            HStack {
                TextField("Add ingredient", text:$ing)
                Button(action:{
                    let newObject = Thing(context: managedObjectContext)
                    newObject.words = ing
                    newObject.id = globalInt
                    newObject.type = "ing"
                    ing = ""
                }, label:{
                    Text("Add")
                })
            }
            HStack {
                TextField("Add Step", text:$step)
                Button(action:{
                    let newObject = Thing(context: managedObjectContext)
                    newObject.words = step
                    newObject.id = globalInt
                    newObject.type = "step"
                    step = ""
                }, label:{
                    Text("Add")
                })
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
        ContentView(viewChanger: ViewChanger()).preferredColorScheme(.dark)
    }
}
     
