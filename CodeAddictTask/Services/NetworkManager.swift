//
//  NetworkManager.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import UIKit

final class NetworkManager {
    
    private let baseURL = "https://api.github.com/"
    private let cache = NSCache<NSString, UIImage>()
    
    func searchRepositories(withWord: String, page: Int, completion: @escaping (Result<RepositoriesResponse, CustomErrors>) -> Void) {
        let endpointURL = "search/repositories?q=\(withWord)&page=\(page)"
        guard let url = URL(string: baseURL + endpointURL) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            print("MY RESPONSE: \(response)")
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let repositories = try decoder.decode(RepositoriesResponse.self, from: data)
                completion(.success(repositories))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getRepositories(forOwner: String, repoName: String, completion: @escaping (Result<DetailRepositories, CustomErrors>) -> Void) {
        let endpointURL = "repos/\(forOwner)/\(repoName)"
        guard let url = URL(string: baseURL + endpointURL) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let detailRepositories = try decoder.decode(DetailRepositories.self, from: data)
                completion(.success(detailRepositories))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getListCommits(forOwner: String, repoName: String, completion: @escaping (Result<ListCommits, CustomErrors>) -> Void) {
        let endpointURL = "repos/\(forOwner)/\(repoName)/commits?page=1&per_page=3"
        guard let url = URL(string: baseURL + endpointURL) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let listCommits = try decoder.decode(ListCommits.self, from: data)
                completion(.success(listCommits))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
