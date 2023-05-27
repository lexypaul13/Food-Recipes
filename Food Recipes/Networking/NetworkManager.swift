//
//  NetworkManager.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/23/23.
//

import Foundation

enum EndPoints {
    case mealList(category: String)
    case mealDetails(mealID: String)
    
    var url: String {
        switch self {
        case .mealList(let category):
            return "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        case .mealDetails(let mealID):
            return "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        }
    }
}

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL."
    case noData = "No data received from server."
}

protocol Networking {
    func fetch<T: Decodable>(endpoint: EndPoints, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager: Networking {
    let jsonDecoder: JSONDecoder
    
    init() {
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetch<T: Decodable>(endpoint: EndPoints, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: endpoint.url) else {
            print("Error: \(NetworkError.invalidURL.localizedDescription)")
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let _ = error {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let data = data else {
                print("Error: \(NetworkError.noData.localizedDescription)")
                return
            }
            do {
                guard let self = self else { return }
                let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decodedResponse)) }
            } catch let decodingError {
                print("Decoding error: \(decodingError)")
            }
        }.resume()
    }

}
