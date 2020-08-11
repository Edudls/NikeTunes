//
//  AlbumListViewController.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/8/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    let viewModel = AlbumListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Constaints
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNavigationBar() {
        self.title = "Hot Albums"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(loadData))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.leftButtonText,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(toggleExplicit))
    }
    
    @objc func loadData() {
        viewModel.getData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func toggleExplicit() {
        viewModel.shouldShowExplicit = !viewModel.shouldShowExplicit
        setupNavigationBar()
        loadData()
    }
}

extension AlbumListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        let album = viewModel.albums[indexPath.row]
        cell.name.text = album.name
        cell.artist.text = album.artistName
        if let artUrl = album.artworkUrl {
            viewModel.getImage(imageUrlString: artUrl, handler: { image in
                DispatchQueue.main.async {
                    cell.art.image = image
                }
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumDetailViewController()
        let album = viewModel.albums[indexPath.row]
        vc.album = album
        //cleaner to set the image here since I can easily access the getImage method from this VC if I need to
        if let artUrl = album.artworkUrl {
            //attempt to retrieve the image from the URL if not cached
            viewModel.getImage(imageUrlString: artUrl, handler: { image in
                DispatchQueue.main.async {
                    vc.art.image = image
                }
            })
        }
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
