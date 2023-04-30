//
//  LightOff.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 30.04.2023.
//

import UIKit
class LightOffOperation: AsyncOperation {
    weak var view: UIView?
    let duration: TimeInterval
    let delay: TimeInterval
    
    init(view: UIView? = nil, duration: TimeInterval, delay: TimeInterval) {
        self.view = view
        self.duration = duration
        self.delay = delay
    }
    
    override func main() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.duration, delay: self.delay) {
                self.view?.alpha = 0
            } completion: { _ in
                self.finish()
            }
        }
    }
}
