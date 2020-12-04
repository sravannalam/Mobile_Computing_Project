//
//  Networking.swift
//  IMDB App
//
//  Created by Kashif Rizwan on 11/25/20.
//

import Foundation
import Alamofire

class Networking{
    
    static var shared = Networking()
    
    func searchMovies(params: [String: String], completion: @escaping (_ error: String?, _ movies: [Movie]?) -> ()) {
        AF.request("http://www.omdbapi.com/?apikey=86c7af75", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in
            if let error = response.error{
                completion(error.localizedDescription, nil)
            }else{
                do{
                    let dict = try response.result.get() as! [String:Any]
                    let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let jsonOject = try JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed) as! [String: Any]
                    if let success = jsonOject["Response"] as? String{
                        if success == "False"{
                            completion((jsonOject["Error"] as! String), nil)
                        }else{
                            let arr = jsonOject["Search"] as! [[String: Any]]
                            var movies = [Movie]()
                            for i in arr{
                                movies.append(Movie(data: i))
                            }
                            completion(nil, movies)
                        }
                    }
                }catch{
                    completion(error.localizedDescription, nil)
                }
            }
        })
    }
    
}
