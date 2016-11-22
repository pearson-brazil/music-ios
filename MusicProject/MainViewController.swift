//
//  MainViewController.swift
//  MusicProject
//
//  Created by Pearson on 22/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 1, green: 0.2842617035, blue: 0.4058894515, alpha: 1)
        ((tabBar.items?[0])! as UITabBarItem).image = #imageLiteral(resourceName: "ic_search").withRenderingMode(.alwaysOriginal)
        ((tabBar.items?[1])! as UITabBarItem).image = #imageLiteral(resourceName: "ic_artist").withRenderingMode(.alwaysOriginal)
        ((tabBar.items?[2])! as UITabBarItem).image = #imageLiteral(resourceName: "ic_music").withRenderingMode(.alwaysOriginal)
        
        ((tabBar.items?[0])! as UITabBarItem).selectedImage = #imageLiteral(resourceName: "ic_search_selected").withRenderingMode(.alwaysOriginal)
        ((tabBar.items?[1])! as UITabBarItem).selectedImage = #imageLiteral(resourceName: "ic_artist_selected").withRenderingMode(.alwaysOriginal)
        ((tabBar.items?[2])! as UITabBarItem).selectedImage = #imageLiteral(resourceName: "ic_music_selected").withRenderingMode(.alwaysOriginal)
        
    }
    
}

