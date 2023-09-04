//
//  PlayerData+CoreDataProperties.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 04/09/2023.
//
//

import Foundation
import CoreData


extension PlayerData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerData> {
        return NSFetchRequest<PlayerData>(entityName: "PlayerData")
    }

    @NSManaged public var name: String?
    @NSManaged public var progression: Int64
    @NSManaged public var highScore: Int64
    @NSManaged public var matches: Int64
    @NSManaged public var won: Int64

}

extension PlayerData : Identifiable {

}
