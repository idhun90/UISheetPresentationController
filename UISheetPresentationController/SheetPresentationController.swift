//
//  UISheetPresentationController.swift
//  UISheetPresentationController
//
//  Created by 도헌 on 2023/01/09.
//

import UIKit

final class SheetPresentationController: BaseViewController {
    
    public let mainView = SheetPresentationView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        mainView.topButton.addTarget(self, action: #selector(tappedTopButton), for: .touchUpInside)
    }
    
    @objc private func tappedTopButton() {
        mainView.topButton.configuration?.title = "상호작용 ✅"
    }
    
    @objc private func tappedButton() {
        print("버튼 tapped")
        let vc = UINavigationController(rootViewController: SecondViewController())
        present(vc, animated: true)
        //showSecondViewControllerSheet()
    }
    
//    private func showSecondViewControllerSheet() {
//        let vc = UINavigationController(rootViewController: SecondViewController())
//        if let sheet = vc.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//            /*
//             sheet의 높이를 설정하는 배열
//             - detents를 설정할 경우 최소 하나의 값을 설정해 줘야 한다.
//             - 설정하지 않을 경우 기본값으로 .large() 적용.
//             */
//            sheet.prefersGrabberVisible = true
//            /*
//             sheet 상단 Grabber 표시 여부 Bool 값
//             - 기본값 flase, 표시되지 않는다
//             - true, sheet 상단 Grabber 표시
//             */
//            //sheet.largestUndimmedDetentIdentifier = .medium
//            /*
//             특정 사이즈 detent sheet 뒤 화면 음영 처리 및 사용자 상호 작용 가능 사이즈를 지정하는 프로퍼티
//             - 기본값 nil, detent 사이즈 상관없이 sheet 뒤 화면을 어둡게 하고, UI 터치 상호작용 비활성화
//             - 설정된 detent보다 더 큰 detent에 도달했을 때 음영 처리 및 사용자 상호 작용 활성화
//             */
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
//            /*
//             sheet 스크롤 시 sheet 확장 가능 여부 Bool 값
//             더 큰 Detent로 확장할 수 있는 경우
//             - 기본값 true, sheet를 위로 스크롤할 때 우선 detent가 증가하고, 가장 큰 detent로 도달했을 때 내부 content 스크롤
//             - false, sheet를 위로 스크롤할 때 sheet detent가 확장되지 않고, 내부 content 스크롤
//             */
//            sheet.prefersEdgeAttachedInCompactHeight = true
//            /*
//             sheet가 compaact-height size class에서 화면을 full screen으로 나타낼지 결정하는 Bool 값
//             - 기본값은 false, compact-height size class(예: 아이폰 가로모드)에서 full screen 상태로 보여줌
//             - true, compact-height size class 에서 하단부만 붙어 있는 상태
//             */
//            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
//            /*
//             sheet의 width가 view controller의 preferred content size와 일치하는지 여부를 판단하는 Bool 값
//             - 기본값 false, container의 safe area와 같음
//             - true, view controller의 width 값을 preferredContentSize를 사용하여 결정할 수 있음
//             - compact-width, regular-height size class 또는 prefersEdgeAttachedInCompactHeight 값이 false일 때 적용되지 않음
//             */
//        }
//        present(vc, animated: true)
//    }
}
