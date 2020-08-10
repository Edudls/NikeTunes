//
//  AlbumDetailViewController.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/9/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    let viewModel = AlbumDetailViewModel()
    
    let name = UILabel()
    let artist = UILabel()
    let art = UIImageView()
    let releaseDate = UILabel()
    let copyright = UILabel()
    let genres = UILabel()
    let storeLink = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    func buildUI() {
        view.backgroundColor = .white
        name.textColor = .black
        artist.textColor = .black
        releaseDate.textColor = .black
        copyright.textColor = .black
        genres.textColor = .black
        storeLink.setTitleColor(.systemBlue, for: .normal)
        edgesForExtendedLayout = []
        guard let album = viewModel.album else { return }
        
        title = album.name
        name.text = album.name
        artist.text = album.artistName
        releaseDate.text = "Released \(album.releaseDate ?? "on unknown date")"
        copyright.text = album.copyright
        storeLink.setTitle("Open in Apple Music", for: .normal)
        storeLink.addTarget(self, action: #selector(appleMusicButtonAction), for: .touchUpInside)
        for genre in album.genres ?? [] {
            if genres.text == nil {
                genres.text = genre.name
            } else if let name = genre.name{
                genres.text?.append(", \(name)")
            }
        }
        guard let artUrlString = album.artworkUrl?.replacingOccurrences(of: "200x200bb", with: "300x300bb") else { return }
        viewModel.getImage(imageUrl: URL(string: artUrlString), handler: { image in
            DispatchQueue.main.async { [weak self] in
                self?.art.image = image
            }
        })
    }
    
    @objc func appleMusicButtonAction() {
        guard let urlString = viewModel.album?.storeUrl, let url = URL(string: urlString) else {
            print("Invalid Apple Music URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func setupConstraints() {
        art.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        artist.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        copyright.translatesAutoresizingMaskIntoConstraints = false
        genres.translatesAutoresizingMaskIntoConstraints = false
        storeLink.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 0
        name.textAlignment = .center
        copyright.numberOfLines = 0
        copyright.textAlignment = .center
        copyright.font = copyright.font.withSize(10)
        genres.numberOfLines = 0
        genres.textAlignment = .center
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
