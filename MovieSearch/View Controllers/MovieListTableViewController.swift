//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Dustin Koch on 5/17/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var movies: [Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "🎥 Movie Results 🎥"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        //Setting text
        cell.titleLabel.text = movie.title
        cell.ratingLabel.text = "Rating: \(movie.rating) with \(movie.votes) votes"
        cell.summaryLabel.text = movie.summary
        //Setting image
        MovieController.shared.fetchMoviePosterFrom(movie: movie) { (image) in
            DispatchQueue.main.async {
                cell.moviePosterImageView.image = image
            }
        }

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}//END OF CLASS

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MovieController.shared.fetchMoviewith(title: searchText) { (movies) in
            guard let movies = movies else { return }
            self.movies = movies
        }
    }
}//End of search delegate extenstion
