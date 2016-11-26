//
//  ArtistViewController.swift
//  MusicProject
//
//  Created by Pearson on 24/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {

    let items : [String] = ["Artista 1", "Artista 2", "Artista 3", "Artista 4", "Artista 5", "Artista 6", "Artista 7", "Artista 8", "Artista 9", "Artista 10", "Artista 11", "Artista 12", "Artista 13", "Artista 14"]
    

}

extension ArtistViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LISTA DE ARTISTAS"
    }
}
