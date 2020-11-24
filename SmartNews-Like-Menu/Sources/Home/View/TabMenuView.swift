//
//  ProjectName  : SmartNews-Like-Menu
//  File Name    : TabMenu.swift
//  Created Date : 2020/11/24
//  
//  Copyright © 2019-2020 KC Apps. All rights reserved.
//

import UIKit

protocol TabMenuViewDelete: class {
	func tabMenuView(_ tabMenuView: TabMenuView, didChangePage id: Int)
}

final class TabMenuView: UIView {
	fileprivate var viewBorder: UIView!
	fileprivate var scrollView: UIScrollView!
	fileprivate var stackView: UIStackView!
	
	fileprivate var currentMenuButton: TabMenuButton! {
		didSet {
			//現在のメニューボタン画面内に表示される様にスクロール
			let offsetX =  -scrollView.frame.width / 2 + currentMenuButton.frame.origin.x + currentMenuButton.frame.width / 2
			
			if offsetX > 0 && offsetX < scrollView.contentSize.width - scrollView.frame.width {
				let offset = CGPoint(x: offsetX, y: 0)
				scrollView.setContentOffset(offset, animated: true)
			} else if offsetX < 0 {
				let offset = CGPoint(x: 0, y: 0)
				scrollView.setContentOffset(offset, animated: true)
			} else if offsetX > scrollView.contentSize.width - scrollView.frame.width {
				let offset = CGPoint(x: scrollView.contentSize.width - scrollView.frame.width, y: 0)
				scrollView.setContentOffset(offset, animated: true)
			}
			
			//仕切り線の色を現在のメニューボタンの色に変更
			viewBorder.backgroundColor = currentMenuButton.backgroundColor
			
		}
	}
	
	weak var delegate: TabMenuViewDelete?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		setup()
	}
	
	func setItems(_ items: [HomePageItem]) {
		if items.isEmpty {
			fatalError()
		}
		
		var count = 0
		
		for item in items {
			let button = TabMenuButton(item)
			button.tag = item.id
			button.addTarget(self, action: #selector(self.onTouchMenu(_:)), for: .touchUpInside)
			stackView.addArrangedSubview(button)

			button.translatesAutoresizingMaskIntoConstraints = false
			button.heightConstraint = button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
			button.heightConstraint.isActive = true
			
			count += 1
		}
		
		changePage(items.first!.id)
	}
	
	func changePage(_ id: Int) {
		for view in stackView.arrangedSubviews {
			if let button = view as? TabMenuButton {
				if button.tag == id {
					button.heightConstraint.isActive = false
					button.heightConstraint = button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9)
					button.heightConstraint.isActive = true
					
					currentMenuButton = button
				} else {
					button.heightConstraint.isActive = false
					button.heightConstraint = button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
					button.heightConstraint.isActive = true
				}
			}
		}
	}
	
	fileprivate func setup() {
		viewBorder = UIView(frame: .zero)
		viewBorder.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(viewBorder)
		
		viewBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
		viewBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		viewBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		viewBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		scrollView = UIScrollView(frame: .zero)
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(scrollView)
		
		scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: viewBorder.topAnchor).isActive = true
		scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		stackView = UIStackView(frame: .zero)
		stackView.axis = .horizontal
		stackView.alignment = .bottom
		stackView.distribution = .fill
		stackView.spacing = 0
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(stackView)
		
		stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
		stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
	}
	
	@objc fileprivate func onTouchMenu(_ sender: TabMenuButton) {
		changePage(sender.tag)
		
		delegate?.tabMenuView(self, didChangePage: sender.tag)
	}
}
