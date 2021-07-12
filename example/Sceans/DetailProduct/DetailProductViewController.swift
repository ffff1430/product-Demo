//
//  DetailProductViewController.swift
//  example
//
//  Created by B1591 on 2021/5/4.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa

class DetailProductViewController: UIViewController {
    
    private var viewModel: DetailProductViewModel
    
    private var disposeBag = DisposeBag()
    
    init(viewModel: DetailProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var productSpecButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Transportation", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    
    private let productView = ProductSpecView()
    
    private let producrDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        let input = DetailProductViewModel.Input(ready: rx.viewWillAppear.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.productSpec
            .drive(onNext: { products in
                for product in products {
                    guard let name = product.name else { return }
                    self.producrDropDown.dataSource.append(name)
                }
                self.producrDropDown.selectionAction = { [weak self] (index, item) in
                    self?.productSpecButton.setTitle(item, for: .normal)
                    self?.productView.idLabelContent.text = products[index].id
                    self?.productView.nameContent.text = products[index].name
                    self?.productView.productIdContent.text = products[index].productId
                    self?.productView.quantityContent.text = "\(products[index].quantity ?? 0)"
                }
            })
            .disposed(by: disposeBag)
        
        productSpecButton.rx.tap
            .subscribe(onNext: {
                self.producrDropDown.show()
            })
            .disposed(by: disposeBag)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        producrDropDown.bottomOffset = CGPoint(x: 0, y: productSpecButton.bounds.height)
    }
    
    private func setupUI() {
        view.addSubview(productSpecButton)
        view.addSubview(productView)
        productView.productEqualTo(view: view, button: productSpecButton)
        productSpecButton.dropDownButtonEqualTO(view: view)
        
        producrDropDown.anchorView = productSpecButton
    }
}

extension UIButton {
    func dropDownButtonEqualTO(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
}

extension UIView {
    func productEqualTo(view: UIView, button: UIButton) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 8/10).isActive = true
        heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
}
