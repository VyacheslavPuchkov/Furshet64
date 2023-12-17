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
    //var reviewsController: UIViewController?
    var profileUserController: UIViewController?
    //var entranceController: UIViewController?
    var basketProduct: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePageController = HomePageViewController()
        menuController = MenuTypeViewController()
        profileUserController = ProfileUserViewController()
        basketProduct = BasketProductViewController()
        //test?.viewModel = .init()
        
//        reviewsController = ReviewsController()
//        myProfileController = MyProfileController()
//
//
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        viewControllers = [
        createNavVC(root: homePageController!, title: "Главная", image: UIImage(systemName: "house")!),
        createNavVC(root: menuController!, title: "Меню", image: UIImage(systemName: "menubar.rectangle")!),
        createNavVC(root: profileUserController!, title: "Мой профиль", image: UIImage(systemName: "person.text.rectangle")!),
        createNavVC(root: basketProduct!, title: "Корзина", image: UIImage(systemName: "basket")!)
        ]
////
        ///
        
//        viewControllers = [
//                createNavVC(root: mainMenuController!, title: "Главная", image: UIImage(systemName: "house")!),
//                createNavVC(root: reviewsController!, title: "Отзывы", image: UIImage(systemName: "menucard")!),
//                createNavVC(root: myNotesController!, title: "Мои записи", image: UIImage(systemName: "list.bullet.clipboard")!),
//                createNavVC(root: myProfileController!, title: "Мой профиль", image: UIImage(systemName: "person.text.rectangle")!)
//            ]
    }
    
    func createNavVC(root: UIViewController,
                         title: String,
                         image: UIImage) -> UINavigationController {
            let navVC = UINavigationController(rootViewController: root)
            navVC.tabBarItem.title = title
            navVC.tabBarItem.image = image
            navVC.navigationBar.tintColor = UIColor(named: "grayColor")
            return navVC
    }
}

