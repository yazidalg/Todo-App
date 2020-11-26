//
//  AddData.swift
//  Todo App
//
//  Created by Yazid Al Ghazali on 25/11/20.
//

import SwiftUI

struct AddData: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var pMode
    @State var type = ""
    @State var priority = "Normal"
    let properties = ["High", "Normal", "Low"]
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        TextField("Type Your Activity Here", text: $type)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        
                        Picker(selection: $priority, label: Text("Priority"), content: {
                            ForEach(properties, id: \.self){
                                Text($0)
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                let todo = Task(context: self.moc)
                                todo.name = self.type
                                todo.priority = self.priority
                                todo.id = UUID()
                                
                                
                                self.pMode.wrappedValue.dismiss()
                                try! self.moc.save()
                            }, label: {
                                Text("Add Now!")
                                    .bold()
                                    .padding()
                                    .cornerRadius(5)
                            })
                            Spacer()
                        }
                        
                    }
                }
                Spacer()
            }
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.pMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
        }
    }
}
