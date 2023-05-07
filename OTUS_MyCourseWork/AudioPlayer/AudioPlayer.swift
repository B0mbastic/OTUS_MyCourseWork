//
//  AudioManager.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 26.04.2023.
//

import Foundation
import AVFoundation

final class AudioPlayer {
    private var audioPlayer: AVAudioPlayer!
    private var isAudioOn = UserDefaultsManager().checkKey(key: "isAudioOnKey") ?  UserDefaultsManager.isAudioOn : true
    func playSound(soundFileName: String) {
        let split = soundFileName.components(separatedBy: ".")
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: split[0], ofType: split[1])!)
        if isAudioOn {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: sound)
                audioPlayer.play()
            } catch {
                print ("couldn't load file!")
            }
        }
    }
}
