//
//  HomePageViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 18.10.2023.
//

import UIKit
import Combine
import FirebaseAuth

class HomePageViewController: BaseViewController {
    
    // MARK: - Constants
    enum Constants {
        enum CollectionView {
            static let insets = UIEdgeInsets(top: 150, left: 16, bottom: 230, right: -16)
        }
    }
   
    // MARK: - ViewModel
    var viewModel: HomePageViewModel = .init()
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FurshetInfoViewCell.self, forCellWithReuseIdentifier: FurshetInfoViewCell.reuseID)
        return collectionView
    }()
    
    // MARK: - Life Cycle View Controller
    override func loadView() {
        super.loadView()
        receivingInfo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupFurshetInfoCollectionView()
        print(Auth.auth().currentUser?.phoneNumber ?? "no user")
    }
        
}

// MARK: - Private func
private extension HomePageViewController {
    
    func setupFurshetInfoCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Combine
    func receivingInfo () {
        viewModel.infoDataSourse.sink { [weak self] _ in
            self?.collectionView.reloadData()
        }.store(in: &cancelable)
    }
    
    // MARK: - Constraints
    func setConstraint() {
        view.addSubview(collectionView)
        let insets = Constants.CollectionView.insets
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: insets.top),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            collectionView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: insets.bottom)
        ])
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.infoDataSourse.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FurshetInfoViewCell.reuseID, for: indexPath) as? FurshetInfoViewCell
        let titleFoto = viewModel.infoDataSourse.value[indexPath.row].imageName
        cell?.imageInfo.image = UIImage(named: titleFoto)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.infoDataSourse.value[indexPath.row].url) else { return }
        UIApplication.shared.open(url)
    }
    
}
