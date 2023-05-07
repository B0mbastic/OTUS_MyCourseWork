////
////  BlinkOperation.swift
////  OTUS_MyCourseWork
////
////  Created by Александр Ковбасин on 29.04.2023.
////
//
//import UIKit
//import AVFoundation
//
//class BlinkOperation: AsyncOperation {
//    private var audioPlayer = AudioPlayer()
//    weak var view: UIView?
//    let sound: String
//    let delayOn: TimeInterval
//    let delayOff: TimeInterval
//    
//    init(view: UIView? = nil, sound: String, delayOn: TimeInterval, delayOff: TimeInterval) {
//        self.view = view
//        self.sound = sound
//        self.delayOn = delayOn
//        self.delayOff = delayOff
//    }
//    
//    override func main() {
//        self.audioPlayer.playSound(soundFileName: self.sound)
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.1, delay: self.delayOn) {
//                self.view?.alpha = 1.0
//            } completion: { _ in
//                UIView.animate(withDuration: 0.1, delay: self.delayOff) {
//                    self.view?.alpha = 0
//                } completion: { _ in
//                    self.finish()
//                }
//            }
//        }
//    }
//}
