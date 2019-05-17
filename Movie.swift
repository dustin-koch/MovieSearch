//
//  Movie.swift
//  MovieSearch
//
//  Created by Dustin Koch on 5/17/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation


struct Movie: Decodable {
    
    let title: String
    let rating: Double
    let summary: String
    let votes: Int
    let posterPath: String
    
    
    enum CodingKeys: String, CodingKey{
        case title
        case rating = "vote_average"
        case summary = "overview"
        case votes = "vote_count"
        case posterPath = "poster_path"
        
    }
}

struct TopLevelMovieDictionary: Decodable {
    let results: [Movie]
}




