//
//  AlbumDetailViewController.swift
//  Itunes-Nike
//
//  Created by Johnny Hicks on 8/9/19.
//  Copyright © 2019 Swiftly, LLC. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    var album: Album?
    var albumArtImage: UIImage?
    
    // MARK: - Views
    private var albumImageView: UIImageView?
    private var metadataLabel: UILabel?
    private var albumLabel: UILabel?
    private var artistLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard album != nil && self.isViewLoaded else { return }
        self.view.backgroundColor = .white
        self.setupViews()
    }
    
    private func setupViews() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = self.albumArtImage

        self.view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        let metadataLabel = UILabel()
        metadataLabel.translatesAutoresizingMaskIntoConstraints = false
        let genres = album?.genres.compactMap({ (genre) -> String in
            return genre.name
        })
        let genresString = genres?.joined(separator: ", ")
        let copyrightString = album?.copyright
        let releaseDataString = album?.releaseDate
        
        let combinedString = "\(genresString!). Released:\(releaseDataString!). \(copyrightString!)"
        metadataLabel.text = combinedString
        metadataLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        metadataLabel.numberOfLines = 0
        
        self.view.addSubview(metadataLabel)
        
        metadataLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2).isActive = true
        metadataLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8).isActive = true
        metadataLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8).isActive = true

        let albumLabel = UILabel()
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.text = self.album?.name
        albumLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        albumLabel.numberOfLines = 0
        albumLabel.textAlignment = .center
        self.view.addSubview(albumLabel)

        albumLabel.topAnchor.constraint(equalTo: metadataLabel.bottomAnchor, constant: 16).isActive = true
        albumLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8).isActive = true
        albumLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8).isActive = true

        let artistLabel = UILabel()
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.text = self.album?.artistName
        artistLabel.font = UIFont.systemFont(ofSize: 24)
        artistLabel.textColor = UIColor.red
        artistLabel.numberOfLines = 0
        artistLabel.textAlignment = .center
        self.view.addSubview(artistLabel)

        artistLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant:8).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8).isActive = true
        
        
        let iTunesButton = UIButton()
        iTunesButton.translatesAutoresizingMaskIntoConstraints = false
        iTunesButton.setTitle("View in Apple Music", for: .normal)
        iTunesButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        iTunesButton.setTitleColor(.white, for: .normal)
        iTunesButton.backgroundColor = .red
        iTunesButton.layer.cornerRadius = 12
        
        self.view.addSubview(iTunesButton)
        
        iTunesButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        iTunesButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        iTunesButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        iTunesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        iTunesButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        iTunesButton.addTarget(self, action: #selector(navigateToItunes), for: .touchDown)
    }
    
    @objc private func navigateToItunes() {
        UIApplication.shared.open(URL(string: album!.url)!, options: [:]) { (_) in
            
        }
    }
}
