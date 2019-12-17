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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupViews()
    }
    
    private func setupViews() {
        guard album != nil && self.isViewLoaded else { return }
        
        self.view.backgroundColor = .black
    }
    
    @objc private func navigateToItunes() {
        if let urlString = self.album?.url,
            let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:]) { (_) in}
        }
    }
}

import SwiftUI

struct DetailVCWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = AlbumDetailViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DetailVCWrapper>) -> AlbumDetailViewController {
        return AlbumDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: AlbumDetailViewController, context: UIViewControllerRepresentableContext<DetailVCWrapper>) {
        //Stub
    }
}

struct DetailViewPreviews: PreviewProvider {
    static var previews: some View {
        return DetailVCWrapper()
    }
}
