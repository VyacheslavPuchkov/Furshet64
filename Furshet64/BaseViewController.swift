//
//  BaseViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 21.11.2023.
//

import UIKit

class BaseViewController: UIViewController {

    var bgImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage(named: "mainFotoThree")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    var nameOrganization: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фуршет 64"
        label.textAlignment = .center
        label.font = .mobileH1
        label.textColor = .black
        label.backgroundColor = .clear
        
        return label
    }()
    
    var typeOrganization: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "КЕЙТЕРИНГОВАЯ КОМПАНИЯ В САРАТОВЕ"
        label.font = .mobileH6
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    func setConstraints() {
        view.addSubview(bgImage)
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let stack = UIStackView(views: [nameOrganization, typeOrganization], axis: .vertical, spacing: 6)
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant:  70),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
