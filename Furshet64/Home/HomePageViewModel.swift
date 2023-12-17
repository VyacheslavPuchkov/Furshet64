//
//  HomePageViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 21.11.2023.
//

import Foundation
import Combine


class HomePageViewModel: NSObject {
    
    var dataSourse = CurrentValueSubject<[FurshetInfo], Never>([])
    
    override init() {
        super.init()
        getFurshetInfo()
    }
    
    func getFurshetInfo() {
        DatabaseService.shared.getFurshetInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let info):
                self.dataSourse.send(info)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

