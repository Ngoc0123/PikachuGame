//
//  TimerViewModel.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 22/08/2023.
//

import Foundation

extension GameView {
    final class TimerViewModel: ObservableObject {
        @Published var isActive = false
        @Published var isAlert = false

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
        
        func start(minutes: Float){
            self.initialTime = Double(minutes * 6000)
            self.isActive = true

        }
        
        func stopTimer(){
            self.isActive = false

        }
        
        func continueTimer(){
            self.isActive = true
        }
        
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
