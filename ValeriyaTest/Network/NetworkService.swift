//
//  NetworkService.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import Foundation

final class APICaller {
	
	static let shared = APICaller()
	
	private init() {}
	
	func loadProductsFromJSON(completion: @escaping ([Product]?) -> Void) {
		do {
			guard let path = Bundle.main.path(forResource: "products", ofType: "json") else {
				throw NSError(domain: "com.yourapp.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])
			}
			
			let jsonString = try String(contentsOfFile: path, encoding: .utf8)
			
			// Парсим JSON и декодируем его в массив объектов Product
			let products = try JSONDecoder().decode([Product].self, from: Data(jsonString.utf8))
			completion(products)
			
		} catch let error as NSError {
			// Обрабатываем ошибку, если произошла ошибка загрузки или парсинга JSON
			print("Error loading and parsing JSON: \(error.localizedDescription)")
			completion(nil)
			
		} catch {
			// Обрабатываем неизвестную ошибку
			print("Unknown error occurred while loading and parsing JSON")
			completion(nil)
		}
	}
}
