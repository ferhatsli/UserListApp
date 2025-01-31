# UserListApp

A modern iOS application that demonstrates clean architecture and best practices in iOS development. The app displays a list of users and their details using the JSONPlaceholder API.

## Features

- Display list of users with their basic information
- Detailed view for each user
- Modern UI with smooth animations
- Error handling and loading states
- Pull-to-refresh functionality
- Clean MVVM architecture

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture pattern with additional layers for clean separation of concerns:

### Layers

1. **Model Layer**
   - `User.swift`: Data model representing user information
   - Implements `Decodable` for JSON parsing

2. **View Layer**
   - `UserListViewController`: Displays the list of users
   - `UserDetailViewController`: Shows detailed user information
   - `UserTableViewCell`: Custom cell for user list display

3. **ViewModel Layer**
   - `UserListViewModel`: Manages user list business logic
   - `UserDetailViewModel`: Handles user detail presentation logic

4. **Network Layer**
   - `APIService`: Handles API communication
   - Implements error handling and response parsing

5. **Repository Layer**
   - `UserRepository`: Mediates between data source and application
   - Provides a clean interface for data operations

## Technical Details

- **Language**: Swift
- **Minimum iOS Version**: iOS 13.0
- **Framework**: UIKit
- **API**: JSONPlaceholder (https://jsonplaceholder.typicode.com)
- **Design Pattern**: MVVM + Repository Pattern

## Requirements

- Xcode 13.0+
- iOS 13.0+
- Swift 5.0+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/ferhatsli/UserListApp.git
```

2. Open the project in Xcode:
```bash
cd UserListApp
open UserListApp.xcodeproj
```

3. Build and run the project in Xcode

## Usage

### Running the App

1. Launch the app
2. The main screen displays a list of users
3. Pull down to refresh the user list
4. Tap on any user to view their detailed information

### Error Handling

The app handles various error scenarios:
- Network connectivity issues
- Invalid API responses
- Server errors

Error messages are displayed to the user with retry options when applicable.

## Project Structure

```
UserListApp/
├── Model/
│   └── User.swift
├── View/
│   ├── UserListViewController.swift
│   ├── UserDetailViewController.swift
│   └── UserTableViewCell.swift
├── ViewModel/
│   ├── UserListViewModel.swift
│   └── UserDetailViewModel.swift
├── Network/
│   └── APIService.swift
├── Repository/
│   └── UserRepository.swift
└── Extensions/
    └── UIColor+Extension.swift
```

## Architecture Details

### MVVM Implementation

- **Models** represent the data structure
- **Views** are responsible for UI presentation
- **ViewModels** handle business logic and state management
- Communication is handled through closures

### Data Flow

1. User interacts with View
2. View notifies ViewModel
3. ViewModel requests data from Repository
4. Repository fetches data from APIService
5. Data flows back through the same layers
6. View updates UI based on ViewModel state

### Design Decisions

- **Repository Pattern**: Provides a clean abstraction for data operations
- **Closure-based Communication**: Enables loose coupling between components
- **Programmatic UI**: Ensures better version control and maintainability
- **Extension-based Organization**: Keeps code modular and maintainable

## UI Components

### User List Screen
- Table view with custom cells
- Pull-to-refresh functionality
- Loading indicator
- Error handling with retry option

### User Detail Screen
- Scrollable detail view
- Card-based design
- Organized information display
- Loading state handling

## Styling

The app uses a consistent color scheme:
- Primary Brand Color: #ef4b46
- System colors for secondary elements
- Dynamic color adaptation for dark/light modes

## Future Improvements

Potential areas for enhancement:
- Implement local data caching
- Add unit tests
- Implement search functionality
- Add filtering options
- Enhance UI animations
- Add offline mode support

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Acknowledgments

- JSONPlaceholder API for providing test data
- Apple's UIKit framework
- Swift community for best practices and patterns 
