//
//  TableHeaderView.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

protocol SortButtonDelegate: AnyObject {
	func didTapSortButton()
}

final class TableHeaderView: UIView {
	
	// MARK: - Properties
	weak var delegate: SortButtonDelegate?
	
	// MARK: - Content
	private lazy var sortButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemPink
		button.layer.cornerRadius = Constants.cornerRadius
		button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Configure
	private func configureViews() {
		addSubviews([sortButton])
		sortButton.snp.makeConstraints { $0.edges.equalToSuperview() }
	}
	
	// MARK: - Button Action
	@objc
	private func sortButtonTapped() {
		delegate?.didTapSortButton()
	}
	
	func setSortButtonTitle(_ title: String) {
		sortButton.setTitle(title, for: .normal)
	}
}
