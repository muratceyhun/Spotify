//
//  HomeViewController.swift
//  Spotify
//
//  Created by Murat Ceyhun Korpeoglu on 18.03.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let menuBar = MenuBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .spotifyBlack
        
        layout()
    }
    
    func layout() {
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
}
