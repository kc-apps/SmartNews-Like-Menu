//
//  ProjectName  : SmartNews-Like-Menu
//  File Name    : HomeViewController.swift
//  Created Date : 2020/11/24
//
//  Copyright © 2019-2020 KC Apps. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
	@IBOutlet fileprivate var viewTabMenu: TabMenuView! {
		didSet {
			viewTabMenu.delegate = self
		}
	}
	
	fileprivate var pageViewController: HomePageViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTabMenu()
	}

	fileprivate func setupTabMenu() {
		let menu1 = HomePageItem(id: 1, title: "メニュー1", color: .blue, content: "コンテンツ1")
		let menu2 = HomePageItem(id: 2, title: "メニュー2", color: .red, content: "コンテンツ2")
		let menu3 = HomePageItem(id: 3, title: "メニュー3", color: .purple, content: "コンテンツ3")
		let menu4 = HomePageItem(id: 4, title: "メニュー4", color: .systemPink, content: "コンテンツ4")
		let menu5 = HomePageItem(id: 5, title: "メニュー5", color: .orange, content: "コンテンツ5")
		let menu6 = HomePageItem(id: 6, title: "メニュー6", color: .cyan, content: "コンテンツ6")
		let menu7 = HomePageItem(id: 7, title: "メニュー7", color: .black, content: "コンテンツ7")
		
		let menuItems = [menu1, menu2, menu3, menu4, menu5, menu6, menu7]
		
		viewTabMenu.setItems(menuItems)
		pageViewController.createPages(menuItems)
	}
}

// MARK: - TabMenuViewDelete
extension HomeViewController: TabMenuViewDelete {
	func tabMenuView(_ tabMenuView: TabMenuView, didChangePage id: Int) {
		pageViewController.changePage(id)
	}
}

// MARK: - UIPageViewControllerDelegate
extension HomeViewController: UIPageViewControllerDelegate {
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if completed {
			if let targetVC = pageViewController.viewControllers!.first as? HomeChildViewController {
				viewTabMenu.changePage(targetVC.pageItem.id)
			}
		}
	}
}

extension HomeViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "embed" {
			if let vc = segue.destination as? HomePageViewController {
				self.pageViewController = vc
				self.pageViewController.delegate = self
			} else {
				fatalError()
			}
		}
	}
}

