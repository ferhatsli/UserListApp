//
//  SceneDelegate.swift
//  UserListApp
//
//  Created by Ferhat Taşlı on 31.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Yeni bir pencere (window) oluşturuyoruz ve kök görünüm denetleyicisini (rootViewController) ayarlıyoruz
        window = UIWindow(windowScene: windowScene)
        let userListVC = UserListViewController()
        let navigationController = UINavigationController(rootViewController: userListVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
