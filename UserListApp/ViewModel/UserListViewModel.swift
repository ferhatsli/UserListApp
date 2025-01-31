//
//  UserListViewModel.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import Foundation

/// ViewModel for the user list screen, following the MVVM pattern.
/// Responsible for managing the business logic and state of the user list view.
class UserListViewModel {
    /// Repository instance for data operations
    private let repository = UserRepository()
    
    /// Current list of users
    /// Private(set) allows read-only access from outside while maintaining internal mutability
    private(set) var users: [User] = []
    
    // MARK: - Callback Closures
    
    /// Callback triggered when the users array is updated
    /// Used to notify the view that it should refresh its display
    var onUsersUpdated: (() -> Void)?
    
    /// Callback triggered when loading state changes
    /// Used to show/hide loading indicators in the view
    var onLoadingStateChanged: ((Bool) -> Void)?
    
    /// Callback triggered when an error occurs
    /// Provides error messages to be displayed to the user
    var onError: ((String) -> Void)?
    
    // MARK: - Public Methods
    
    /// Fetches the list of users from the repository
    /// This method handles the loading state and error handling
    func fetchUsers() {
        // Notify view to show loading indicator
        onLoadingStateChanged?(true)
        
        repository.getUsers { [weak self] result in
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                // Hide loading indicator
                self?.onLoadingStateChanged?(false)
                
                switch result {
                case .success(let users):
                    // Update the users array and notify view
                    self?.users = users
                    self?.onUsersUpdated?()
                case .failure(let error):
                    // Notify view about the error
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
