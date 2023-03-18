//
//  MenuBar.swift
//  Spotify
//
//  Created by Murat Ceyhun Korpeoglu on 18.03.2023.
//

import UIKit


class MenuBar: UIView {
    
    let playlistButton: UIButton!
    let artistsButton: UIButton!
    let albumsButton: UIButton!
    var buttons: [UIButton]!
    
    override init(frame: CGRect) {
        playlistButton = makeButton(withText: "Playlist")
        artistsButton  = makeButton(withText: "Artists")
        albumsButton   = makeButton(withText: "Albums")
        
        buttons = [playlistButton, artistsButton, albumsButton]
        super.init(frame: .zero)
        
        playlistButton.addTarget(self, action: #selector(playlistsButtonClicked), for: .primaryActionTriggered)
        artistsButton.addTarget(self, action: #selector(artistsButtonClicked), for: .primaryActionTriggered)
        albumsButton.addTarget(self, action: #selector(albumsButtonClicked), for: .primaryActionTriggered)
        
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(playlistButton)
        addSubview(artistsButton)
        addSubview(albumsButton)
        
        NSLayoutConstraint.activate([
            playlistButton.topAnchor.constraint(equalTo: topAnchor),
            playlistButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistsButton.topAnchor.constraint(equalTo: topAnchor),
            artistsButton.leadingAnchor.constraint(equalTo: playlistButton.trailingAnchor, constant: 36),
            albumsButton.topAnchor.constraint(equalTo: topAnchor),
            albumsButton.leadingAnchor.constraint(equalTo: artistsButton.trailingAnchor, constant: 36)
        ])
    }
}

extension MenuBar {
    @objc func playlistsButtonClicked() {
        
    }
    @objc func artistsButtonClicked() {
        
    }
    @objc func albumsButtonClicked() {
        
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    
    return button
}
