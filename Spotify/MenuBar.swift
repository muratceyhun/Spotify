//
//  MenuBar.swift
//  Spotify
//
//  Created by Murat Ceyhun Korpeoglu on 18.03.2023.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func didSelectItemAt(index: Int)
}

class MenuBar: UIView {
    
    let playlistButton: UIButton!
    let artistsButton: UIButton!
    let albumsButton: UIButton!
    var buttons: [UIButton]!
    
    let indicator = UIView()
    
    var indicatorLeading: NSLayoutConstraint?
    var indicatorTrailing: NSLayoutConstraint?
    
    weak var delegate: MenuBarDelegate?
    
    let leadPadding: CGFloat = 16
    let buttonSpace: CGFloat = 36
    
    override init(frame: CGRect) {
        playlistButton = makeButton(withText: "Playlist")
        artistsButton  = makeButton(withText: "Artists")
        albumsButton   = makeButton(withText: "Albums")
        
        buttons = [playlistButton, artistsButton, albumsButton]
        super.init(frame: .zero)
        
        playlistButton.addTarget(self, action: #selector(playlistsButtonClicked), for: .primaryActionTriggered)
        artistsButton.addTarget(self, action: #selector(artistsButtonClicked), for: .primaryActionTriggered)
        albumsButton.addTarget(self, action: #selector(albumsButtonClicked), for: .primaryActionTriggered)
        
        styleIndicator()
        setAlpha(for: playlistButton)
        layout()
        
    }
    
    private func styleIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .spotifyGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(playlistButton)
        addSubview(artistsButton)
        addSubview(albumsButton)
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            
            // Buttons
            
            playlistButton.topAnchor.constraint(equalTo: topAnchor),
            playlistButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadPadding),
            artistsButton.topAnchor.constraint(equalTo: topAnchor),
            artistsButton.leadingAnchor.constraint(equalTo: playlistButton.trailingAnchor, constant: buttonSpace),
            albumsButton.topAnchor.constraint(equalTo: topAnchor),
            albumsButton.leadingAnchor.constraint(equalTo: artistsButton.trailingAnchor, constant: buttonSpace),
            
            // bar
            
            indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        indicatorLeading = indicator.leadingAnchor.constraint(equalTo: playlistButton.leadingAnchor)
        indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: playlistButton.trailingAnchor)
        
        indicatorLeading?.isActive = true
        indicatorTrailing?.isActive = true
    }
}

extension MenuBar {
    
    @objc func playlistsButtonClicked() {
        delegate?.didSelectItemAt(index: 0)
    }
    
    @objc func artistsButtonClicked() {
        delegate?.didSelectItemAt(index: 1)
    }
    
    @objc func albumsButtonClicked() {
        delegate?.didSelectItemAt(index: 2)
    }
    
}

extension MenuBar {
    func selectItem(at index: Int) {
        animatedIndicator(to: index)
    }
    
    private func animatedIndicator(to index: Int) {
        var button: UIButton
        switch index {
        case 0:
            button = playlistButton
        case 1:
            button = artistsButton
        case 2:
            button = albumsButton
        default:
            button = playlistButton
        }
        
        setAlpha(for: button)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setAlpha(for button: UIButton) {
        playlistButton.alpha = 0.5
        artistsButton.alpha = 0.5
        albumsButton.alpha = 0.5
        
        button.alpha = 1.0
    }
    
    func scrollIndicator(to contentOffset: CGPoint) {
        let index = Int(contentOffset.x / frame.width)
        let atScrollStart = Int(contentOffset.x) % Int(frame.width) == 0
        
        if atScrollStart {
            return
        }
        
        // determine percent scrolled relative to index
        let percentScrolled: CGFloat
        switch index {
        case 0:
            percentScrolled = contentOffset.x / frame.width - 0
        case 1:
            percentScrolled = contentOffset.x / frame.width - 1
        case 2:
            percentScrolled = contentOffset.x / frame.width - 2
        default:
            percentScrolled = contentOffset.x / frame.width

        }
        
        // determine buttons
        var fromButton: UIButton
        var toButton: UIButton
        
        switch index {
        case 2:
            fromButton = buttons[index]
            toButton = buttons[index - 1]
            
        default:
            fromButton = buttons[index]
            toButton = buttons[index + 1]
        }
        
        //animate alpha of buttons
        switch index {
        case 2:
            break
        default:
            fromButton.alpha = fmax(0.5, (1 - percentScrolled))
            toButton.alpha = fmax(0.5, percentScrolled)
        }
        
        let fromWidth = fromButton.frame.width
        let toWidth = toButton.frame.width
        
        //determine width
        let sectionWidth: CGFloat
        switch index {
        case 0:
            sectionWidth = leadPadding + fromWidth + buttonSpace
        default:
            sectionWidth = fromWidth + buttonSpace
        }
        
        // normalize x scroll
        let sectionFraction = sectionWidth / frame.width
        let x = contentOffset.x * sectionFraction
        
        let buttonWithDiff = fromWidth - toWidth
        let widthOffset = buttonWithDiff * percentScrolled
        
        // determine leading y
        let y: CGFloat
        switch index {
        case 0:
            if x < leadPadding {
                y = x
            } else {
                y = x - leadPadding * percentScrolled
            }
        case 1:
            y = x + 13
        default:
            y = x
        }
        
        indicatorLeading?.constant = y
        
        // determine trailing y
        let yTrailing: CGFloat
        switch index {
        case 0:
            yTrailing = y - widthOffset
        case 1:
            yTrailing = y - widthOffset - leadPadding
        case 2:
            yTrailing = y - widthOffset - leadPadding / 2
        default:
            yTrailing = y - widthOffset - leadPadding
        }
        
        indicatorTrailing?.constant = yTrailing
        
        
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
