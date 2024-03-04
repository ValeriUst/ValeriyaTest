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
		let window = UIWindow(windowScene: windowScene)
		let product = Product(id: "1", name: "Product Name", description: "Product Description", price: 0)
		let navigationController = Builder.build(product: product)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		self.window = window
	}
}
