//
//  ProjectName  : SmartNews-Like-Menu
//  File Name    : HomePageViewController.swift
//  Created Date : 2020/11/24
//  
//  Copyright © 2019-2020 KC Apps. All rights reserved.
//

import UIKit

final class HomePageViewController: UIPageViewController {
	fileprivate var controllers: [HomeChildViewController]!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	func createPages(_ items: [HomePageItem]) {
		if items.isEmpty {
			fatalError()
		}
		
		self.controllers = []
		
		let storyBoard = UIStoryboard(name: "Home-Child", bundle: nil)
		
		for item in items {
			if let vc = storyBoard.instantiateInitialViewController() as? HomeChildViewController {
				vc.pageItem = item
				
				self.controllers.append(vc)
			} else {
				fatalError()
			}
		}
		
		self.dataSource = self
		
		self.setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
	}
	
	func changePage(_ id: Int) {
		if let currentVC = self.viewControllers?.first as? HomeChildViewController, let vc = controllers.filter({$0.pageItem.id == id}).first {
			if id > currentVC.pageItem.id {
				self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
			} else {
				self.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
			}
		} else {
			fatalError()
		}
	}
}

// MARK: - UIPageViewControllerDataSource
extension HomePageViewController: UIPageViewControllerDataSource {
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return controllers.count
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if let index = self.controllers.firstIndex(of: viewController as! HomeChildViewController),
			index > 0 {
			return self.controllers[index - 1]
		} else {
			return nil
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let index = self.controllers.firstIndex(of: viewController as! HomeChildViewController),
			index < self.controllers.count - 1 {
			return self.controllers[index + 1]
		} else {
			return nil
		}
	}
}
