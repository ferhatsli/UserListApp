//
//  UserDetailViewController.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    private let viewModel: UserDetailViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.05
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandColor(withAlpha: 0.1)
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let initialsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textColor = .brandColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private func createInfoView(icon: String, title: String, value: String) -> UIView {
        let container = UIView()
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: icon)
        imageView.tintColor = .brandColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        titleLabel.textColor = .secondaryLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 17)
        valueLabel.numberOfLines = 0
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(imageView)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }

    init(user: User) {
        self.viewModel = UserDetailViewModel(user: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.user.name
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(cardView)
        
        cardView.addSubview(profileImageView)
        profileImageView.addSubview(initialsLabel)
        cardView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            cardView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24)
        ])
        
        DispatchQueue.main.async { [weak self] in
            self?.setupUI()
            self?.configureUI()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func setupUI() {
        // Implementation of setupUI method
    }
    
    private func configureUI() {
        let user = viewModel.user
        
        let nameInfo = createInfoView(icon: "person.fill", title: "Name", value: user.name)
        let emailInfo = createInfoView(icon: "envelope.fill", title: "Email", value: user.email)
        let phoneInfo = createInfoView(icon: "phone.fill", title: "Phone", value: user.phone)
        let websiteInfo = createInfoView(icon: "globe", title: "Website", value: user.website)
        
        [nameInfo, emailInfo, phoneInfo, websiteInfo].forEach { stackView.addArrangedSubview($0) }
    }
}
