//
//  ProjectName  : SmartNews-Like-Menu
//  File Name    : HomeChildVC.swift
//  Created Date : 2020/11/24
//  
//  Copyright © 2019-2020 KC Apps. All rights reserved.
//

import UIKit

final class HomeChildViewController: UIViewController {
	@IBOutlet fileprivate var labelTitle: UILabel!
	@IBOutlet fileprivate var labelContent: UILabel!
	
	var pageItem: HomePageItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		labelTitle.text = pageItem.title
		labelTitle.textColor = pageItem.color
		labelContent.text = pageItem.content
	}
}
