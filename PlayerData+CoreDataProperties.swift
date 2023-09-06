//
//  PlayerData+CoreDataProperties.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 04/09/2023.
//
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen The Bao Ngoc
  ID: s3924436
  Created  date: 04/09/2023.
  Last modified: 06/09/2023
  Acknowledgement: lecture slide, youtube, stackoverflow
*/
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
