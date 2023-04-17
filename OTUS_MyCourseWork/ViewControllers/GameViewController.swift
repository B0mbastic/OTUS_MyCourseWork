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
    private lazy var sizeConstant: CGFloat = view.frame.width * 0.7
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    private lazy var toyImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "allOff.png")
        image.layer.zPosition = 2
        return image
    }()
    private lazy var yellowLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yellowOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var greenLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "greenOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var violetLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "violetOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var blueLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blueOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var orangeLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "orangeOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var redLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "redOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var violetButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        //button.backgroundColor = .systemPurple
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var redButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        //button.backgroundColor = .systemRed
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var yellowButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        //button.backgroundColor = .systemYellow
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var greenButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        //button.backgroundColor = .systemGreen
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var orangeButton: UIButton = {
        let button = UIButton()
        button.tag = 4
        //button.backgroundColor = .systemOrange
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var blueButton: UIButton = {
        let button = UIButton()
        button.tag = 5
        //button.backgroundColor = .systemBlue
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
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
    
    private lazy var lightQueue = [LampModel(id: 0, view: violetLight), LampModel(id: 1, view: redLight), LampModel(id: 2, view: yellowLight), LampModel(id: 3, view: greenLight), LampModel(id: 4, view: orangeLight), LampModel(id: 5, view: blueLight)].shuffled()
    
    
    let yellowSound = URL(fileURLWithPath: Bundle.main.path(forResource: "yellowSound", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    let blinkSpeed: Double = 0.5
    //var gameSize = 300
    
    var queue = OperationQueue()
    var gameSubsequence: [Int] = []
    var playerSubsequence: [Int] = []
    
    
    private func setupViews() {
        view.addSubview(toyImageView)
        view.addSubview(violetLight)
        view.addSubview(redLight)
        view.addSubview(yellowLight)
        view.addSubview(greenLight)
        view.addSubview(orangeLight)
        view.addSubview(blueLight)
        view.addSubview(violetButton)
        view.addSubview(redButton)
        view.addSubview(yellowButton)
        view.addSubview(greenButton)
        view.addSubview(orangeButton)
        view.addSubview(blueButton)
        view.addSubview(startButton)
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toyImageView.snp.top).offset(-40)
        }
        toyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        violetLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        redLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        yellowLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        greenLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        orangeLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        blueLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        violetButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(-sizeConstant/3)
            make.width.height.equalTo(sizeConstant/3)
        }
        redButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(-sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        yellowButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        greenButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(sizeConstant/3)
            make.width.height.equalTo(sizeConstant/3)
        }
        orangeButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(-sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        blueButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(-sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(-sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(toyImageView.snp.centerY).offset(200)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        queue.maxConcurrentOperationCount = 1
    }
    
    func lightLamp(lampImageView: UIImageView) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: yellowSound)
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
        lampImageView.layer.zPosition = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + blinkSpeed) {
            lampImageView.layer.zPosition = 1
        }
    }
    
    
    //    @objc func startGame(sender: UIButton!){
    //        playerSubsequence = []
    //        redButton.isHidden = false
    //        yellowButton.isHidden = false
    //        mainLabel.isHidden = true
    //        startButton.isHidden = true
    //    }
    
    @objc func startGame(sender: UIButton!){
        enum NetworkError: Error {
            case customError
        }
        mainLabel.isHidden = true
        startButton.isHidden = true
        playerSubsequence = []
        
        for item in lightQueue {
            queue.addOperation { [weak self] in
                DispatchQueue.main.async {
                    self?.lightLamp(lampImageView: item.view)
                }
                
                self?.queue.isSuspended = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self?.queue.isSuspended = false
                }
            }
        }
        queue.addOperation {
            DispatchQueue.main.async {
                self.showButtons()
            }
        }
    }
    
    @objc func pressButton(sender: UIButton) {
        let tag: Int = sender.tag
        let lamp: UIImageView
        switch tag {
        case 0: lamp = violetLight
        case 1: lamp = redLight
        case 2: lamp = yellowLight
        case 3: lamp = greenLight
        case 4: lamp = orangeLight
        case 5: lamp = blueLight
        default: return
        }
        lightLamp(lampImageView: lamp)
        playerSubsequence.append(sender.tag)
        if isEqualArray(playerSubsequence, with: lightQueue) {
            if playerSubsequence.count == lightQueue.count {
                mainLabel.text = "YOU WIN!"
                hideButtons()
            }
        } else {
            hideButtons()
            mainLabel.text = "YOU LOOSE!"
        }
    }
    func isEqualArray(_ array1: [Int], with array2: [LampModel]) -> Bool {
        var isEqual: Bool = true
        for (index, item) in array1.enumerated() {
            if item != (array2[index].id) {
                isEqual = false
                break
            }
        }
        return isEqual
        //return Set(array1).intersection(array2).count == 0 ? false : true
    }
    func hideButtons() {
        redButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = true
        orangeButton.isHidden = true
        blueButton.isHidden = true
        violetButton.isHidden = true
        mainLabel.isHidden = false
        startButton.isHidden = false
    }
    func showButtons() {
        redButton.isHidden = false
        yellowButton.isHidden = false
        greenButton.isHidden = false
        orangeButton.isHidden = false
        blueButton.isHidden = false
        violetButton.isHidden = false
        mainLabel.isHidden = true
        startButton.isHidden = true
    }
}


