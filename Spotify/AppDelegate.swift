//
//  AppDelegate.swift
//  Spotify
//
//  Created by Murat Ceyhun Korpeoglu on 17.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .spotifyBlack
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController(rootViewController: TitleBarController())
        window?.rootViewController = navigationController
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .spotifyBlack
        
        return true
    }
    
    
}

