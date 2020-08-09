//
//  AlbumListViewController.swift
//  NikeTunes
//
//  Created by DMonaghan on 8/8/20.
//  Copyright © 2020 DMonaghan. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    var tableView = UITableView()
    let viewModel = AlbumListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        loadData()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        let album = viewModel.albums[indexPath.row]
        cell.name.text = album.name
        cell.artist.text = album.artistName
        viewModel.getImage(imageUrl: URL(string: album.artworkUrl), handler: { image in
            DispatchQueue.main.async {
                cell.art.image = image
            }
        })
        return cell
    }
}
