//
//  UserDetailViewModel.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import Foundation

/// ViewModel for the user detail screen, following the MVVM pattern.
/// Responsible for managing the data and state of the user detail view.
class UserDetailViewModel {
    /// The user model containing all the details to be displayed
    let user: User
    
    /// Initializes the view model with a user model
    /// - Parameter user: The user whose details will be displayed
    init(user: User) {
        self.user = user
    }
}
