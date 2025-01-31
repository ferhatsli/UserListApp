//
//  APIService.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import Foundation

/// Service class responsible for handling network requests to the JSONPlaceholder API.
/// This class follows the Single Responsibility Principle by focusing solely on API communication.
class APIService {
    /// Base URL for the JSONPlaceholder API users endpoint
    private let urlString = "https://jsonplaceholder.typicode.com/users"
    
    /// Fetches the list of users from the API
    /// - Parameter completion: A closure that will be called with either an array of User objects or an error
    /// The completion handler is called on a background thread, so UI updates should be dispatched to the main thread
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            // Return a meaningful error if URL is invalid
            completion(.failure(NSError(domain: "URL Error", code: 400, userInfo: [
                NSLocalizedDescriptionKey: "Invalid URL format"
            ])))
            return
        }
        
        // Create and start a data task for fetching users
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 500, userInfo: [
                    NSLocalizedDescriptionKey: "No data received from the server"
                ])))
                return
            }
            
            do {
                // Attempt to decode the JSON response into User objects
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
