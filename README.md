# UISheetPresentationController

## 업데이트 내역
- 2023.01.18 - animateChanges, selectedDetentIdentifier를 활용하여 두 버튼을 Tap했을 때 sheet detent값 변경

지도 앱을 실행하면 화면 하단에 검색, 즐겨찾기, 최근 항목 등을 볼 수 있는 **Bottom Sheet**가 있다. Bottom Sheet는 위로 드래그하면 유동적으로 Sheet 크기가 변하는데, **UISheetPresentationController** 클래스를 통해 구현할 수 있다.

## 구조

```swift
@MainActor class UISheetPresentationController: UIPresentationController
```

UISheetPresentationController를 사용하여 우리의 view controller를 하나의 sheet로 present 할 수 있다. 그전에 먼저 sheetPresentationController 프로퍼티를 통해 **sheet의 속성 및 동작**을 **구성**해야 한다.

## sheetPresentationController 프로퍼티

**iOS 15**부터 UIViewController는 **sheetPresentationController 프로퍼티**를 지원하며, **UIViewController를 상속하는 모든 곳에서 UISheetPresentationController 타입의 sheetPresentationController 프로퍼티에 접근**할 수 있다.

```swift
private func showSecondViewControllerSheet() {
 	let vc = SecondViewController() // Sheet에 보여줄 view controller
 	// sheetPresentationController 프로퍼티 접근
 	if let sheet = vc.sheetPresentationController { 
 		... 
 		code
 		...
 	}
 	present(vc, animated: true)
}
```

## 높이 설정

```swift
private func showSecondViewControllerSheet() {
 	let vc = SecondViewController()
 	if let sheet = vc.sheetPresentationController {
 	sheet.detents = [.medium(), .large()] // Sheet 높이 설정
 	}
 	present(vc, animated: true)
}
```

`detents`프로퍼티를 통해 **대략 화면의 절반 높이**를 띄워주는 `.medium()` 또는 **화면 전체 높이**만큼 띄워주는 `.large()` 높이의 Sheet를 설정할 수 있다. 기본값은 large()이다.

