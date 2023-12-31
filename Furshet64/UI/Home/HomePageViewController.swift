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
   
    // MARK: - ViewModel
    var viewModel: HomePageViewModel = .init()
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    let furshetInfoCollectView: UICollectionView = {
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
        bind()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setConstraint()
        setupFurshetInfoCollectionView()
        print(Auth.auth().currentUser?.uid ?? "no user")
    }
        
}

// MARK: - Private func
private extension HomePageViewController {
    
    func setupFurshetInfoCollectionView() {
        furshetInfoCollectView.delegate = self
        furshetInfoCollectView.dataSource = self
    }
    
    // MARK: - Combine
    func bind () {
        viewModel.dataSourse.sink { [weak self] _ in
            self?.furshetInfoCollectView.reloadData()
        }.store(in: &cancelable)
    }
    
    // MARK: - Constraints
    func setConstraint() {
        view.addSubview(furshetInfoCollectView)
        NSLayoutConstraint.activate([
            furshetInfoCollectView.topAnchor.constraint(equalTo: view.topAnchor,constant: 150),
            furshetInfoCollectView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            furshetInfoCollectView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16),
            furshetInfoCollectView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 230)
        ])
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSourse.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FurshetInfoViewCell.reuseID, for: indexPath) as? FurshetInfoViewCell
        let titleFoto = viewModel.dataSourse.value[indexPath.row].imageName
        cell?.imageInfo.image = UIImage(named: titleFoto)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.dataSourse.value[indexPath.row].url) else { return }
        UIApplication.shared.open(url)
    }
    
}
