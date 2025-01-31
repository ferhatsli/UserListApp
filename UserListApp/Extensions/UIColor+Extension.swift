import UIKit

/// Extension to UIColor to provide brand-specific colors
/// This centralized approach to color management ensures consistency throughout the app
/// and makes it easier to update the color scheme
extension UIColor {
    /// The primary brand color (#ef4b46)
    /// Used for primary UI elements and accents throughout the app
    static let brandColor = UIColor(red: 239/255, green: 75/255, blue: 70/255, alpha: 1.0)
    
    /// Creates a version of the brand color with custom alpha value
    /// - Parameter alpha: The opacity level (0.0 to 1.0)
    /// - Returns: A UIColor instance of the brand color with the specified alpha
    static func brandColor(withAlpha alpha: CGFloat) -> UIColor {
        return UIColor(red: 239/255, green: 75/255, blue: 70/255, alpha: alpha)
    }
} 