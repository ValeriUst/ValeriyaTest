//
//  SceneDelegate.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.windowScene = windowScene
		let vc = TableViewController()
		let navigationController = UINavigationController(rootViewController: vc)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
