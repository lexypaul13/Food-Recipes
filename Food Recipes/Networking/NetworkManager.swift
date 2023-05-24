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
    case decodingFailed = "Data decoding failed."
}


protocol Networking {
    func fetch<T: Decodable>(endpoint: EndPoints, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager:Networking {
    static let shared = NetworkManager()
    private let jsonDecoder: JSONDecoder
    
    private init() {
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    
    func fetch<T: Decodable>(endpoint: EndPoints, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: endpoint.url) else {
            DispatchQueue.main.async { completion(.failure(.invalidURL)) }
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async { completion(.failure(.noData)) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(.noData)) }
                return
            }
            do {
                let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decodedResponse)) }
            } catch let decodingError {
                print("Decoding error: \(decodingError)")
                DispatchQueue.main.async { completion(.failure(.decodingFailed)) }
            }
        }.resume()
    }
    
}
