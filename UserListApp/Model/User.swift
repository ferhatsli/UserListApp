//
//  User.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//


import Foundation

/// Model representing a user from the JSONPlaceholder API.
/// This model is designed to match the JSON structure returned by the API endpoint.
/// Conforms to Decodable for automatic JSON parsing.
struct User: Decodable {
    /// Unique identifier for the user
    let id: Int
    
    /// Full name of the user
    let name: String
    
    /// Email address of the user
    let email: String
    
    /// Contact phone number
    let phone: String
    
    /// User's website URL
    let website: String
}
