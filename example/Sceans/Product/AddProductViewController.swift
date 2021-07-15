//
//  AddProductViewController.swift
//  example
//
//  Created by B1591 on 2021/5/6.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import SHOPSwift

enum Type {
    case post
    case put
}

class AddProductViewController: UIViewController {
    
    var viewModel: ProductViewModel
    
    var type: Type
    
    var titleName: String
    
    var buttonName: String
    
    var productDto: ProductDto
    
    private var disposeBag = DisposeBag()
    
    var index: Int
    
    init(viewModel: ProductViewModel, type: Type, titleName: String, buttonName: String, productDto: ProductDto, index: Int){
        self.viewModel = viewModel
        self.type = type
        self.titleName = titleName
        self.buttonName = buttonName
        self.productDto = productDto
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        label.textAlignment = .left
        label.textColor = Color.primaryColor()
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = Color.addProductTextField()
        textField.placeholder = "Fill in your product name"
        return textField
    }()
    
    var listPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var listPriceTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = Color.addProductTextField()
        textField.placeholder = "Fill in your product price"
        return textField
    }()
    
    var attributeLabel: UILabel = {
        let label = UILabel()
        label.text = "Attribute"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var attributeTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = Color.addProductTextField()
        textField.placeholder = "Fill in your product attribute"
        return textField
    }()
    
    var unitCostLabel: UILabel = {
        let label = UILabel()
        label.text = "UnitCost"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var unitCostTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = Color.addProductTextField()
        textField.placeholder = "Fill in your product unitCost"
        return textField
    }()
    
    var addProductButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Color.primaryColor()
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    //建立ViewModel
    func bindViewModel() {
        let addButton = addProductButton.rx.tap
        let backButtonAction = backButton.rx.tap
        
        //新增資料或修改資料
        addButton
            .subscribe(onNext: {
                if self.checkTextFieldisEmpty() {
                    self.alertAction()
                } else {
                    let name = self.nameTextField.text ?? ""
                    let price = Double(self.listPriceTextField.text ?? "") ?? 0
                    let attribute = self.attributeTextField.text ?? ""
                    let unitCost = Double(self.unitCostTextField.text ?? "") ?? 0
                    let id = self.productDto.id ?? ""
                    if self.type == .post {
                        self.viewModel.postProduct(product: ProductCreation(
                                                    attribute: attribute,
                                                    listPrice: price,
                                                    name: name,
                                                    ownerAccountId: self.productDto.ownerAccountId,
                                                    status: ProductCreation.Status(rawValue: self.productDto.status?.rawValue ?? ""),
                                                    unitCost: unitCost))
                    } else {
                        self.viewModel.putProduct(product: ProductUpdates(
                                                    attribute: attribute,
                                                    listPrice: price,
                                                    name: name,
                                                    ownerAccountId: self.productDto.ownerAccountId,
                                                    status: ProductUpdates.Status(rawValue: self.productDto.status?.rawValue ?? ""),
                                                    unitCost: unitCost),
                                                  id: id, index: self.index)
                    }
                    self.moveOut()
                }
            })
            .disposed(by: disposeBag)
        
        //回到前一頁
        backButtonAction
            .subscribe(onNext: {
                self.moveOut()
            })
            .disposed(by: disposeBag)
    }
    
    //警告訊息
    func alertAction() {
        let alertController = UIAlertController(title: "Error",
                                                message: "",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //確認欄位有無空值
    func checkTextFieldisEmpty() -> Bool {
        let name = nameTextField.text ?? ""
        let price = listPriceTextField.text ?? ""
        let attribute = attributeTextField.text ?? ""
        let unitCost = unitCostTextField.text ?? ""
        guard !name.isEmpty, !price.isEmpty, !attribute.isEmpty, !unitCost.isEmpty else {
            return true
        }
        return false
    }
    
    //建立畫面
    func setupUI() {
        if type == .put {
            nameTextField.text = productDto.name
            listPriceTextField.text = "\(productDto.listPrice ?? 0)"
            attributeTextField.text = productDto.attribute
            unitCostTextField.text = "\(productDto.unitCost ?? 0)"
        }
        
        view.backgroundColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        listPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        listPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        attributeLabel.translatesAutoresizingMaskIntoConstraints = false
        attributeTextField.translatesAutoresizingMaskIntoConstraints = false
        unitCostLabel.translatesAutoresizingMaskIntoConstraints = false
        unitCostTextField.translatesAutoresizingMaskIntoConstraints = false
        addProductButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(listPriceLabel)
        view.addSubview(listPriceTextField)
        view.addSubview(attributeLabel)
        view.addSubview(attributeTextField)
        view.addSubview(unitCostLabel)
        view.addSubview(unitCostTextField)
        view.addSubview(addProductButton)
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.text = titleName
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        
        nameTextField.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        listPriceLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        listPriceLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        listPriceLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        
        listPriceTextField.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        listPriceTextField.topAnchor.constraint(equalTo: listPriceLabel.bottomAnchor, constant: 5).isActive = true
        listPriceTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        listPriceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        attributeLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        attributeLabel.topAnchor.constraint(equalTo: listPriceTextField.bottomAnchor, constant: 20).isActive = true
        attributeLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        
        attributeTextField.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        attributeTextField.topAnchor.constraint(equalTo: attributeLabel.bottomAnchor, constant: 5).isActive = true
        attributeTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        attributeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        unitCostLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        unitCostLabel.topAnchor.constraint(equalTo: attributeTextField.bottomAnchor, constant: 20).isActive = true
        unitCostLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        
        unitCostTextField.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        unitCostTextField.topAnchor.constraint(equalTo: unitCostLabel.bottomAnchor, constant: 5).isActive = true
        unitCostTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        unitCostTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addProductButton.setTitle(buttonName, for: .normal)
        addProductButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        addProductButton.topAnchor.constraint(equalTo: unitCostTextField.bottomAnchor, constant: 40).isActive = true
        addProductButton.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1).isActive = true
        addProductButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}


