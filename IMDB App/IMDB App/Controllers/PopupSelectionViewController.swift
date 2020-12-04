//
//  PopupSelectionViewController.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/20/20.
//

import UIKit

class PopupSelectionViewController: UIViewController {
    @IBOutlet weak var tablv: UITableView!
    
    var type = 0
    var del: BrowseMoviesViewController!
    var _del: SearchMoviesViewController!
    
    private var genre = [String]()
    private var year = ["2019", "2020"]
    private var contentType = ["Movie", "Series", "Episode"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(close))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        self.tablv.delegate = self
        self.tablv.dataSource = self
        self.tablv.reloadData()
        self.tablv.layer.cornerRadius = 8
        self.getData()
    }
    
    private func getData(){
        if let path = Bundle.main.path(forResource: "Movie_Genre", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let genre = jsonResult as? [[String: String]]{
                    for i in genre{
                        self.genre.append(i["movieGenre"] ?? "")
                    }
                    self.tablv.reloadData()
                }
            } catch {
                self.showAlert(title: "Error", message: error.localizedDescription) { (_) in }
            }
        }
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }

}

extension PopupSelectionViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == 0{
            return self.genre.count
        }else if type == 1{
            return self.year.count
        }else {
            return self.contentType.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellTableViewCell
            cell.name.text = self.genre[indexPath.row]
            return cell
        }else if type == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellTableViewCell
            cell.name.text = self.year[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellTableViewCell
            cell.name.text = self.contentType[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true) { [self] in
            if type == 0{
                self.del.genre = self.genre[indexPath.row]
                self.del.fillData()
            }else if type == 1{
                self.del.year = self.year[indexPath.row]
                self.del.fillData()
            }else{
                self._del.type = self.contentType[indexPath.row]
                self._del.fillData()
            }
        }
    }
    
}
