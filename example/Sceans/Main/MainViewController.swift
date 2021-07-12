//
//  MainViewController.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import UIKit
import SideMenu
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel
    
    private lazy var collectionView = UICollectionView()
    
    private var fullScreenSize = UIScreen.main.bounds.size
    
    private var disposeBag = DisposeBag()
    
    private var isTurnoffsideMenu = true
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform()
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.repos
            .drive(collectionView.rx.items(cellIdentifier: MainCollectionViewCell.identifier, cellType: MainCollectionViewCell.self)) { (row, element, cell) in
                cell.imageView.image = UIImage(named: element.image)
                cell.nameLabel.text = element.name
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { row in
                switch row {
                case [0, 3]:
                    self.viewModel.usersButtonPressedAtRole()
                case [0, 0]:
                    self.viewModel.usersButtonPressedAtProduct()
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.title = "Main"
        let backButton = UIBarButtonItem(image: UIImage(named: "MenuItem"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissAction))
        navigationItem.leftBarButtonItem = backButton
        let layout = UICollectionViewFlowLayout()
        layout.size(width: fullScreenSize.width, height: fullScreenSize.height)
        
        collectionView = UICollectionView(frame: CGRect(
                                            x: 0, y: 0,
                                            width: fullScreenSize.width,
                                            height: fullScreenSize.height),
                                          collectionViewLayout: layout)
        collectionView.collectionViewRegister(view: view)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func setupSideMenu() {
        let sideMenu = SideMenuViewController(viewModel: viewModel)
        let menu = SideMenuNavigationController(rootViewController: sideMenu)
        menu.settings.presentationStyle = .menuSlideIn
        SideMenuManager.default.leftMenuNavigationController = menu
        
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        present(menu, animated: true, completion: nil)
    }
    
    @objc public func dismissAction() {
        setupSideMenu()
    }
}

extension UICollectionView {
    func collectionViewRegister(view: UIView) {
        self.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        self.register(UICollectionReusableView.self,
                      forSupplementaryViewOfKind:
                        UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: "Header")
        self.register(UICollectionReusableView.self,
                      forSupplementaryViewOfKind:
                        UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: "Footer")
    }
}

extension UICollectionViewFlowLayout {
    func size(width: CGFloat, height: CGFloat) {
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        
        // 設置每一行的間距
        self.minimumLineSpacing = 15
        
        // 設置每個 cell 的尺寸
        let itemWidth = width / 2 - 20
        let itemHeight: CGFloat = 130
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // 設置 header 及 footer 的尺寸
        self.headerReferenceSize = CGSize(
            width: width, height: 10)
        self.footerReferenceSize = CGSize(
            width: width, height: 20)
    }
}
