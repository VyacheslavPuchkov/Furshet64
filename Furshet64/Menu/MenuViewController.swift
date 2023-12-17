//
//  MenuViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.12.2023.


import UIKit
import Combine

class MenuViewController: BaseViewController {
    
    var viewModel: MenuViewModel = .init()
    private var cancelable = Set<AnyCancellable>()
    
    let collectViewProduct: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2 - 30, height: 38)
        layout.sectionInset = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MenyProductCollectionViewCell.self, forCellWithReuseIdentifier: MenyProductCollectionViewCell.reuseID)
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        viewModel.getProduct()
        bind()
        collectViewProduct.delegate = self
        collectViewProduct.dataSource = self
    }
    
    private func setConstraint() {
        view.addSubview(collectViewProduct)
        NSLayoutConstraint.activate([
            collectViewProduct.topAnchor.constraint(equalTo: typeOrganization.bottomAnchor, constant: 25),
            collectViewProduct.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectViewProduct.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectViewProduct.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func bind() {
        viewModel.dataSourse.sink { [weak self] _ in
            self?.collectViewProduct.reloadData()
        }.store(in: &cancelable)
    }
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSourse.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenyProductCollectionViewCell.reuseID, for: indexPath) as? MenyProductCollectionViewCell
        let item = viewModel.dataSourse.value[indexPath.row]
        cell?.setFoto(title: item.imageUrl)
        cell?.priceLabel.text = "\(item.price) р."
        cell?.titleLabel.text = item.title
        cell?.layer.cornerRadius = 8
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.white.cgColor
        return cell ?? UICollectionViewCell()
    }
}

