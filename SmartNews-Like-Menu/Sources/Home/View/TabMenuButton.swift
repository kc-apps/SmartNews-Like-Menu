//
//  ProjectName  : SmartNews-Like-Menu
//  File Name    : TabMenuButton.swift
//  Created Date : 2020/11/24
//  
//  Copyright © 2019-2020 KC Apps. All rights reserved.
//

import UIKit

final class TabMenuButton: UIButton {
	var heightConstraint: NSLayoutConstraint!
	
	init(_ menuItem: HomePageItem) {
		super.init(frame: CGRect.zero)
		
		self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		
		//MenuItemからタイトルと背景色を設定
		self.setTitle(menuItem.title, for: .normal)
		self.backgroundColor = menuItem.color
		
		//左右の余白
		self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		
		//上半分を角丸
		self.layer.cornerRadius = 5
		self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
