//
//  DataController.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 03/09/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "PlayerDataModel")
    
    init(){
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data save")
        }catch{
            print("Not save the data")
        }
    }
    
    func addResult(name:String , score: Int64, context: NSManagedObjectContext){
        let result = Result(context: context)

        result.name = name
        result.score=score
        
        save(context: context)
    }
    
}
