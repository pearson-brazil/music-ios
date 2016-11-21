//
//  ViewController.swift
//  MusicProject
//
//  Created by Pearson on 05/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {
    
    // 👇 Coloque os @IBOutlets abaixo 👇

    
    // Variáveis e constantes
    let musicDuration : TimeInterval = 180.0
    var remaingTime : TimeInterval = 180.0
    var totalPlayed : TimeInterval = 0.0
    
    var timer: Timer! = nil
    
    func resumeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    func pauseTimer() {
        timer.invalidate()
    }

    func updateTime() {
        
        if remaingTime == 0.0 {
            
            // Invalida o timer
            timer.invalidate()
            
            // Restaura os valores padrões das variáveis
            totalPlayed = 0.0
            remaingTime = musicDuration
            
            // Faça o botão voltar para a imagem #imageLiteral(resourceName: "ic_play") aqui 👇
            
        }else{
            // Diminui o tempo das variáveis
            remaingTime -= 1
            totalPlayed += 1
        }
        
        updateLabels()
    }
    
    func updateLabels() {
        
        // Define o formato da exibição da data. No caso minuto e segundo
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        
        // Converte os TimeIntervals em Date e em seguinda em String
        let remainingTimeString = formatter.string(from: Date(timeIntervalSinceReferenceDate: remaingTime))
        let totalPlayedString = formatter.string(from: Date(timeIntervalSinceReferenceDate: totalPlayed))
        
        // 👇 Atualize as labels aqui 👇

        
    }
    
    // 👇 Coloque os @IBActions abaixo 👇

}

