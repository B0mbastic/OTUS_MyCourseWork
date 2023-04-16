//
//  TopPlayersTableCell.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 15.04.2023.
//

import Foundation
import UIKit

class TopPlayersTableCell: UITableViewCell {
    var personNameLabel = UILabel()
    let personPhotoImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        print(layer.frame.height)
        addSubview(personPhotoImageView)
        personPhotoImageView.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        personPhotoImageView.layer.borderWidth = 1
        personPhotoImageView.contentMode = .scaleAspectFill
        personPhotoImageView.clipsToBounds = true

        addSubview(personNameLabel)
        personNameLabel.translatesAutoresizingMaskIntoConstraints = false
        personNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        personNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        personNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        personNameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPersonName(personName: String, personPhoto: String) {
        personNameLabel.text = personName
        personPhotoImageView.image = UIImage(named: personPhoto)
    }
}
