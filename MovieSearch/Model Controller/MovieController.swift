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
    let baseImagePath = URL(string: "https://image.tmdb.org/t/p/w500")
    let apiKey = "5ea295b9c220e17b10a8f5d6c5b866cb"
    
    //MARK:- CRUD functions
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
        //Construct image url for fetch
        guard var posterUrl = baseImagePath else { return }
        posterUrl.appendPathComponent(movie.posterPath)
        //Datatask to get image from constructed URL
        URLSession.shared.dataTask(with: posterUrl) { (data, _, error) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }//End of image fetch
    
}//END OF CLASS
