//
//  LaunchScreenViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit
import SnapKit

class LaunchScreenViewController: UIViewController {
    private lazy var AllOff: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "allOff.png")
        image.layer.zPosition = 2
        return image
    }()
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "LOADING"
        return label
    } ()
    private var gameSize = 300
    
    private func setupViews() {
        view.addSubview(AllOff)
        AllOff.snp.makeConstraints { make in
            AllOff.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.height.equalTo(gameSize)
            }
        }
        view.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints { make in
            make.centerX .equalToSuperview()
            make.top.equalTo(AllOff.snp.bottom).offset(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
