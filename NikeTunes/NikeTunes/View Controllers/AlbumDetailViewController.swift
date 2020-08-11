//
//  AlbumDetailViewController.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/9/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    var cellIndex: Int = 0
    weak var viewModel: AlbumListViewModel?
    
    let name: UILabel = {
        let label = UILabel(alignment: .center, textColor: .black)
        return label
    }()
    let artist: UILabel = {
        let label = UILabel(alignment: .center, textColor: .black)
        return label
    }()
    let releaseDate: UILabel = {
        let label = UILabel(alignment: .center, textColor: .black)
        return label
    }()
    let copyright: UILabel = {
        let label = UILabel(alignment: .center, textColor: .black, font: 10)
        return label
    }()
    let genres: UILabel = {
        let label = UILabel(alignment: .center, textColor: .black)
        return label
    }()
    let art: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let storeLink: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Open in Apple Music", for: .normal)
        button.addTarget(self, action: #selector(appleMusicButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        setupConstraints()
    }
    
    @objc func appleMusicButtonAction() {
        guard let urlString = viewModel?.albums[cellIndex].storeUrl, let url = URL(string: urlString) else {
            print("Invalid Apple Music URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    func buildUI() {
        view.backgroundColor = .white
        
        edgesForExtendedLayout = []
        guard let album = viewModel?.albums[cellIndex] else { return }
        
        title = album.name
        name.text = album.name
        artist.text = album.artistName
        releaseDate.text = viewModel?.setReleaseDateText(album.releaseDate)
        copyright.text = album.copyright
        genres.text = nil //make sure if buildUI is somehow called multiple times that the genres don't get appended over again
        for genre in album.genres ?? [] {
            if genres.text == nil {
                genres.text = genre.name
            } else if let name = genre.name{
                genres.text?.append(", \(name)")
            }
        }
        if let artUrl = album.artworkUrl {
            //attempt to retrieve the image from the URL if not cached
            viewModel?.getImage(imageUrlString: artUrl, handler: { [weak self] image in
                DispatchQueue.main.async {
                    self?.art.image = image
                }
            })
        }
    }
    
    private func setupConstraints() {
        
        view.addSubview(art)
        view.addSubview(name)
        view.addSubview(artist)
        view.addSubview(releaseDate)
        view.addSubview(copyright)
        view.addSubview(genres)
        view.addSubview(storeLink)
        
        let constraints = [
            art.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            art.widthAnchor.constraint(equalToConstant: 300),
            art.heightAnchor.constraint(equalToConstant: 300),
            art.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.topAnchor.constraint(equalTo: art.bottomAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            artist.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            artist.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genres.topAnchor.constraint(equalTo: artist.bottomAnchor, constant: 5),
            genres.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            genres.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genres.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            releaseDate.topAnchor.constraint(equalTo: genres.bottomAnchor, constant: 5),
            releaseDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            copyright.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 5),
            copyright.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            copyright.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            copyright.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            storeLink.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            storeLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            storeLink.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            storeLink.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
