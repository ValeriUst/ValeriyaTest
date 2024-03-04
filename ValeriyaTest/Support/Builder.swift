//
//  Builder.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 02.03.2024.
//

import Foundation
import UIKit

class Builder {
	static func build(product: Product) -> UINavigationController {
		let productViewModel = ViewModelProduct(product: product)
		let tableController = TableViewController(productViewModel: productViewModel)
		let navigationController = UINavigationController(rootViewController: tableController)
		return navigationController
	}
}
