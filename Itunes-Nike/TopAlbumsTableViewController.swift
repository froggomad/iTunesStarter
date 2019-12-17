//
//  TopAlbumsTableViewController.swift
//  Itunes-Nike
//
//  Created by Johnny Hicks on 8/9/19.
//  Copyright © 2019 Swiftly, LLC. All rights reserved.
//

import UIKit

class TopAlbumsTableViewController: UITableViewController {

    private let networkController = NetworkController()
    private var albums: [Album] = []
    let imageLoadingQueue = DispatchQueue(label: "FetchPhotos")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Top 100 Albums", comment: "Title for Root View Controller")
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        self.fetchAlbums()
    }
    
    private func fetchAlbums() {
        networkController.fetchItunesData { (feed) in
            if let feed = feed {
                self.albums = feed.feed.results
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let album = self.albums[indexPath.row]
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artistName
        cell.imageView?.image = UIImage(named: "artwork.cover")
        imageLoadingQueue.async {
            if let albumURL = URL(string:album.artworkUrl100) {
                self.networkController.fetchAlbumArt(for: albumURL) { (image) in
                    
                    DispatchQueue.main.async {
                        if let image = image {
                            cell.imageView?.image = image
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let album = self.albums[indexPath.row]
        let vc = AlbumDetailViewController()
        vc.album = album
        vc.albumArtImage = cell?.imageView?.image
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


