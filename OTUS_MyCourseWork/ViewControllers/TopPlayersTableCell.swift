//
//  TopPlayersTableCell.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 15.04.2023.
//

import Foundation
import UIKit

class TopPlayersTableCell: UITableViewCell {
    
    lazy var playerAvatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var playerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var playerPointsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        
        addSubview(playerAvatarImageView)
        playerAvatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
        }
        
        addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(120)
            make.centerY.equalTo(self)
        }
        
        addSubview(playerPointsLabel)
        playerPointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
