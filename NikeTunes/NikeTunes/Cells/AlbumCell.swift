//
//  AlbumCell.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/9/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    let name = UILabel()
    let artist = UILabel()
    let art = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        artist.translatesAutoresizingMaskIntoConstraints = false
        art.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        contentView.addSubview(artist)
        contentView.addSubview(art)
        
        let constraints = [
            art.heightAnchor.constraint(equalToConstant: 100),
            art.widthAnchor.constraint(equalToConstant: 100),
            art.topAnchor.constraint(equalTo: self.topAnchor),
            art.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            name.topAnchor.constraint(equalTo: self.topAnchor),
            name.leadingAnchor.constraint(equalTo: art.trailingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            artist.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            artist.leadingAnchor.constraint(equalTo: art.trailingAnchor, constant: 10),
            artist.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
