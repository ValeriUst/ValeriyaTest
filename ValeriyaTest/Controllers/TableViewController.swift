//
//  TableViewController.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit
import SnapKit

enum SortingMode {
	case byName
	case byPrice
}

final class TableViewController: UIViewController {
	
	// MARK: - Properties
	private let productViewModel: ViewModelProduct
	private var headerView = TableHeaderView()
	
	// MARK: - Content Views
	private let tableView = ProductTableView()
	private let informationView = InformationView()
	
	private var tapGesture: UITapGestureRecognizer?
	private var swipeGesture: UISwipeGestureRecognizer?
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViews()
		productViewModel.loadProducts()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Initialization
	init(productViewModel: ViewModelProduct) {
		self.productViewModel = productViewModel
		super.init(nibName: nil, bundle: nil)
		self.productViewModel.delegate = self
		self.productViewModel.view = self.view
	}
	
	// MARK: - Configure
	private func configureViews() {
		addTableView()
		configureHeaderView()
		configureDelegates()
		updateSortButtonTitle()
	}
	
	private func addTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
	}
	
	private func configureHeaderView() {
		headerView = TableHeaderView(frame: CGRect(x: 0,
												   y: 0,
												   width: tableView.bounds.width,
												   height: Constants.headerHeight))
		tableView.tableHeaderView = headerView
	}
	
	private func configureDelegates() {
		headerView.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
		productViewModel.delegate = self
	}
}

// MARK: - Extension (UITableViewDelegate, UITableViewDataSource )
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return productViewModel.numberOfRowsInSection()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return productViewModel.tableView(tableView, cellForRowAt: indexPath)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		showInformationView(for: indexPath)
	}
}
	
// MARK: - Extension Helper Methods
extension TableViewController {
	private func showInformationView(for indexPath: IndexPath) {
		guard let product = productViewModel.product(at: indexPath.row) else { return }
		let viewModel = ViewModelProduct(product: product)
		informationView.configureInfo(with: viewModel)
		
		informationView.frame = CGRect(x: 0,
									   y: 0,
									   width: productViewModel.compilationCellWidthAndHeight,
									   height: productViewModel.compilationCellWidthAndHeight)
		
		informationView.center = view.center
		view.addSubview(informationView)
		addGestures()
	}
	
	private func updateSortButtonTitle() {
		switch productViewModel.currentSortingMode {
		case .byName:
			headerView.setSortButtonTitle(Constants.buttonName)
		case .byPrice:
			headerView.setSortButtonTitle(Constants.buttonPrice)
		}
	}
}

// MARK: - ProductViewModelDelegate
extension TableViewController: ProductViewModelDelegate {
	func didLoadProducts() {
		tableView.reloadData()
	}
}

// MARK: - SortButtonDelegate
extension TableViewController: SortButtonDelegate {
	func didTapSortButton() {
		productViewModel.sortBy()
		updateSortButtonTitle()
		tableView.reloadData()
	}
}

// MARK: - Gesture Recognizer Handling Extension
extension TableViewController {
	/// Обработка жеста тапа
	@objc
	private func handleTap(_ sender: UITapGestureRecognizer) {
		productViewModel.handleTapGesture(sender, informationView: informationView,
										  tapGesture: &tapGesture)
	}
	
	/// Обработка жеста свайпа
	@objc
	private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
		if let tapGesture = tapGesture {
			view.removeGestureRecognizer(tapGesture)
		}
		productViewModel.handleSwipe(sender, informationView: informationView,
									 swipeGesture: &swipeGesture)
	}
	
	/// Добавляем жест тапа
	private func addTapGesture() {
		tapGesture = UITapGestureRecognizer(target: self,
											action: #selector(handleTap(_:)))
		tapGesture?.numberOfTapsRequired = productViewModel.numberOfTaps
		view.addGestureRecognizer(tapGesture!)
	}
	
	/// Добавляем жест свайпа
	private func addSwipeGesture() {
		swipeGesture = UISwipeGestureRecognizer(target: self,
												action: #selector(handleSwipe(_:)))
		swipeGesture?.direction = .down
		view.addGestureRecognizer(swipeGesture!)
	}
	
	private func addGestures() {
		addTapGesture()
		addSwipeGesture()
	}
}
