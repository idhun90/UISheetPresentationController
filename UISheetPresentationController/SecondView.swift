//
//  SecondView.swift
//  UISheetPresentationController
//
//  Created by 도헌 on 2023/01/09.
//

import UIKit

final class SecondView: BaseView {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = "Hello!"
        view.font = .systemFont(ofSize: 22, weight: .regular)
        view.textColor = .systemRed
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(SecondTableViewCell.self, forCellReuseIdentifier: SecondTableViewCell.id)
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureUI() {
        super.configureUI()
        backgroundColor = .systemGroupedBackground
    }
    
    override func setupLayout() {
        super.setupLayout()
        addSubview(label)
        addSubview(tableView)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
