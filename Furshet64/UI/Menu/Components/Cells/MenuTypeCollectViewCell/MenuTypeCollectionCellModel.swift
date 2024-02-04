//
//  MenuTypeCollectViewCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation

class MenuTypeCollectionCellModel: FCellViewModel {
    var selected: Bool
    var id: String
    var title: String
    init(selected: Bool, id: String, title: String) {
        self.selected = selected
        self.id = id
        self.title = title
        super.init(cellIdentifier: "MenuTypeCollectionCell")
    }
}
