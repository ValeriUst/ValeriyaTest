//
//  TableViewCell.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit
import SnapKit

final class ProductCell: UITableViewCell {
	
	// MARK: - Content
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: Constants.sizeFont, weight: .regular)
		label.numberOfLines = Constants.numberOfLines
		return label
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: Constants.sizeFont, weight: .regular)
		return label
	}()
	
	
	// MARK: - SetUp UI
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Configure Cell
	private func configureViews() {
		backgroundColor = .clear
		addSubviews([nameLabel,priceLabel])
		setConstraints()
	}
	
	public func configureCell(with viewModel: ViewModelProduct) {
		nameLabel.text = viewModel.name
		priceLabel.attributedText = viewModel.price
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		nameLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(Constants.standardOffset)
			make.centerY.equalToSuperview()
			make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-Constants.topLabelOffset)
			make.bottom.equalToSuperview().offset(-Constants.standardOffset)
		}
		
		priceLabel.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(Constants.standardOffset)
			make.centerY.equalTo(nameLabel.snp.centerY)
		}
	}
}
