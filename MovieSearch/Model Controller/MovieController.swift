//
//  MovieController.swift
//  MovieSearch
//
//  Created by Dustin Koch on 5/17/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    //Singleton created for testing
    static let shared = MovieController()
    
    //MARK: - Properties
    var movieResults: [Movie] = []
    let baseMovieURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    let baseImageURL = URL(string: "http://image.tmdb.org/t/p/w500")
    let apiKey = "5ea295b9c220e17b10a8f5d6c5b866cb"
    
    //MARK:- CRUD functions
    //https://api.themoviedb.org/3/search/movie?api_key=5ea295b9c220e17b10a8f5d6c5b866cb&query=friday
    func fetchMoviewith(title: String, completion: @escaping ([Movie]?) -> Void ) {
        //Constructing proper URL
        guard let movieURL = baseMovieURL else { return }
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let movieQueryItem = URLQueryItem(name: "query", value: title)
        components?.queryItems = [apiKeyQueryItem, movieQueryItem]
        guard let finalURL = components?.url else { return }
        //Datatask on constructed URL
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error 🍎 \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let movies = try jsonDecoder.decode(TopLevelMovieDictionary.self, from: data).results
                self.movieResults = movies
                completion(movies)
            } catch {
                print("Error 🍏 \(error.localizedDescription)")
                return
            }
        }.resume()
        
        
    }//End of movie fetch
    //http://image.tmdb.org/t/p/w500/z76scMklBnEC91CFqHcvqrS5coO.jpg
    func fetchMoviePosterFrom(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        
    }//End of image fetch
    
    
    
}//END OF CLASS


//guard let baseURL = URL(string: "https://api.thecatapi.com/v1/images/search") else {return}
//let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "93fd4773-e79f-48ef-bf61-64e804d40c12")
//var component = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//component?.queryItems = [apiKeyQueryItem]
//guard let finalURL = component?.url else {return}
//print(finalURL)
//
//URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
//    if let error = error {
//        print("We lost your Kitty: \(error.localizedDescription)")
//    }
//    guard let data = data else {return}
//    do{
//        let arrayCat = try JSONDecoder().decode([Cat].self, from: data)
//        completion(arrayCat[0])
//    }catch{
//        print(error.localizedDescription)
//        completion(nil)
//        return
//    }
//    }.resume()
