//
//  UIView + AddSubview.swift
//  ValeriyaTest
//
//  Created by Валерия Устименко on 01.03.2024.
//

import UIKit

extension UIView {
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach {
			addSubview($0);
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}
