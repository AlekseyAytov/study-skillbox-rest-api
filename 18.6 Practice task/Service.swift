//
//  Service.swift
//  18.6 Practice task
//
//  Created by Alex Aytov on 4/26/23.
//

import UIKit

class Service {
    
    private var url = URL(string: "https://imdb-api.com/API/Search/k_ngzy512q")!

    func loadImage(urlString: String) -> UIImage? {
        guard
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url)
        else {
            print("Ошибка, не удалось загрузить изображение")
            return nil
        }

        return UIImage(data: data)
    }
    
    func loadImageAsync(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            guard let contentOfURL = try? Data(contentsOf: url) else {
                print("Ошибка, не удалось загрузить изображение")
                return
            }
            completion(contentOfURL)
        }
    }

    func getSearchResults(searchExpression: String?, completion: @escaping (Data?, Error?) -> Void) {
        guard let searchExpression = searchExpression else { return }
        url.append(path: searchExpression)
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
    
    func parseDecoder(data: Data) -> SearchResults {
        let decode = try! JSONDecoder().decode(SearchResults.self, from: data)
        return decode
    }
}
