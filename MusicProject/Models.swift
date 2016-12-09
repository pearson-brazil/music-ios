//
//  Models.swift
//  MusicProject
//
//  Created by Pearson on 09/12/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import Foundation

/// MARK: Models para a cena Navegar

typealias JSONObject = [String:Any]

struct Browse {
    let releases: [Music]
    let top10: [Music]
    
    init(from json: JSONObject) {
        if let releasesArray = json["lancamentos"] as? [JSONObject] {
            releases = releasesArray.map { Music(from: $0) }
        }else{
            releases = [Music]()
        }
        if let top10Array = json["lancamentos"] as? [JSONObject] {
            top10 = top10Array.map { Music(from: $0) }
        }else{
            top10 = [Music]()
        }
    }
}

struct Music {
    let artistName: String?
    let imageURL: String?
    let mp3URL: String?
    let name: String?
    
    init(from json: JSONObject) {
        artistName = json["artista"] as? String
        imageURL = json["imagem"] as? String
        mp3URL = json["mp3"] as? String
        name = json["nome"] as? String
    }
}


