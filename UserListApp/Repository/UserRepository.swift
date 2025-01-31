//
//  UserRepository.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import Foundation

/// Repository class that acts as a mediator between the data source (API) and the application.
/// This class implements the Repository pattern to abstract the data source from the rest of the app.
/// It could be extended to include local storage, caching, or multiple data sources while maintaining the same interface.
class UserRepository {
    /// The API service instance used for network requests
    private let apiService = APIService()
    
    /// Fetches users from the data source
    /// - Parameter completion: A closure that will be called with either an array of User objects or an error
    /// This method currently forwards the request to the API service but could be modified to:
    /// - Implement caching
    /// - Handle offline mode
    /// - Combine multiple data sources
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        apiService.fetchUsers(completion: completion)
    }
}
