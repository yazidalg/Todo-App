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
    @ObservedObject var model = Model()
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    TextField("Title", text: $model.contentName)
                        .padding()
                    TextField("Description", text: $model.contentDesc)
                        .padding()
                    Button(action: {
                        model.writeData(context: moc)
                        try! self.moc.save()
                        self.pMode.wrappedValue.dismiss()
                    }, label: {
                        Text(model.updateItem != nil ? "Save" : "Update")
                    })
                }
            }
        }
    }
}
