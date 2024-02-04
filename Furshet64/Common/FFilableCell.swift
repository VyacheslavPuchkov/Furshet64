//
//  FFilableCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation

protocol FFillableCell: AnyObject {
    func fill(viewModel: FCellViewModel)
}
