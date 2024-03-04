//
//  InformationView.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

final class InformationView: UIView {
		
	// MARK: - Content
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: Constants.sizeFont)
		label.textColor = .black
		label.textAlignment = .center
		label.numberOfLines = Constants.numberOfLines
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: Constants.sizeFont)
		label.textColor = .black
		label.textAlignment = .center
		label.numberOfLines = Constants.numberOfLines
		return label
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: Constants.sizeFont)
		label.textColor = .black
		label.textAlignment = .center
		return label
	}()
	
	// MARK: - Lifecycle Methods
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI Setup
	
	private func setupUI() {
		addSubviews([titleLabel, descriptionLabel, priceLabel])
		setConstraints()
		setupAppearance()
	}
	
	private func setupAppearance() {
		backgroundColor = .white
		layer.cornerRadius = Constants.cornerRadius
		layer.masksToBounds = true
		layer.borderWidth = Constants.borderWidth
		layer.borderColor = UIColor.black.cgColor
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.leading.equalToSuperview().offset(Constants.standardOffset)
			make.top.trailing.equalToSuperview().inset(Constants.standardOffset)
		}
		priceLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(Constants.topOffset)
			make.centerX.equalToSuperview()
		}
		descriptionLabel.snp.makeConstraints { make in
			make.top.equalTo(priceLabel.snp.bottom).offset(Constants.topOffset)
			make.leading.equalToSuperview().offset(Constants.standardOffset)
			make.trailing.equalToSuperview().inset(Constants.standardOffset)
		}
	}
	
	// MARK: - Configure
	public func configureInfo(with viewModel: ViewModelProduct) {
		titleLabel.text = viewModel.name
		descriptionLabel.text = viewModel.description
		priceLabel.attributedText = viewModel.price
	}
}
