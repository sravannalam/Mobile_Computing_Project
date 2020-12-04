//
//  BrowseMoviesViewController.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/20/20.
//

import UIKit

class BrowseMoviesViewController: UIViewController {
    
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    
    private var movies = [Movie]()
    private var selectedMovies = [Movie]()
    
    var year = ""
    var genre = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }
    
    private func getData(){
        if let path = Bundle.main.path(forResource: "Movies", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let movies = jsonResult as? [[String: String]]{
                    for i in movies{
                        self.movies.append(Movie(data: i))
                    }
                }
            } catch {
                self.showAlert(title: "Error", message: error.localizedDescription) { (_) in }
            }
        }
    }
    
    func fillData() {
        self.yearField.text = self.year
        self.genreField.text = self.genre
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as! SearchResultsViewController
            vc.isNormal = true
            vc.items = self.selectedMovies
        }else if segue.identifier == "year"{
            let vc = segue.destination as! PopupSelectionViewController
            vc.type = 1
            vc.del = self
        }else if segue.identifier == "genre"{
            let vc = segue.destination as! PopupSelectionViewController
            vc.del = self
        }
    }

    @IBAction func search(_ sender: Any) {
        if let year = self.yearField.text, let genre = self.genreField.text{
            if year != "" && genre != ""{
                self.selectedMovies = self.movies.filter({$0.moviegenre == self.genre.lowercased() && $0.movieyear == self.year})
                self.performSegue(withIdentifier: "next", sender: nil)
            }else{
                self.showAlert(title: "Error", message: "Please provide all fields") { (_) in }
            }
        }
    }
    
    @IBAction func year(_ sender: Any) {
        self.performSegue(withIdentifier: "year", sender: nil)
    }
    
    @IBAction func genre(_ sender: Any) {
        self.performSegue(withIdentifier: "genre", sender: nil)
    }
    
    
}
