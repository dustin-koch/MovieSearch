//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Dustin Koch on 5/17/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    //Landing pad
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    //Helper functions
    func updateView() {
        guard let movie = self.movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = (movie.rating == 0) ? "Movie not rated" : "Rating: \(movie.rating) with \(movie.votes) votes"
        summaryLabel.text = (movie.summary == "") ? "No summary available" : movie.summary
        MovieController.shared.fetchMoviePosterFrom(movie: movie) { (image) in
            DispatchQueue.main.async {
                self.moviePosterImageView.image = image
                if self.moviePosterImageView.image == nil {
                    self.moviePosterImageView.image = UIImage(named: "noimage")
                }
            }
        }
        
        
        
        
    }
    
    
}
