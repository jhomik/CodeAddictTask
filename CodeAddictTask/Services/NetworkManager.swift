//
//  NetworkManager.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import UIKit

class NetworkManager {
    
    private let baseURL = "https://api.github.com/"
    private let cache = NSCache<NSString, UIImage>()
    
    func searchRepositories(withWord: String, completion: @escaping (Result<RepositoriesResponse, Error>) -> Void) {
        let endpointURL = "search/repositories?q="
        guard let url = URL(string: baseURL + endpointURL + withWord) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                print("error")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            print("URL RESPONSE: \(response)")
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let repositories = try decoder.decode(RepositoriesResponse.self, from: data)
                completion(.success(repositories))
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getRepositories(forOwner: String, repoName: String, completion: @escaping (Result<DetailRepositories, Error>) -> Void) {
        let endpointURL = "repos/\(forOwner)/\(repoName)"
        guard let url = URL(string: baseURL + endpointURL) else { return }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                print("error")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let detailRepositories = try decoder.decode(DetailRepositories.self, from: data)
                completion(.success(detailRepositories))
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getListCommits(forOwner: String, repoName: String, completion: @escaping (Result<[ListCommit], Error>) -> Void) {
        let endpointURL = "repos/\(forOwner)/\(repoName)/commits?page=1&per_page=3"
        guard let url = URL(string: baseURL + endpointURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            print("URL RESPONSE: \(response)")
            
            guard let data = data else { return }
            print("URL DATA: \(data)")
            do {
                let decoder = JSONDecoder()
                let listCommits = try decoder.decode([ListCommit].self, from: data)
                completion(.success(listCommits))
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let image = UIImage(data: data) else {
                    
                    completion(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
    }
}
