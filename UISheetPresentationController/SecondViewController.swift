//
//  SecondViewController.swift
//  UISheetPresentationController
//
//  Created by 도헌 on 2023/01/09.
//

import UIKit

final class SecondViewController: BaseViewController {
    
    private let mainView = SecondView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func dismissView() {
        
        guard let nvc = presentingViewController as? SheetPresentationController else { return }
        
        dismiss(animated: true) {
            guard let title = nvc.mainView.topButton.configuration?.title else { return }
            if title == "상호작용 ✅" {
                nvc.mainView.topButton.configuration?.title = "상호작용"
            } else {
                print("버튼 타이틀 수정되지 않음")
            }
        }
    }
    
    deinit {
        print("디이닛됨")
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int.random(in: 0...30)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.id, for: indexPath) as? SecondTableViewCell else {
            return UITableViewCell() }
        cell.setupCell(int: Int.random(in: 0...30))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
