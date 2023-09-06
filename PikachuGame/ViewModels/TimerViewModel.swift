//
//  TimerViewModel.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 22/08/2023.
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
  Acknowledgement: lecture slide.
*/
import Foundation

extension GameView {
    final class TimerViewModel: ObservableObject {
        
        //State of the timer
        @Published var isActive = false
        @Published var isAlert = false

        //the difference between start time and current time
        @Published var diff: Double = 0.0
        
        @Published var remainingTime: Double = 0.0
        private var initialTime:Double{
            didSet{
                remainingTime = initialTime
            }
        }
        

        
        init(){
            self.isActive = false
            self.isAlert = false
            self.remainingTime = 0
            self.diff = 0
            self.initialTime = 0
        }
        
        //start counting from minutes
        func start(minutes: Float){
            self.initialTime = Double(minutes * 6000)
            self.isActive = true

        }
        
        //stop the timer at the current state
        func stopTimer(){
            self.isActive = false

        }
        
        //continue counting
        func continueTimer(){
            self.isActive = true
        }
        
        //countdown 
        func updateCountDown(){
            guard isActive else {return}
            remainingTime -= 1
            diff = (initialTime - remainingTime) / initialTime
            if remainingTime <= 0 {
                isActive = false
                isAlert = true
            }
            
        }
    }
}
