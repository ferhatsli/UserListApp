//
//  UserListViewController.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = UserListViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private let errorView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try Again", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUsers()
    }
    
    private func setupUI() {
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        
        errorView.addSubview(errorLabel)
        errorView.addSubview(retryButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        retryButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            errorLabel.topAnchor.constraint(equalTo: errorView.topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onUsersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
                self?.updateUI(hasError: false)
            }
        }
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading && self?.refreshControl.isRefreshing == false {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.errorLabel.text = error
                self?.updateUI(hasError: true)
            }
        }
    }
    
    private func updateUI(hasError: Bool) {
        errorView.isHidden = !hasError
        tableView.isHidden = hasError
    }
    
    @objc private func refreshData() {
        viewModel.fetchUsers()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = viewModel.users[indexPath.row]
        let detailVC = UserDetailViewController(user: user)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
