////
////  LightOperation.swift
////  OTUS_MyCourseWork
////
////  Created by Александр Ковбасин on 29.04.2023.
////
//
//import UIKit
//import AVFoundation
//
//class LightOperation: AsyncOperation {
//    private var audioPlayer = AudioPlayer()
//    weak var view: UIView?
//    let duration: TimeInterval
//    let delay: TimeInterval
//    let sound: String?
//    
//    init(view: UIView? = nil, duration: TimeInterval, delay: TimeInterval, sound: String?) {
//        self.view = view
//        self.duration = duration
//        self.delay = delay
//        self.sound = sound
//    }
//    
//    override func main() {
//        if sound != nil {
//            self.audioPlayer.playSound(soundFileName: self.sound!)
//        }
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: self.duration, delay: self.delay) {
//                self.view?.alpha = 1.0
//            } completion: { _ in
//                self.finish()
//            }
//        }
//    }
//}
