//
//  ViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 28.02.2023.
//

import UIKit
import SnapKit
import AVFoundation

class GameViewController: UIViewController {
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    private lazy var AllOff: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "allOff.png")
        image.layer.zPosition = 2
        return image
    }()
    private lazy var YellowLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yellowOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var GreenLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "greenOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var VioletLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "violetOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var BlueLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blueOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var OrangeLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "orangeOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var RedLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "redOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var yellowButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        //button.backgroundColor = .yellow
        button.layer.cornerRadius = 50
        button.layer.zPosition = 5
        button.isHidden = false
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var redButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        //button.backgroundColor = .red
        button.layer.cornerRadius = 50
        button.layer.zPosition = 5
        button.isHidden = false
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.layer.zPosition = 5
        button.setTitle("START", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    var lightQueue: [UIImageView] = []
    let yellowSound = URL(fileURLWithPath: Bundle.main.path(forResource: "yellowSound", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    let blinkSpeed: Double = 0.5
    var gameSize = 300
    var queue = OperationQueue()
    var gameSubsequence: [Int] = [1, 2, 1]
    var playerSubsequence: [Int] = []
    
    
    private func setupViews() {
        view.addSubview(AllOff)
        view.addSubview(YellowLight)
        view.addSubview(GreenLight)
        view.addSubview(VioletLight)
        view.addSubview(BlueLight)
        view.addSubview(OrangeLight)
        view.addSubview(RedLight)
        view.addSubview(yellowButton)
        view.addSubview(redButton)
        view.addSubview(startButton)
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
        }
        
        AllOff.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(gameSize)
        }
        GreenLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        VioletLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        YellowLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        BlueLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        OrangeLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        RedLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
        yellowButton.snp.makeConstraints { make in
            make.centerX.equalTo(AllOff.snp.centerX).offset(90)
            make.centerY.equalTo(AllOff.snp.centerY).offset(50)
            make.width.height.equalTo(100)
        }
        redButton.snp.makeConstraints { make in
            make.centerX.equalTo(AllOff.snp.centerX).offset(90)
            make.centerY.equalTo(AllOff.snp.centerY).offset(-50)
            make.width.height.equalTo(100)
        }
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(AllOff.snp.centerY).offset(200)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        
        //        for (index, value) in lightQueue.enumerated() {
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) + blinkSpeed) {
        //                            value.layer.zPosition = 3
        //                        }
        //
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) + blinkSpeed*2) {
        //                            value.layer.zPosition = 1
        //                            self.RedButton.isHidden = false
        //                        }
        //                }
        
        queue.maxConcurrentOperationCount = 1
        lightQueue = [VioletLight, RedLight, YellowLight, GreenLight, OrangeLight, BlueLight]
        
        
        
        
        
        //        queue.addOperation { [weak self] in
        //
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        //                self?.RedButton.isHidden = false
        //                self?.YellowButton.isHidden = false
        //            }
        //        }
        
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            self.YellowLight.layer.zPosition = 3
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        //            self.YellowLight.layer.zPosition = 1
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            self.GreenLight.layer.zPosition = 3
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        //            self.GreenLight.layer.zPosition = 1
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //            self.VioletLight.layer.zPosition = 3
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
        //            self.VioletLight.layer.zPosition = 1
        //        }
        
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //
    //
    //
    //
    //
    //
    //
    //        //YellowLight.layer.zPosition = 1
    //
    //
    //    }
    //
    func lightLamp(lampImageView: UIImageView) {
        //            do {
        //                 audioPlayer = try AVAudioPlayer(contentsOf: yellowSound)
        //                 audioPlayer.play()
        //            } catch {
        //               // couldn't load file :(
        //            }
        
        lampImageView.layer.zPosition = 3
        
        //lampImageView.layer.zPosition = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + blinkSpeed) {
            lampImageView.layer.zPosition = 1
        }
    }
    
    
    @objc func startGame(sender: UIButton!){
        playerSubsequence = []
        redButton.isHidden = false
        yellowButton.isHidden = false
        mainLabel.isHidden = true
        startButton.isHidden = true
    }
//    @objc func startGame(sender: UIButton!){
//        enum NetworkError: Error {
//            case customError
//        }
//        //navigationController?.navigationBar.isHidden = true
//        //startButton.isHidden = true
//        //lightQueue = lightQueue.shuffled()
//        for (index, item) in lightQueue.enumerated() {
//            queue.addOperation { [weak self] in
//                DispatchQueue.main.async {
//                    self?.lightLamp(lampImageView: item)
//                }
//
//                self?.queue.isSuspended = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    self?.queue.isSuspended = false
//                    if (index == self!.lightQueue.indices.last) {
//                        //print (lightQueue.indices.last)
//                        //self!.startButton.isHidden = false
//                    }
//                }
//
//            }
//        }
//    }
    @objc func pressButton(sender: UIButton) {
        let tag: Int = sender.tag
        let lamp: UIImageView
        switch tag {
        case 1: lamp = RedLight
        case 2: lamp = YellowLight
        default: return
        }
        lightLamp(lampImageView: lamp)
        playerSubsequence.append(sender.tag)
            if isEqualArray(playerSubsequence, with: gameSubsequence) {
                if playerSubsequence.count == gameSubsequence.count {
                    mainLabel.text = "YOU WIN!"
                    redButton.isHidden = true
                    yellowButton.isHidden = true
                    mainLabel.isHidden = false
                    startButton.isHidden = false
                }
            } else {
                mainLabel.text = "YOU LOOSE!"
                redButton.isHidden = true
                yellowButton.isHidden = true
                mainLabel.isHidden = false
                startButton.isHidden = false
            }
    }
    func isEqualArray(_ array1: [Int], with array2: [Int]) -> Bool {
        var isEqual: Bool = true
        for (index, item) in array1.enumerated() {
            if item != (array2[index]) {
                isEqual = false
                break
            }
        }
        return isEqual
        //return Set(array1).intersection(array2).count == 0 ? false : true
    }
}


