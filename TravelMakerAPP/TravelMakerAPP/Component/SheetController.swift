//
//  SheetController.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/28/24.
//

import SwiftUI

// MARK: - Public

@available(iOS 15.0, *)
public extension View {
    /// Adds a sheet which respects `UISheetPresentationController` detents.
    ///
    /// Example:
    /// ```
    /// struct ContentView: View {
    ///     @State
    ///     var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium
    ///     var body: some View {
    ///         Button("Toggle Sheet") {
    ///             withAnimation {
    ///                 isSheetPresented.toggle()
    ///             }
    ///         }.detentSheet(isPresented: $isSheetPresented, largestUndimmedDetentIdentifier: .medium, allowsDismissalGesture: true) {
    ///             Text("Sheet View")
    ///         }
    ///     }
    /// }
    ///
    /// 
    /// ```
    /// - Parameters:
    ///isPresented: 시트가 표시되는지 여부를 나타내는 Boolean 값입니다.
    ///selectedDetentIdentifier: 가장 최근에 선택된 detent의 식별자입니다.
    ///largestUndimmedDetentIdentifier: 시트 아래의 뷰를 어둡게 만들지 않는 가장 큰 detent의 식별자입니다.
    ///prefersScrollingExpandsWhenScrolledToEdge: 스크롤이 시트를 더 큰 detent로 확장하는지 여부를 결정하는 Boolean 값입니다.
    ///prefersGrabberVisible: 시트 상단에 그랩버를 표시할지 여부를 결정하는 Boolean 값입니다.
    ///prefersEdgeAttachedInCompactHeight: Compact-height 사이즈 클래스에서 시트가 화면 하단 가장자리에 붙는지 여부를 결정하는 Boolean 값입니다.
    ///widthFollowsPreferredContentSizeWhenEdgeAttached: 시트의 너비가 해당 뷰 컨트롤러의 선호 콘텐츠 크기와 일치하는지 여부를 결정하는 Boolean 값입니다.
    ///preferredCornerRadius: 시트가 표시될 때 시도하는 모서리 반지름입니다.
    ///detents: 시트가 머무를 수 있는 높이 배열입니다.
    ///allowsDismissalGesture: 스와이프로 해제 제스처를 활성화할지 여부를 결정하는 Boolean 값입니다.
    ///background: 시트 뒤에 표시되는 보조 뷰입니다.
    ///sheet: 시트로 표시될 뷰입니다.
    /// - Returns: A new view with that wraps the receiver and given sheet.
    func detentSheet<Sheet: View>(isPresented: Binding<Bool>,
                                  selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>? = nil,
                                  largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
                                  prefersScrollingExpandsWhenScrolledToEdge: Bool = true,
                                  prefersGrabberVisible: Bool = false,
                                  prefersEdgeAttachedInCompactHeight: Bool = false,
                                  widthFollowsPreferredContentSizeWhenEdgeAttached: Bool = false,
                                  preferredCornerRadius: CGFloat? = nil,
                                  detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
                                  allowsDismissalGesture: Bool = true,
                                  @ViewBuilder sheet: () -> Sheet) -> some View {
        self.modifier(DetentSheetPresenter(largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                                           prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                                           prefersGrabberVisible: prefersGrabberVisible,
                                           prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                                           widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                                           preferredCornerRadius: preferredCornerRadius,
                                           detents: detents,
                                           allowsDismissalGesture: allowsDismissalGesture,
                                           selectedDetentIdentifier: selectedDetentIdentifier,
                                           isSheetPresented: isPresented,
                                           sheet: sheet))
    }
}


// MARK: - Internal

@available(iOS 15.0, *)
struct DetentSheetPresenter<Sheet: View>: ViewModifier {
    
