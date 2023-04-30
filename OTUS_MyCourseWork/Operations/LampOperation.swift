//
//  LampOperation.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 30.04.2023.
//

import UIKit
import AVFoundation

class LampOperation: AsyncOperation {
    private var audioPlayer = AudioPlayer()
    weak var view: UIView?
    let sound: String?
    let delayOn: TimeInterval?
    let delayOff: TimeInterval?
    
    init(view: UIView? = nil, sound: String? = nil, delayOn: TimeInterval? = nil, delayOff: TimeInterval? = nil) {
        self.view = view
        self.sound = sound
        self.delayOn = delayOn
        self.delayOff = delayOff
    }
    
    override func main() {
        if sound != nil {
            self.audioPlayer.playSound(soundFileName: self.sound!)
        }
        DispatchQueue.main.async {
            if (self.delayOn != nil) && (self.delayOff == nil) {
                UIView.animate(withDuration: 0, delay: self.delayOn!) {
                    self.view?.alpha = 1.0
                } completion: { _ in
                    self.finish()
                }
            }
            
            if (self.delayOff != nil) && (self.delayOn == nil) {
                UIView.animate(withDuration: 0, delay: self.delayOff!) {
                    self.view?.alpha = 0
                } completion: { _ in
                    self.finish()
                }
            }
            if (self.delayOn != nil) && (self.delayOff != nil)
            {
                UIView.animate(withDuration: 0, delay: self.delayOn!) {
                    self.view?.alpha = 1.0
                } completion: { _ in
                    UIView.animate(withDuration: 0, delay: self.delayOff!) {
                        self.view?.alpha = 0
                    } completion: { _ in
                        self.finish()
                    }
                }
            }
        }
    }
}

