//
//  SearchResultsViewController.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/20/20.
//

import UIKit
import SDWebImage

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var SearchResultsCollectionVIew: UICollectionView!
    
    var isNormal = false
    
    var items = [Movie]()
    var _items = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup(){
        self.SearchResultsCollectionVIew.delegate = self
        self.SearchResultsCollectionVIew.dataSource = self
        self.SearchResultsCollectionVIew.reloadData()
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchResultsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isNormal{
            return items.count
        }else{
            return _items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isNormal{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.name.text = self.items[indexPath.row].title
            cell.moviePosterImage.image = UIImage(named: self.items[indexPath.row].poster)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieWithIMDBCollectionViewCell", for: indexPath) as! MovieWithIMDBCollectionViewCell
            cell.name.text = self._items[indexPath.row].title
            cell.year.text = self._items[indexPath.row].movieyear
            cell.moviePosterImage.sd_setImage(with: URL(string: self._items[indexPath.row].poster), completed: nil)
            cell.IMDBLink.tag = indexPath.row
            cell.IMDBLink.addTarget(self, action: #selector(openIMDB(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if self.isNormal{
            guard let url = URL(string: self.items[indexPath.row].imdblink) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func openIMDB(sender: UIButton){
        guard let url = URL(string: "https://www.imdb.com/title/"+self._items[sender.tag].imdblink) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isNormal{
            return CGSize(width: (self.view.bounds.width/2), height: self.view.bounds.width/1.4)
        }else{
            return CGSize(width: (self.view.bounds.width/2), height: (self.view.bounds.width/1.4)+29+17)
        }
    }
    
    
}
