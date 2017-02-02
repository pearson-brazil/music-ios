//
//  MusicPlayer.swift
//  MusicProject
//
//  Created by Pearson on 04/01/17.
//  Copyright © 2017 Pearson. All rights reserved.
//
import Foundation
import AVFoundation
import FirebaseStorage

protocol MusicPlayerDelegate: class {
    func progressDidChange(currentTime: TimeInterval, duration: TimeInterval)
}

class MusicPlayer {
    static let shared = MusicPlayer()
    
    weak var delegate: MusicPlayerDelegate?
    
    var currentMusic: Music?
    var audioPlayer: AVAudioPlayer?
    var timer: Timer! = nil
    
    func downloadMusic(at url: String, completion: @escaping (URL) -> Void) {
        
        let httpsReference = FIRStorage.storage().reference(forURL: url)
        // Create local filesystem URL
        
        let tempDirUrl = URL(fileURLWithPath: NSTemporaryDirectory())
        
        let localURL: URL! = tempDirUrl.appendingPathComponent("current").appendingPathExtension(".mp3")
        
        _ = httpsReference.write(toFile: localURL) { (URL, error) -> Void in
            if (error != nil) {
                print("Download error: \(error!)")
            } else {
                completion(URL!)
            }
        }

    }
    
    func playMusic(music: Music) {
        currentMusic = music
        
        stopMusic()
        
        downloadMusic(at: music.mp3URL ?? "") { (localURL) in
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: localURL)
                self.audioPlayer?.prepareToPlay()
                self.audioPlayer?.play()
                self.startTimer()
            } catch {
                print("Audio error: \(error)")
            }
        }
        
    }
    
    func pauseMusic() {
        
        guard let player = audioPlayer else { return }
        
        if player.isPlaying {
            player.pause()
            timer.invalidate()
        }
    }
    
    func resumeMusic() {
        guard let player = audioPlayer else { return }
        
        if !player.isPlaying {
            player.play()
            startTimer()
        }
    }
    
    func stopMusic() {
        guard let player = audioPlayer else { return }
        if player.isPlaying {
            player.stop()
            currentMusic = nil
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            
            guard let player = self.audioPlayer else { return }
            
            self.delegate?.progressDidChange(currentTime: player.currentTime, duration: player.duration)
        }
    }
}
