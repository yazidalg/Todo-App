//
//  Model.swift
//  Todo App
//
//  Created by Yazid Al Ghazali on 26/11/20.
//

import Foundation
import CoreData

class Model: ObservableObject {

    @Published var contentName = ""
    @Published var contentDesc = ""
    
    @Published var isNewData = false
    
    @Published var updateItem: Task!
    
    func writeData(context: NSManagedObjectContext ){
        
        if updateItem != nil{
            
            updateItem.name = contentName
            updateItem.info = contentDesc
            
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            contentName = ""
            contentDesc = ""
            return
            
        }
        let todo = Task(context: context)
        todo.id = UUID()
        todo.name = self.contentName
        todo.info = self.contentDesc
        do{
            try context.save()
            isNewData.toggle()
            contentName = ""
            contentDesc = ""
            
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func editItem(item: Task){
        updateItem = item
        
        contentName = item.name!
        contentDesc = item.info!
        isNewData.toggle()
        
    }
}
