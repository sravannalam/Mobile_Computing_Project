//
//  SearchMoviesViewController.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/20/20.
//

import UIKit
import MBProgressHUD

class SearchMoviesViewController: UIViewController {

    @IBOutlet weak var movieType: UITextField!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieYear: UITextField!
    
    var type = ""
    var selectedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let vc = segue.destination as! SearchResultsViewController
            vc.isNormal = false
            vc._items = self.selectedMovies
        }else if segue.identifier == "type"{
            let vc = segue.destination as! PopupSelectionViewController
            vc.type = 2
            vc._del = self
        }
    }

    @IBAction func typeSelect(_ sender: Any) {
        self.performSegue(withIdentifier: "type", sender: nil)
    }
    
    @IBAction func search(_ sender: Any) {
        if let movieType = self.movieType.text, let movieTitle = self.movieTitle.text, let movieYear = self.movieYear.text{
            if movieType == "" && movieYear == "" && movieTitle == ""{
                self.showAlert(title: "Error", message: "Please provide at least one parameter (Either Movie title, year or type)") { (_) in }
            }else{
                var params = [String: String]()
                if movieType != ""{
                    params["type"] = movieType
                }
                if movieTitle == ""{
                    params["s"] = " "
                }else{
                    params["s"] = movieTitle
                }
                if movieYear != ""{
                    params["y"] = movieYear
                }
                MBProgressHUD.showAdded(to: self.view, animated: true)
                Networking.shared.searchMovies(params: params) { (error, movies) in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if let error = error{
                        self.showAlert(title: "Error", message: error) { (_) in }
                    }else if let movies  = movies{
                        self.selectedMovies = movies
                        self.performSegue(withIdentifier: "next", sender: nil)
                    }
                }
            }
        }
    }
    
}

extension SearchMoviesViewController{
    
    func fillData() {
        self.movieType.text = self.type
    }
    
}
