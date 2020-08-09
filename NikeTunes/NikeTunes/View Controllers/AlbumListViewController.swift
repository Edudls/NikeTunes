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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hot Albums"
        self.setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func getData() {
        guard let url = AlbumConstants.albumsUrl else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
        }
        task.resume()
    }
}

extension AlbumListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        cell.name.text = "Album title"
        cell.artist.text = "Artist"
        return cell
    }
}
