//
//  ContentView.swift
//  Todo App
//
//  Created by Yazid Al Ghazali on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.name, ascending: true)]) var results : FetchedResults<Task>
    
    @State var isShowData = false
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(results){data in
                        HStack{
                            Text(data.name ?? "")
                                .lineLimit(2)
                            Spacer()
                            Text(data.priority ?? "")
                        }
                        .contextMenu{
                            Button(action: {
                                moc.delete(data)
                                try! moc.save()
                            }, label: {
                                Text("Delete")
                            })
                        }
                    }.onDelete(perform: deleteItem(at:))
                }
                Button(action: {
                    self.isShowData.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .scaledToFit()
                        .background(Circle().fill(Color.white))
                })
                .sheet(isPresented: $isShowData, content: {
                    AddData().environment(\.managedObjectContext, self.moc)
                })
            }.navigationBarTitle("Todo", displayMode: .inline)
            
        }
    }
    func deleteItem(at offset: IndexSet) {
        for index in offset{
            let todo = results[index]
            moc.delete(todo)
            
            try! self.moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
