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

class BrowseViewController: UIViewController {

    
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
    
    
    @IBOutlet weak var miniPlayerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicPlayingNameLabel: UILabel!
    @IBOutlet weak var musicPlayingArtistLabel: UILabel!
    
    let bottomSpaceWhenHidden : CGFloat = -70.0
    let bottomSpaceWhenShowing : CGFloat = 0.0
    
    var selectedMusic: Music? = nil
    
    func showMiniPlayer(withMusic music: Music) {
        
        let hideAnimation = {
            self.miniPlayerBottomConstraint.constant = self.bottomSpaceWhenHidden
            self.view.layoutIfNeeded()
        }
        
        let showAnimmation = {
            self.miniPlayerBottomConstraint.constant = self.bottomSpaceWhenShowing
            self.view.layoutIfNeeded()
        }
        
        if let selectedMusic = selectedMusic {
            
            if selectedMusic.name == music.name {
                UIView.animate(withDuration: 0.3, animations: hideAnimation)
                self.selectedMusic = nil
            } else {
                updateMiniPlayer(music: music)
            }
        } else {
            
            // Se não houver musica selecionada ainda, mostra o mini player
            self.musicPlayingNameLabel.text = ""
            self.musicPlayingArtistLabel.text = ""
            
            UIView.animate(withDuration: 0.3, animations: showAnimmation)
            updateMiniPlayer(music: music)
        }
        
        
    }
    
    func hideMiniPlayer() {
        miniPlayerBottomConstraint.constant = self.bottomSpaceWhenHidden
        view.layoutIfNeeded()
    }
    
    func updateMiniPlayer(music: Music) {
        UIView.animate(withDuration: 0.15, animations: {
            self.musicPlayingNameLabel.alpha = 0
            self.musicPlayingArtistLabel.alpha = 0
        }, completion: { (finished) in
            if finished {
                self.musicPlayingNameLabel.text = music.name
                self.musicPlayingArtistLabel.text = music.artist
                self.selectedMusic = music
                
                UIView.animate(withDuration: 0.15) {
                    self.musicPlayingNameLabel.alpha = 1
                    self.musicPlayingArtistLabel.alpha = 1
                }
            }
        })
        
        
    }
    
    @IBAction func pauseButtonTouchUpInside(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func viewDidLoad() {
        hideMiniPlayer()
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].musics.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.section].musics[indexPath.row].artist
        cell.detailTextLabel?.text = items[indexPath.section].musics[indexPath.row].name

        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].name
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMiniPlayer(withMusic: items[indexPath.section].musics[indexPath.row])
    }

}
