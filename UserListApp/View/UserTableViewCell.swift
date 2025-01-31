import UIKit

/// Custom table view cell for displaying user information in the user list
/// Implements a clean, modern design with user initials and basic information
class UserTableViewCell: UITableViewCell {
    /// Reuse identifier for the cell
    static let identifier = "UserTableViewCell"
    
    // MARK: - UI Components
    
    /// Circular view displaying user initials with brand color background
    private let initialsView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandColor(withAlpha: 0.1)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Label displaying user initials
    private let initialsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .brandColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Label displaying user's full name
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Label displaying user's email address
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Stack view containing all cell content
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// Stack view containing name and email labels
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    /// Sets up the cell's UI components and constraints
    private func setupUI() {
        contentView.addSubview(containerStackView)
        
        initialsView.addSubview(initialsLabel)
        
        containerStackView.addArrangedSubview(initialsView)
        containerStackView.addArrangedSubview(textStackView)
        
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(emailLabel)
        
        setupConstraints()
        setupSeparator()
    }
    
    /// Sets up the cell's layout constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            initialsView.widthAnchor.constraint(equalToConstant: 50),
            initialsView.heightAnchor.constraint(equalToConstant: 50),
            
            initialsLabel.centerXAnchor.constraint(equalTo: initialsView.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: initialsView.centerYAnchor)
        ])
    }
    
    /// Sets up the separator line at the bottom of the cell
    private func setupSeparator() {
        let separator = UIView()
        separator.backgroundColor = .systemGray5
        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: textStackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with user data
    /// - Parameter user: The user model containing the data to display
    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        // Generate initials from the user's name (first letter of each word)
        initialsLabel.text = String(user.name.split(separator: " ").map { String($0.first!) }.joined())
    }
} 