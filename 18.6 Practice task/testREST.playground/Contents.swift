import UIKit

//struct Service {
//
//    func loadImage(urlString: String) -> UIImage? {
//        guard
//            let url = URL(string: urlString),
//            let data = try? Data(contentsOf: url)
//        else {
//            print("Ошибка, не удалось загрузить изображение")
//            return nil
//        }
//
//        return UIImage(data: data)
//    }
//
//    func getImageURL(completion: @escaping (String?, Error?) -> Void) {
//        let url = URL(string: "https://dog.ceo/api/breeds/image/random")
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            guard let data = data else {
//                completion(nil, error)
//                return
//            }
//            let someDictionaryFromJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//            let imageUrl = someDictionaryFromJSON?["message"] as? String
//            completion(imageUrl, error)
//        }
//        task.resume()
//    }
//}
//
//
//func onLoad(counter: Int) {
//    service.getImageURL { urlString, error in
//        guard let urlString = urlString else { return }
//        let image = self.service.loadImage(urlString: urlString)
//        self.imageStore.append(image)
//    }
//}

struct SearchResult: Codable {
    var searchType: String
    var expression: String
    var results: [SingleResult]
    var errorMessage: String
}

struct SingleResult: Codable {
    var id: String
    var resultType: String
    var image: String
    var title: String
    var description: String
}

var url = URL(string: "https://imdb-api.com/API/Search/k_ngzy512q")
url!.append(path: "spider")

let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
    guard let data = data, let response = response else { return }
    let result = parseDecoder(data: data)
    print(result.expression)
    print("----------------------------------")
    if let response = response as? HTTPURLResponse {
        print(response.statusCode)
    }
}
task.resume()

func parseSerialization(data: Data) -> SearchResult {
    let dict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    
    let results = dict["results"] as! [[String: Any]]
    
    let object = SearchResult(
        searchType: dict["searchType"] as? String ?? "",
        expression: dict["expression"] as? String ?? "",
        results: Array(results.map{
            SingleResult(
                id: $0["id"] as? String ?? "",
                resultType: $0["resultType"] as? String ?? "",
                image: $0["image"] as? String ?? "",
                title: $0["title"] as? String ?? "",
                description: $0["description"] as? String ?? ""
            )}),
        errorMessage: dict["errorMessage"] as? String ?? ""
    )
    return object
}

func parseDecoder(data: Data) -> SearchResult {
    let decode = try! JSONDecoder().decode(SearchResult.self, from: data)
    return decode
}

