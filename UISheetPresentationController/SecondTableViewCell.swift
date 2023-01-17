//
//  SecondTableViewCell.swift
//  UISheetPresentationController
//
//  Created by 도헌 on 2023/01/10.
//

import UIKit

final class SecondTableViewCell: BaseTableViewCell {
    
    static let id = String(describing: SecondTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
    
    func setupCell(int: Int) {
        var content = defaultContentConfiguration()
        content.text = "\(int)"
        contentConfiguration = content
    }
}
