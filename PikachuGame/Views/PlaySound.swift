//
//  PlaySound.swift
//  PikachuGame
//
//  Created by Nguyen The Bao Ngoc on 05/09/2023.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

var audioPlayer2: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch {
            print("Error: could not find and play the sound file!")
        }
    }
}

func playSound2(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer2?.play()
        }catch {
            print("Error: could not find and play the sound file!")
        }
    }
}
