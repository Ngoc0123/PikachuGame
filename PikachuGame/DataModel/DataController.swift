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
    
    func addPlayer(name:String, context: NSManagedObjectContext){
        let playerdata = PlayerData(context: context)

        playerdata.name = name
        playerdata.progression = 0
        playerdata.highScore = 0
        playerdata.matches = 0
        playerdata.won = 0
        
        save(context: context)
    }
    
    func getAllPlayer(context: NSManagedObjectContext) -> [PlayerData]{
        let fetchRequest: NSFetchRequest<PlayerData> = PlayerData.fetchRequest()
        
        do{
            return try context.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    
    func searchFor(name: String, context: NSManagedObjectContext) -> Player{
        let players = getAllPlayer(context: context)
        var playerIndex = -1
        var player = Player(name: "", gameMode: 1, progression: 0, highscore: 0, matches: 0, won: 0)
        
        for data in players {
            if data.name == name{
                
                playerIndex = players.firstIndex(of: data)!
                break
            }
        }
        
        print(("\(playerIndex)"))
        
        if playerIndex == -1 {
            DataController().addPlayer(name: name, context: context)
            player.name = name
            player.progression = 0
            player.matches = 0
            player.won = 0
            player.highscore = 0
            
        }else{
            player.name = players[playerIndex].name!
            player.progression = Int(players[playerIndex].progression)
            player.matches = Int(players[playerIndex].matches)
            player.won = Int(players[playerIndex].won)
            player.highscore = Int(players[playerIndex].highScore)
        }
        
        return player
        
    }
    
    func savePlayer(player: Player, context: NSManagedObjectContext){
        let playerdata = PlayerData(context: context)
        playerdata.name = player.name
        playerdata.progression = Int64(player.progression)
        playerdata.highScore = Int64(player.highscore)
        playerdata.matches = Int64(player.matches)
        playerdata.won = Int64(player.won)
        
        save(context: context)
    }

}

//Fix warning when it add new result into the context
extension NSManagedObject {
    
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
