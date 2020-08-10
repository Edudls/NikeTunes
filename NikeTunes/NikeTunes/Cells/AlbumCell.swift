//
//  AlbumCell.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/9/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    let name: UILabel = {
        let label = UILabel(alignment: .left)
        return label
    }()
    let artist: UILabel = {
        let label = UILabel(alignment: .left)
        return label
    }()
    let art: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // StackView
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(artist)
        
        // Add SubView
        contentView.addSubview(art)
        contentView.addSubview(stackView)
        
        // Constraints
        let constraints = [
            art.heightAnchor.constraint(equalToConstant: 120),
            art.widthAnchor.constraint(equalToConstant: 120),
            art.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            art.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            art.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: art.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
