//
//  ContentView.swift
//  Todo App
//
//  Created by Yazid Al Ghazali on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var results : FetchedResults<Task>
    
    @ObservedObject var model = Model()
    
    let column = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            VStack{
                if results.isEmpty{
                    Spacer()
                    Text("No Task")
                    Spacer()
                }else{
                    List{
                        ForEach(results){data in
                            TaskItem(task: data)
                                .contextMenu{
                                    Button(action: {
                                        moc.delete(data)
                                        try! moc.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                    Button(action: {
                                        model.editItem(item: data)
                                        try? self.moc.save()
                                    }, label: {
                                        Text("Edit")
                                    })
                                }
                        }.onDelete(perform: deleteItem(at:))
                    }
                }
                HStack{
                    Button(action: {
                        model.isNewData.toggle()
                    }, label: {
                        Text("add")
                    })
                    .sheet(isPresented: $model.isNewData, content: {
                        AddData(model: model).environment(\.managedObjectContext, moc)
                    })
                }
            }.onAppear{
                try? self.moc.save()
            }
        }
    }
    func deleteItem(at item: IndexSet) {
        for index in item{
            let data = results[index]
            moc.delete(data)
            
            try! moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
