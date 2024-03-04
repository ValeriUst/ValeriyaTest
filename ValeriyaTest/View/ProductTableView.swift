//
//  ProductTableView.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

final class ProductTableView: UITableView {
	
	init() {
		super.init(frame: .zero, style: .grouped)
		register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
		backgroundColor = .white
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