![detentMediumAndLarge](https://user-images.githubusercontent.com/51053410/212861705-9d103a55-5709-482e-9f75-f60a9296320e.gif)

## Shows a grabber

```swift
private func showSecondViewControllerSheet() {
 	let vc = SecondViewController()
 	if let sheet = vc.sheetPresentationController {
 	sheet.detents = [.medium(), .large()]
 	sheet.prefersGrabberVisible = false // Grabber Show/Hide 설정
 	}
 	present(vc, animated: true)
}
```

Bool 타입 `prefersGrabberVisible` 프로퍼티에 **`true`** 값을 주어, 사용자가 **Sheet 크기를 조절**할 수 있다는 걸 인식하고 유도하는 Grabber를 Sheet 상단에 표시할 수 있다.

<img src="https://user-images.githubusercontent.com/51053410/212862374-dba14194-b5e4-4cfa-9354-5460a4d70c02.png"  width="295" height="640"/>  <img src="https://user-images.githubusercontent.com/51053410/212862449-fea186c5-f5ee-4cf8-b147-0e3574b44286.png"  width="295" height="640"/>

## sheet 뒤 화면, 음영 처리 및 상호 작용 활성화 여부

 ```swift
private func showSecondViewControllerSheet() {
 	let vc = SecondViewController()
 	if let sheet = vc.sheetPresentationController {
 	...
 	sheet.largestUndimmedDetentIdentifier = .large 
 	// large 사이즈 detent 까지 음영 처리하지 않고, 상호 작용 활성화
 	...
 	}
 	present(vc, animated: true)
}
 ```

화면에 sheet가 나타나면서 **뒤에 위치한 view를 음영 처리하거나, sheet가 올라온 상태에서도 뒤에 있는 view를 터치했을 때 상호 작용 가능 여부를 제어**하는 `largestUndimmedDetentIdentifier` 프로퍼티가 있다.

`largestUndimmedDetentIdentifier` 프로퍼티를 사용하여 특정 사이즈의 detent를 설정하면, 지정된 사이즈의 sheet까지 **뒤 화면을 어둡게 하지 않고, 해당 view에 UI 터치 상호 작용을 활성화**한다.

### 기본값(nil) 일 때

![largestUndimmedDetentIdentifier = nil 복사본](https://user-images.githubusercontent.com/51053410/212864013-0513c371-03ed-4e52-97ce-aeef492456fc.gif)

- 기본값 nil 일 때, 모든 detent의 sheet 뒤 화면은 모두 음영 처리되고 사용자 상호 작용 불가능
- sheet 뒤 화면 터치 시, sheet dismiss 됨

### .medium 일 때

 ```swift
private func showSecondViewControllerSheet() {
 	let vc = SecondViewController()
 	if let sheet = vc.sheetPresentationController {
 	...
 	sheet.largestUndimmedDetentIdentifier = .medium
 	// medium 사이즈 detent 까지 음영 처리하지 않고, 상호 작용 활성화
 	...
 	}
 	present(vc, animated: true)
 }
```

![largestUndimmedDetentIdentifier =  medium](https://user-images.githubusercontent.com/51053410/212864348-0ab7e189-0f8d-4e29-b4d7-348a95ca2c6e.gif)

`largestUndimmedDetentIdentifier` 프로퍼티를 사용하여 특정 사이즈의 detent를 설정하면, 지정된 사이즈의 sheet까지 **뒤 화면을 어둡게 하지 않고, 해당 view에 UI 터치 상호 작용을 활성화**한다.

### .large 일 때 

- medium, large detent sheet 뒤 화면이 음영 처리 되지 않고, 상호 작용이 활성화된다.

## 스크롤 시 sheet 확장 가능 여부 설정

sheet가 `selectedDentent Identifier`보다 더 큰 **Detent로 확장할 수 있는 경우**, `prefersScrollingExpandsWhenScrolledToEdge` 프로퍼티 값에 따라 **sheet를 위로 스크롤 했을 때 sheet의 content가 스크롤**되거나 **detent가 증가하여 가장 큰 detent가 됐을 때 content 스크롤**이 이루어진다.

prefersScrollingExpandsWhenScrolledToEdge 프로퍼티 **기본값은 true**이다, 즉 sheet를 위로 스크롤 했을 때 detent가 증가하고, 가장 큰 detent가 됐을 때 내부 content 스크롤이 가능하다면 content 스크롤

- true -> sheet detent 증가 및 최대 detent 도달 시 내부 content 스크롤 (예: UITableView, UICollectionView)
- false -> sheet detent가 확장되지 않고, 내부 content 스크롤

### true 일 때

![prefersScrollingExpandsWhenScrolledToEdge = true](https://user-images.githubusercontent.com/51053410/212864831-fbfef33b-cf35-447d-9022-d2507d7285b3.gif)

- large detent로 확장 가능한 상태에서 sheet를 위로 드래그했을 때 먼저 large detent로 확장된 후 테이블뷰 스크롤이 가능한 것을 확인할 수 있다.

### false 일 떄

![prefersScrollingExpandsWhenScrolledToEdge = false](https://user-images.githubusercontent.com/51053410/212864774-c63410fd-a91a-4910-9a9e-5f887f97d431.gif)

- large detent로 확장 가능한 상태에서 sheet를 위로 드래그했을 때 large detent로 확장되지 않고 테이블뷰 스크롤이 가능한 것을 확인할 수 있다.

## prefersEdgeAttachedInCompactHeight

`prefersEdgeAttachedInCompactHeight` 프로퍼티를 통해서 **sheet가 compact-height `size class` 에서 화면 아래쪽 가장자리에 붙어 있는지 여부를 결정**할 수 있다.

### 기본값 false
![prefersEdgeAttachedInCompactHeight = false](https://user-images.githubusercontent.com/51053410/212864998-9cee7003-ae37-445f-a689-0de217ab0273.gif)

- 기본값 false는 compact-height size class에서 full screen 상태

### true

![prefersEdgeAttachedInCompactHeight = true](https://user-images.githubusercontent.com/51053410/212865048-e80d0108-1b87-4488-82cb-815216db73af.gif)

- true일 때는 compact-height size class 에서 하단부만 붙어 있는 상태

## widthFollowsPreferredContentSizeWhenEdgeAttached

widthFollowsPreferredContentSizeWhenEdgeAttached 프로퍼티는 sheet의 width가 view controller의 preferred content size와 일치하는지 여부를 판단하는 Bool 값이다.

- **sheet width가 view controller의 preferred content size와 일치하는지 여부**를 결정하**는 Bool 값**의 프로퍼티
- 기본값 **false**일 때 **sheet의 width는 기본적으로 container의 safe area**와 같다.
- **true**일 때 **view controller의 width 값을 `preferredContentSize`를 사용하여 결정**할 수 있다.

> compact-width, regular-height size class 또는 prefersEdgeAttachedInCompactHeight 값이 false 일 때 적용되지 않는다.

## 프로그래밍 방식으로 sheet 높이 조절

NavigationBar에 버튼 두 개를 만들고, 각 버튼을 탭했을 때 sheet 높이가 변화시킬 수 있다. 

- `animateChanges(_:)` 메소드 및 `selectedDententIdentifier` 프로퍼티 활용
    - **`animateChanges(_:)` 메소드.** 
        - **sheet 속성을 변경**할 때, **애니메이션도 함께 적용**하기 위해 해다 메소드 클로저 내부에 속성 변경 코드를 작성
    - **`selectedDententIdentifier` 프로퍼티.**
        - 사용자가 선택하거나 프로그래밍 방식으로 설정한 가장 최근 detent를 나타내는 프로퍼티
        - 기본값은 nil이다. sheet가 가장 작은 detent를 표시함을 의미한다.

```swift
override func viewDidLoad() {
    setupBarButtonItems()
    setupSheetPresentationController()
}

private func setupBarButtonItems() {
    let rightButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
    let mediumButton = UIBarButtonItem(image: UIImage(systemName: "m.circle"), style: .plain, target: self, action: #selector(setMedium))
    let largeButton = UIBarButtonItem(image: UIImage(systemName: "l.circle"), style: .done, target: self, action: #selector(setLarge))
    navigationItem.rightBarButtonItems = [rightButton, largeButton, mediumButton]
}

private func setupSheetPresentationController() {
    if let sheet = sheetPresentationController {
        sheet.detents = [.medium(), .large()]
        sheet.prefersGrabberVisible = true
        sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        sheet.prefersEdgeAttachedInCompactHeight = true
        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
    }
}

@objc private func setMedium() {
    if let sheet = sheetPresentationController {
        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .medium
        }
    }
}

@objc private func setLarge() {
    if let sheet = sheetPresentationController {
        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .large
        }
    }
}
```

![animateChanges selectedDetentIdentifier](https://user-images.githubusercontent.com/51053410/213129972-731fcd63-6347-4adc-838b-36709cf1a0ea.gif)

