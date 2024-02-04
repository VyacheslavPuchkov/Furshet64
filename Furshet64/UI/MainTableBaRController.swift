//
//  ViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 18.10.2023.
//

import UIKit

class MainTableBaRController: UITabBarController {

    var homePageController: UIViewController?
    var menuController: UIViewController?
    var profileUserController: UIViewController?
    var basketProduct: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePageController = HomePageViewController()
        menuController = MenuViewController()
        profileUserController = ProfileUserViewController()
        basketProduct = BasketProductViewController()
        
        tabBar.tintColor = .systemGreen
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        viewControllers = [
        createNavVC(root: homePageController!, title: "Главная", image: UIImage(systemName: "house")!),
        createNavVC(root: menuController!, title: "Меню", image: UIImage(systemName: "menubar.rectangle")!),
        createNavVC(root: profileUserController!, title: "Мой профиль", image: UIImage(systemName: "person.text.rectangle")!),
        createNavVC(root: basketProduct!, title: "Корзина", image: UIImage(systemName: "basket")!)
        ]
    }
    
    func createNavVC(root: UIViewController,
                         title: String,
                         image: UIImage) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: root)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = image
        navVC.navigationBar.tintColor = .systemGreen
        return navVC
    }
    
}

