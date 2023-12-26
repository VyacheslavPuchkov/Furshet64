//
//  MenuViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

import UIKit
import Combine
import FirebaseStorage

class MenuTypeViewController: BaseViewController {
    
    // MARK: - ViewModel
    var viewModel: MenuTypeViewModel = .init()
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    let collectViewTypeProduct : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 50)
        layout.sectionInset = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.register(MenyTypeCollectionViewCell.self, forCellWithReuseIdentifier: MenyTypeCollectionViewCell.reuseID)
        return collectionView
    }()
    
    let collectViewProduct: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 330)
        layout.sectionInset = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MenyProductCollectionViewCell.self, forCellWithReuseIdentifier: MenyProductCollectionViewCell.reuseID)
        return collectionView
        
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        viewModelFunc()
        combineFunc()
        setupCollectionTypeProduct()
        setupCollectionProduct()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
}


// MARK: - Private func
private extension MenuTypeViewController {
    
    func combineFunc() {
        bindTypeProduct()
        bindProduct()
    }

    func viewModelFunc() {
        viewModel.getMenuTypeProduct()
        viewModel.getProduct(productType: "Холодные закуски из морепродуктов")
    }
    
    func setupCollectionProduct() {
        collectViewProduct.delegate = self
        collectViewProduct.dataSource = self
    }
    
    func setupCollectionTypeProduct() {
        collectViewTypeProduct.delegate = self
        collectViewTypeProduct.dataSource = self
    }
    
    // MARK: Constraints
    func setConstraint() {
        view.addSubview(collectViewTypeProduct)
        NSLayoutConstraint.activate([
            collectViewTypeProduct.topAnchor.constraint(equalTo: typeOrganization.bottomAnchor,constant: 25),
            collectViewTypeProduct.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectViewTypeProduct.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectViewTypeProduct.bottomAnchor.constraint(equalTo: typeOrganization.bottomAnchor, constant: 80)
        ])
        view.addSubview(collectViewProduct)
        NSLayoutConstraint.activate([
            collectViewProduct.topAnchor.constraint(equalTo: collectViewTypeProduct.bottomAnchor, constant: 16),
            collectViewProduct.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectViewProduct.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectViewProduct.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
    // MARK: - Combine
    func bindTypeProduct() {
        viewModel.dataSourseTypeProduct.sink { [weak self] _ in
            guard let self else { return }
            self.collectViewTypeProduct.reloadData()
        }.store(in: &cancelable)
    }
    
    func bindProduct() {
        viewModel.dataSourseProduct.sink { [weak self] _ in
            guard let self else { return }
            self.collectViewProduct.reloadData()
        }.store(in: &cancelable)
    }
    
}

// MARK: - UICollectionViewDelegate
extension MenuTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectViewTypeProduct {
            return viewModel.dataSourseTypeProduct.value.count
        } else {
            return viewModel.dataSourseProduct.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectViewTypeProduct {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenyTypeCollectionViewCell.reuseID, for: indexPath) as? MenyTypeCollectionViewCell
            let item = viewModel.dataSourseTypeProduct.value[indexPath.row]
            cell?.titleMenyTypeLabel.text = item.title
            cell?.layer.cornerRadius = 5
            cell?.layer.borderWidth = 2
            cell?.layer.borderColor = UIColor.black.cgColor
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenyProductCollectionViewCell.reuseID, for: indexPath) as? MenyProductCollectionViewCell
            let item = viewModel.dataSourseProduct.value[indexPath.row]
            cell?.tapPublisher.sink(receiveValue: { [weak self, weak cell] _ in
                guard self != nil else { return }
                let order: OrderModel = .init(id: UUID().uuidString, product: item, count: cell?.count ?? .zero)
                BasketProductManager.shared.addOrder(order)
            }).store(in: &cancelable)
            cell?.setFoto(title: item.imageUrl)
            cell?.priceLabel.text = "\(item.price) р."
            cell?.titleLabel.text = item.title
            cell?.layer.cornerRadius = 8
            cell?.layer.borderWidth = 2
            cell?.layer.borderColor = UIColor.white.cgColor
            cell?.backgroundColor = .black.withAlphaComponent(0.3)
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectViewTypeProduct {
            let selectedTypeProduct = viewModel.dataSourseTypeProduct.value[indexPath.row].title
            viewModel.getProduct(productType: selectedTypeProduct)
        }
    }
    
}
