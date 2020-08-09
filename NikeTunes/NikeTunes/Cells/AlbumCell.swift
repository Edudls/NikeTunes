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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name.translatesAutoresizingMaskIntoConstraints = false
        artist.translatesAutoresizingMaskIntoConstraints = false
        art.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        contentView.addSubview(artist)
        contentView.addSubview(art)
        
        let constraints = [
            art.heightAnchor.constraint(equalToConstant: 100),
            art.widthAnchor.constraint(equalToConstant: 100),
            art.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            art.topAnchor.constraint(equalTo: self.topAnchor),
            name.topAnchor.constraint(equalTo: self.topAnchor),
            name.leadingAnchor.constraint(equalTo: art.trailingAnchor, constant: 10),
            artist.leadingAnchor.constraint(equalTo: art.trailingAnchor, constant: 10),
            artist.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
