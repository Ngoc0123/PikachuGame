//
//  Result+CoreDataProperties.swift
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


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Int64

}

extension Result : Identifiable {

}
