//
//  LaunchScreenViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    private lazy var sizeConstant: CGFloat = 300
    let blinkSpeed: Double = 0.5
    private lazy var lightQueue = [LampModel(id: 0, view: violetLight, sound: "violet.wav"), LampModel(id: 1, view: redLight, sound: "red.wav"), LampModel(id: 2, view: yellowLight, sound: "yellow.wav"), LampModel(id: 3, view: greenLight, sound: "green.wav"), LampModel(id: 4, view: orangeLight, sound: "orange"), LampModel(id: 5, view: blueLight, sound: "blue")]
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        view.layer.zPosition = 2
        return view
    }()
    private lazy var AllOff: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "allOff.png")
        image.layer.zPosition = 2
        return image
    }()
    private lazy var yellowLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yellowOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var greenLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "greenOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var violetLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "violetOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var blueLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blueOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var orangeLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "orangeOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var redLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "redOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold) //UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.text = "LOADING..."
        return label
    } ()
    private func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            // make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        view.addSubview(AllOff)
        AllOff.snp.makeConstraints { make in
            AllOff.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.height.equalTo(sizeConstant)
            }
        }
        view.addSubview(violetLight)
        violetLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        view.addSubview(redLight)
        redLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        view.addSubview(yellowLight)
        yellowLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        view.addSubview(greenLight)
        greenLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        view.addSubview(orangeLight)
        orangeLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        view.addSubview(blueLight)
        blueLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        view.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(AllOff.snp.bottom).offset(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        
        operationQueue.isSuspended = true
        lightQueue.forEach { item in
            let operation = LightOperation(view: item.view, duration: 0.1, delay: 0.2, sound: nil)
            operationQueue.addOperation(operation)
        }
        operationQueue.addOperation {
            DispatchQueue.main.async {
                let mainMenuController = MainMenuViewController()
                self.navigationController?.setViewControllers([mainMenuController], animated: true)
                //self.navigationController?.pushViewController(mainMenuController, animated: true)
                //self.navigationController?.viewControllers.removeFirst()
            }
        }
        
        operationQueue.isSuspended = false
        
        //        for item in lightQueue {
        //            queue.addOperation { [weak self] in
        //                DispatchQueue.main.async {
        //                    self?.lightLamp(lampImageView: item.view, lampSound: item.sound)
        //                }
        //                queue.isSuspended = true
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        //                    queue.isSuspended = false
        //                }
        //            }
        //        }
        //        queue.addOperation {
        //            DispatchQueue.main.async {
        //                let mainMenuController = MainMenuViewController()
        //                self.navigationController?.pushViewController(mainMenuController, animated: true)
        //                self.navigationController?.viewControllers.removeFirst()
        //            }
        //        }
    }
    
//    func lightLamp(lampImageView: UIImageView, lampSound: String) {
//        let animation = CABasicAnimation(keyPath: "opacity")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = 0.1
//
//        lampImageView.layer.opacity = 1
//        lampImageView.layer.add(animation, forKey: nil)
//    }
}
