//
//  PriceFormatter.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

struct PriceFormatter {
	static func format(price: Double) -> NSAttributedString {
		// Форматируем цену как строку с двумя десятичными знаками
		let priceString = String(format: "%.2f ", price)
		let currencySymbol = "₽"
		let attributedString = NSMutableAttributedString(string: priceString + currencySymbol)
		
		// Устанавливаем черный цвет для цены
		attributedString.addAttribute(.foregroundColor,
									  value: UIColor.black,
									  range: NSRange(location: 0, length: priceString.count))
		
		// Устанавливаем серый цвет для символа валюты
		attributedString.addAttribute(.foregroundColor,
									  value: UIColor.gray,
									  range: NSRange(location: priceString.count, length: currencySymbol.count))
		
		return attributedString
	}
}
