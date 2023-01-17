//
//  UISheetPresentationView.swift
//  UISheetPresentationController
//
//  Created by 도헌 on 2023/01/09.
//

import UIKit

final class SheetPresentationView: BaseView {
    
    let button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Open"
        configuration.subtitle = "SheetPresentationView"
        configuration.titleAlignment = .center
        let view = UIButton(configuration: configuration)
        return view
    }()
    
    let topButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "상호작용"
        configuration.titleAlignment = .center
        let view = UIButton(configuration: configuration)
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
        backgroundColor = .white
    }
    
    override func setupLayout() {
        super.setupLayout()
        addSubview(button)
        addSubview(topButton)
        
        topButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(button.snp.top).offset(-50)
        }
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