    var customDetentResolver: (UISheetPresentationControllerDetentResolutionContext) -> CGFloat? = { context in
        var sheetSize: CGFloat = UIScreen.main.bounds.height * 0.38
        return sheetSize // 또는 다른 원하는 높이 값
    }

    
    init(largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
         prefersScrollingExpandsWhenScrolledToEdge: Bool,
         prefersGrabberVisible: Bool,
         prefersEdgeAttachedInCompactHeight: Bool,
         widthFollowsPreferredContentSizeWhenEdgeAttached: Bool,
         preferredCornerRadius: CGFloat?,
         detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
         allowsDismissalGesture: Bool,
         selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?,
         isSheetPresented: Binding<Bool>,
         @ViewBuilder sheet: () -> Sheet) {
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.preferredCornerRadius = preferredCornerRadius
        self.detents = detents
        self.allowsDismissalGesture = allowsDismissalGesture
        self.selectedDetentIdentifier = selectedDetentIdentifier
        self._isSheetPresented = isSheetPresented
        self.sheet = sheet()
    }
    
    func body(content: Content) -> some View {
        DetentSheetStack(isSheetPresented: $isSheetPresented,
                         selectedDetentIdentifier: selectedDetentIdentifier,
                         largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                         prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                         prefersGrabberVisible: prefersGrabberVisible,
                         prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                         widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                         preferredCornerRadius: preferredCornerRadius,
                         detents: detents,
                         allowsDismissalGesture: allowsDismissalGesture,
                         background: { content },
                         sheet: { sheet })
    }
    
    @Binding
    var isSheetPresented: Bool
    var selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?
    let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersGrabberVisible: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    let preferredCornerRadius: CGFloat?
    let detents: [UISheetPresentationController.Detent]
    let allowsDismissalGesture: Bool
    let sheet: Sheet
}

// MARK: Wrapping View

@available(iOS 15.0, *)
struct DetentSheetStack<Background: View, Sheet: View>: UIViewControllerRepresentable {
    init(isSheetPresented: Binding<Bool>,
         selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?,
         largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?,
         prefersScrollingExpandsWhenScrolledToEdge: Bool,
         prefersGrabberVisible: Bool,
         prefersEdgeAttachedInCompactHeight: Bool,
         widthFollowsPreferredContentSizeWhenEdgeAttached: Bool,
         preferredCornerRadius: CGFloat?,
         detents: [UISheetPresentationController.Detent] = [.medium(), .large()],
         allowsDismissalGesture: Bool,
         @ViewBuilder background: () -> Background,
         @ViewBuilder sheet: () -> Sheet) {
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.prefersGrabberVisible = prefersGrabberVisible
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.preferredCornerRadius = preferredCornerRadius
        self.detents = detents
        self.allowsDismissalGesture = allowsDismissalGesture
        self.selectedDetentIdentifier = selectedDetentIdentifier
        self._isSheetPresented = isSheetPresented
        self.background = background()
        self.sheet = sheet()
    }
    
    typealias UIViewControllerType = UIViewController
    
    func makeCoordinator() -> Coordinator<Background, Sheet> {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        configureSheet(context: context)
        context.coordinator.sheetViewController.isModalInPresentation = !allowsDismissalGesture
        return context.coordinator.sheetPresentingViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        configureSheet(context: context)
    }
    
    final class Coordinator<Background: View, Sheet: View>: NSObject, UISheetPresentationControllerDelegate, SheetViewControllerDelegate {
        var parent: DetentSheetStack<Background, Sheet>
        let sheetViewController: SheetViewController<Sheet>
        let sheetPresentingViewController: SheetPresentingViewController<Background>
        
        init(_ sheetPresenter: DetentSheetStack<Background, Sheet>) {
            parent = sheetPresenter
            let sheetHostingController = SheetViewController(rootView: parent.sheet)
            sheetViewController = sheetHostingController
            sheetPresentingViewController = SheetPresentingViewController(rootView: parent.background,
                                                                          shouldSheetBeInitiallyPresented: parent.isSheetPresented,
                                                                          sheetViewController: sheetHostingController)
            super.init()
        }
        
        func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
            parent.selectedDetentIdentifier?.wrappedValue = sheetPresentationController.selectedDetentIdentifier
        }
        
