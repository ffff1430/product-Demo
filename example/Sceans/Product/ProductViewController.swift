//
//  ProductViewController.swift
//  example
//
//  Created by B1591 on 2021/5/4.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SHOPSwift

class ProductViewController: UIViewController {
    
    private var viewModel: ProductViewModel
    
    private var tableVeiw = UITableView()
    
    private var disposeBag = DisposeBag()
    
    private var product: [ProductDto] = []
        
    init(viewModel: ProductViewModel){
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableVeiw.reloadData()
        }
    }
    
    //創建畫面
    private func setupUI() {
        self.title = "Product"
        tableVeiw.separatorStyle = .none
        tableVeiw.estimatedRowHeight = 190
        view.addSubview(tableVeiw)
        tableVeiw.tableViewEqualTo(view: view)
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissAction))
        navigationItem.leftBarButtonItem = backButton
        let uploadButton = UIBarButtonItem(image: UIImage(named: "add"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(addProduct))
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    @objc public func dismissAction() {
        self.viewModel.usersButtonDismiss()
    }
    
    //
    @objc public func addProduct() {
        moveIn()
        add(AddProductViewController(viewModel: viewModel, type: .post, titleName: "Add Product", buttonName: "Add Button", productDto: product[0], index: 0))
    }
    
    //建立ViewModel
    func bindViewModel() {
        let input = ProductViewModel.Input(ready: rx.viewWillAppear.asDriver())
        
        let output = viewModel.transform(input: input)
        
        tableVeiw.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        output.loading
            .drive(onNext: { loading in
                CustomProgressHUD().loading(loading: loading)
            })
            .disposed(by: disposeBag)
        
        //把資料丟進全域變數的product
        output.product
            .subscribe(onNext: { product in
                self.product = product
            })
            .disposed(by: disposeBag)
        
        //設定tableView的資料
        output.product
            .asDriver()
            .drive(tableVeiw.rx.items(cellIdentifier: ItemTableViewCell.identifier, cellType: ItemTableViewCell.self)) { row, element, cell in
                cell.cardView.catImageView.image = UIImage(named: element.name ?? "")
                cell.cardView.nameLabel.text = element.name
                cell.cardView.priceLabel.text = String(element.listPrice ?? 0)
            }
            .disposed(by: disposeBag)
        
        //切換頁面
        tableVeiw.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.viewModel.usersButtonPressedAtDetail()
            })
            .disposed(by: disposeBag)
    }
}

extension ProductViewController: UITableViewDelegate {
    
    //更新tableView的資料
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let putAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, complete) in
            let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell
            self.viewModel.getEditInfo = { product in
                let url = URL(string: "https://picsum.photos/id/1\(Int(product.unitCost ?? 0))/400/300")
                cell?.cardView.catImageView.sd_setImage(with: url, completed: .none)
                cell?.cardView.nameLabel.text = product.name
                cell?.cardView.priceLabel.text = String(product.listPrice ?? 0)
            }
            
            self.moveIn()
            self.add(AddProductViewController(viewModel: self.viewModel, type: .put, titleName: "Put Product", buttonName: "Put Product", productDto: self.product[indexPath.row], index: indexPath.row))
            
            complete(true)
        }
        putAction.backgroundColor = .yellow
        putAction.image = UIImage(named: "writing")
        
        let swipe = UISwipeActionsConfiguration(actions: [putAction])
        return swipe
    }
}

extension UIViewController {
    //呼叫AddProductViewController的頁面
    func add(_ child: UIViewController) {
        addChild(child)
        
        let widthScreen = UIScreen.main.bounds.width
        let heightScreen = UIScreen.main.bounds.height
        
        child.view.frame = CGRect(x: 0, y: 0, width: widthScreen, height: heightScreen)
        
        self.navigationController?.navigationBar.alpha = 0
        view.addSubview(child.view)
        
        child.didMove(toParent: self)
    }
    
    //呼叫AddProductViewController的頁面動畫
    func moveIn() {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0

            UIView.animate(withDuration: 0.24) {
                self.view.transform = CGAffineTransform.identity
                self.view.alpha = 1.0
            }
        }
    
    //移除AddProductViewController的頁面
    func moveOut() {
        self.navigationController?.navigationBar.alpha = 1
            UIView.animate(withDuration: 0.24, animations: {
                self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
                self.view.alpha = 0.0
            }) { _ in
                self.view.removeFromSuperview()
            }
        }
    
    //navigationber的高度
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }

}



