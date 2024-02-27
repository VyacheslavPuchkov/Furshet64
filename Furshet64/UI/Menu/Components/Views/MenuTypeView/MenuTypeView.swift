//
//  MenuTypeView.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit

protocol MenuTypeViewAction {
    func didTap(id: String)
}

class MenuTypeView: UIView {
    // MARK - Constants
    enum Constants {
        enum CollectionView {
            static let height: CGFloat = 32
            static let bottom: CGFloat = -24
        }
    }
    
    // MARK - ModelCell
    var cellModels: [FCellViewModel] = []
    
    // MARK - Delegate
    var delegate: MenuTypeViewAction
    
    // MARK - Variable
    var menuType: [MenuType]
    
    // MARK - UI
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK - Init
    init(filters: [MenuType], delegate: MenuTypeViewAction) {
        self.delegate = delegate
        self.menuType = filters
        super.init(frame: .zero)
        configure()
        setupCollectionView()
        self.menuType.forEach {
            cellModels.append(MenuTypeCollectionCellModel(selected: $0.selected, id: $0.id, title: $0.title))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Private func
    private func configure() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.CollectionView.bottom),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.CollectionView.height)
        ])
        collectionView.backgroundColor = .clear
        backgroundColor = .white
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuTypeCollectionCell.self, forCellWithReuseIdentifier: "MenuTypeCollectionCell")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MenuTypeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = cellModels[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.cellIdentifier, for: indexPath)
        guard let baseCell = cell as? FCollectionViewCell else { return cell }
        cellModel.fillableCell = baseCell
        return baseCell
   }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellModel = cellModels[indexPath.item]  as? MenuTypeCollectionCellModel
        guard let cellModel else { return .zero }
        return CGSize(width: cellModel.title.widthOfString(uisingFont: .systemFont(ofSize: 13, weight: .regular)) + 24, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = cellModels[indexPath.item] as? MenuTypeCollectionCellModel
        if let id = cellModel?.title {
            delegate.didTap(id: id)
        }
    }
}
