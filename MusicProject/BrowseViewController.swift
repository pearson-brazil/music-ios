//
//  BrowseTableViewController.swift
//  MusicProject
//
//  Created by Pearson on 23/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Kingfisher

class BrowseViewController: UIViewController {

    var browseData : Browse?
    
    
    @IBOutlet weak var miniPlayerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicPlayingNameLabel: UILabel!
    @IBOutlet weak var musicPlayingArtistLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var progressBarViewTrailingConstraint: NSLayoutConstraint!
    
    let bottomSpaceWhenHidden : CGFloat = -70.0
    let bottomSpaceWhenShowing : CGFloat = 0.0
    
    var selectedMusic: Music? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = FIRDatabase.database().reference()
        
        self.tableView.isHidden = true
        ref.child("navegar").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? JSONObject
            self.browseData = Browse(from: value!)
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func showMiniPlayer(withMusic music: Music) {
        
        updateBars(currentTime: 0, duration: 0)
        
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
        MusicPlayer.shared.stopMusic()
    }
    
    func updateMiniPlayer(music: Music) {
        UIView.animate(withDuration: 0.15, animations: {
            self.musicPlayingNameLabel.alpha = 0
            self.musicPlayingArtistLabel.alpha = 0
        }, completion: { (finished) in
            if finished {
                self.musicPlayingNameLabel.text = music.name
                self.musicPlayingArtistLabel.text = music.artistName
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
        
        if sender.isSelected {
            MusicPlayer.shared.pauseMusic()
        }else {
            MusicPlayer.shared.resumeMusic()
        }
    }
    
    func updateBars(currentTime: TimeInterval, duration: TimeInterval) {
        
        UIView.animate(withDuration: 1) {
            self.progressBarViewTrailingConstraint.constant = (self.barView.bounds.width * CGFloat(duration - currentTime)) / CGFloat(duration == 0 ? 1 : duration )
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        hideMiniPlayer()
        MusicPlayer.shared.delegate = self
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return browseData?.releases.count ?? 0
        }
        return browseData?.top10.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath) as! BrowseTableViewCell
        
        if indexPath.section == 0 {
            cell.artistLabel?.text = browseData?.releases[indexPath.row].artistName ?? ""
            cell.musicNameLabel?.text = browseData?.releases[indexPath.row].name ?? ""
            
            let url = URL(string: (browseData?.releases[indexPath.row].imageURL)!)
            cell.musicImageView?.kf.setImage(with: url)
        }else{
            cell.artistLabel?.text = browseData?.top10[indexPath.row].artistName ?? ""
            cell.musicNameLabel?.text = browseData?.top10[indexPath.row].name ?? ""
            
            let url = URL(string: (browseData?.top10[indexPath.row].imageURL)!)
            cell.musicImageView?.kf.setImage(with: url)
        }
        
        


        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "LANÇAMENTOS"
        }
        return "TOP 10"
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            showMiniPlayer(withMusic: (browseData?.releases[indexPath.row])!)
            MusicPlayer.shared.playMusic(music: (browseData?.releases[indexPath.row])!)
        }else{
            showMiniPlayer(withMusic: (browseData?.top10[indexPath.row])!)
            MusicPlayer.shared.playMusic(music: (browseData?.top10[indexPath.row])!)
        }
    }

}

extension BrowseViewController: MusicPlayerDelegate {
    func progressDidChange(currentTime: TimeInterval, duration: TimeInterval) {
        updateBars(currentTime: currentTime, duration: duration)
        
        if currentTime == duration {
            hideMiniPlayer()
        }
    }
}