        func sheetViewControllerDidDismiss<Content>(_ sheetViewController: SheetViewController<Content>) where Content : View {
            parent.isSheetPresented = false
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.isSheetPresented = false
        }
    }
    
    @Binding
    var isSheetPresented: Bool
    var selectedDetentIdentifier: Binding<UISheetPresentationController.Detent.Identifier?>?
    let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersGrabberVisible: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    let preferredCornerRadius: CGFloat?
    let detents: [UISheetPresentationController.Detent]
    let allowsDismissalGesture: Bool
    let background: Background
    let sheet: Sheet
    
    private func configureSheet(context: Context) {
        guard let sheetPresentationController = context.coordinator.sheetViewController.sheetPresentationController else { return }
        let animated = context.transaction.animation != nil && !context.transaction.disablesAnimations
        let presentingViewController = context.coordinator.sheetPresentingViewController
        let configure = {
            sheetPresentationController.selectedDetentIdentifier = selectedDetentIdentifier?.wrappedValue
            sheetPresentationController.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
            sheetPresentationController.prefersGrabberVisible = prefersGrabberVisible
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
            sheetPresentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
            sheetPresentationController.preferredCornerRadius = preferredCornerRadius
            sheetPresentationController.detents = detents
            sheetPresentationController.delegate = context.coordinator
        }
        if animated {
            sheetPresentationController.animateChanges {
                configure()
            }
        } else {
            configure()
        }
        presentingViewController.shouldSheetBeInitiallyPresented = isSheetPresented
        presentingViewController.setSheetPresented(isSheetPresented, animated: animated)
    }
}

// MARK: Supporting UIKit Views

final class SheetPresentingViewController<Content: View>: UIHostingController<Content> {
    let sheetViewController: UIViewController
    var isSheetPresented: Bool { sheetViewController.presentingViewController != nil }
    
    var shouldSheetBeInitiallyPresented: Bool
    
    func setSheetPresented(_ presentSheet: Bool, animated: Bool) {
        guard viewHasAppeared else { return }
        if presentSheet, !isSheetPresented {
            present(sheetViewController, animated: animated, completion: nil)
        } else if !presentSheet, isSheetPresented {
            sheetViewController.dismiss(animated: animated, completion: nil)
        }
    }
    
    init(rootView: Content, shouldSheetBeInitiallyPresented: Bool, sheetViewController: UIViewController) {
        self.shouldSheetBeInitiallyPresented = shouldSheetBeInitiallyPresented
        self.sheetViewController = sheetViewController
        super.init(rootView: rootView)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !viewHasAppeared else { return }
        viewHasAppeared = true
        setSheetPresented(shouldSheetBeInitiallyPresented, animated: animated)
    }
    
    private var viewHasAppeared = false
}

protocol SheetViewControllerDelegate: AnyObject {
    func sheetViewControllerDidDismiss<Content: View>(_ sheetViewController: SheetViewController<Content>)
}

final class SheetViewController<Content: View>: UIHostingController<Content> {
    weak var delegate: SheetViewControllerDelegate?
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: animated, completion: completion)
        delegate?.sheetViewControllerDidDismiss(self)
    }
}

// MARK: Preview

//#if DEBUG
@available(iOS 15.0, *)
struct DetentSheetPreviewView: View {
    @State
    var isSheetPresented = true
    
    @State
    var selectedDetentID: UISheetPresentationController.Detent.Identifier? = .medium
    
    var body: some View {
        VStack {
            Spacer()
            Button("Toggle Sheet1111111") {
                withAnimation {
                    isSheetPresented.toggle()
                }
            }
            Spacer()
            Text("Background View2222222")
            Spacer()
        }
        .detentSheet(isPresented: $isSheetPresented,
                      selectedDetentIdentifier: $selectedDetentID,
                      largestUndimmedDetentIdentifier: .medium,
                      allowsDismissalGesture: true) {
            VStack {
                Spacer()
                Button("Toggle Detent333333") {
                    withAnimation {
                        selectedDetentID = selectedDetentID == .medium ? .large : .medium
                    }
                }
                Spacer()
                Text("Sheet View444444")
                Spacer()
            }
            
        }
    }
}

//@available(iOS 15.0, *)
//struct DetentSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        DetentSheetPreviewView()
//    }
//}
//#endif
