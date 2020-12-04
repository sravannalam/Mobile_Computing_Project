//
//  Movie.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/25/20.
//

import Foundation

struct Movie {
    var title: String
    var movieyear: String
    var poster: String
    var imdblink: String
    var moviegenre: String
    
    init(data: [String: String]){
        self.title = data["title"] ?? ""
        self.movieyear = data["movieyear"] ?? ""
        self.poster = data["poster"] ?? ""
        self.imdblink = data["imdblink"] ?? ""
        self.moviegenre = data["moviegenre"] ?? ""
    }
    
    init(data: [String: Any]){
        self.title = data["Title"] as! String
        self.movieyear = data["Year"] as! String
        self.poster = data["Poster"] as! String
        self.imdblink = data["imdbID"] as! String
        self.moviegenre = ""
    }
}
