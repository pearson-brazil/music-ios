//
//  BrowseTableViewController.swift
//  MusicProject
//
//  Created by Pearson on 23/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit

struct Music {
    let name: String
    let artist: String
}

struct Section {
    let name: String
    let musics: [Music]
}

class BrowseTableViewController: UITableViewController {

    
    let items : [Section] = [
        Section(name: "LANÇAMENTOS", musics: [
            Music(name: "Musica 1", artist: "Artista 1"),
            Music(name: "Musica 2", artist: "Artista 2"),
            Music(name: "Musica 3", artist: "Artista 3"),
            Music(name: "Musica 4", artist: "Artista 4")
            ]),
        Section(name: "TOP 10", musics: [
            Music(name: "Musica 5", artist: "Artista 5"),
            Music(name: "Musica 6", artist: "Artista 6"),
            Music(name: "Musica 7", artist: "Artista 7"),
            Music(name: "Musica 8", artist: "Artista 8"),
            Music(name: "Musica 9", artist: "Artista 9")
            ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].musics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.section].musics[indexPath.row].artist
        cell.detailTextLabel?.text = items[indexPath.section].musics[indexPath.row].name

        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].name
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MusicViewControllerIdentifier", sender: self)
    }

}
