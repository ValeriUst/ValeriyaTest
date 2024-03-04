//
//  ViewModelProduct.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

protocol ProductViewModelDelegate: AnyObject {
	func didLoadProducts()
}

final class ViewModelProduct {
	
	// MARK: - Properties
	weak var delegate: ProductViewModelDelegate?
	private var headerView = TableHeaderView()
	private var products: [Product]?
	private let informationView = InformationView()
	private var tapGesture: UITapGestureRecognizer?
	weak var view: UIView?
	var currentSortingMode: SortingMode = .byPrice

	// MARK: - Computed Properties
	let numberOfTaps: Int = 1

	var cellPadding: CGFloat {
		isIPhoneSE ? Constants.infoViewHeightSE : Constants.infoViewHeight
	}
	
	var isIPhoneSE: Bool {
		view?.bounds.width == Constants.widthSE
	}
	
	var compilationCellWidthAndHeight: CGFloat {
		guard let view = view else { return 0 }
		return view.bounds.width - cellPadding - (Constants.cellInset * 2)
	}

	// MARK: - Methods
	/// Загружает продукты из API
	func loadProducts() {
		APICaller.shared.loadProductsFromJSON { [weak self] loadedProducts in
			guard let self = self else { return }
			if let loadedProducts = loadedProducts {
				self.products = loadedProducts
				self.sortByName()
				self.delegate?.didLoadProducts()
			} else {
				print("Failed to load products")
			}
		}
	}
	
	/// Возвращает количество загруженных продуктов
	func numberOfRowsInSection() -> Int {
		return products?.count ?? 0
	}
	
	/// Возвращает продукт по указанному индексу
	func product(at index: Int) -> Product? {
		guard let products = products, index < products.count else {
			return nil
		}
		return products[index]
	}
	
	/// Конфигурирует ячейку таблицы для отображения продукта
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
		if let product = product(at: indexPath.row) {
			cell.configureCell(with: ViewModelProduct(product: product))
		}
		return cell
	}
	
	/// Сортирует продукты
	func sortBy() {
		switch currentSortingMode {
		case .byName:
			products?.sort { $0.name ?? "" < $1.name ?? ""}
			headerView.setSortButtonTitle(Constants.buttonPrice)
			currentSortingMode = .byPrice
		case .byPrice:
			products?.sort { $0.price ?? 0 < $1.price ?? 0}
			headerView.setSortButtonTitle(Constants.buttonName)
			currentSortingMode = .byName
		}
	}
	
	/// Сортирует продукты по имени
	func sortByName() {
		products?.sort { $0.name ?? "" < $1.name ?? "" }
		headerView.setSortButtonTitle(Constants.buttonPrice)
		currentSortingMode = .byPrice
	}
	
	// MARK: - Properties and initializers
	let id: String
	let name: String
	let description: String
	let price: NSAttributedString

	init(product: Product) {
		self.id = product.id ?? ""
		self.name = product.name ?? ""
		self.description = product.description ?? ""
		self.price = PriceFormatter.format(price: product.price ?? 0)
	}
}

// MARK: - Gesture Recognizer Handling Extension
extension ViewModelProduct {
	func handleTapGesture(_ sender: UITapGestureRecognizer, informationView: UIView, tapGesture: inout UITapGestureRecognizer?) {
		guard !informationView.frame.contains(sender.location(in: view)) else { return }
		informationView.removeFromSuperview()
		if let tapGesture = tapGesture {
			view?.removeGestureRecognizer(tapGesture)
			self.tapGesture = nil
		}
	}
}
