//
//  Test+CoreDataProperties.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 03/09/2023.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Test")
    }

    @NSManaged public var name: String?
    @NSManaged public var gameMode: Int64
    @NSManaged public var score: Int64
    
}

extension Player : Identifiable {

}
