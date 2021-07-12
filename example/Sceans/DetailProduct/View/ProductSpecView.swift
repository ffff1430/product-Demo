//
//  ProductSpecView.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import UIKit

class ProductSpecView: UIView {
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "id"
        return label
    }()
    
    lazy var idLabelContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var productId: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "productId"
        return label
    }()
    
    lazy var productIdContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "name"
        return label
    }()
    
    lazy var nameContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var quantity: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "quantity"
        return label
    }()
    
    lazy var quantityContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
    
    func setLabel() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabelContent.translatesAutoresizingMaskIntoConstraints = false
        productId.translatesAutoresizingMaskIntoConstraints = false
        productIdContent.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        nameContent.translatesAutoresizingMaskIntoConstraints = false
        quantity.translatesAutoresizingMaskIntoConstraints = false
        quantityContent.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(idLabel)
        addSubview(idLabelContent)
        addSubview(productId)
        addSubview(productIdContent)
        addSubview(name)
        addSubview(nameContent)
        addSubview(quantity)
        addSubview(quantityContent)
        
        idLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70).isActive = true
        idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        idLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
    
        productId.centerXAnchor.constraint(equalTo: idLabel.centerXAnchor).isActive = true
        productId.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20).isActive = true
        productId.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        productId.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
        
        name.centerXAnchor.constraint(equalTo: idLabel.centerXAnchor).isActive = true
        name.topAnchor.constraint(equalTo: productId.bottomAnchor, constant: 20).isActive = true
        name.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        name.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
        
        quantity.centerXAnchor.constraint(equalTo: idLabel.centerXAnchor).isActive = true
        quantity.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
        quantity.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        quantity.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
        
        idLabelContent.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor).isActive = true
        idLabelContent.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 5).isActive = true
        idLabelContent.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        idLabelContent.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
        
        productIdContent.centerYAnchor.constraint(equalTo: productId.centerYAnchor).isActive = true
        productIdContent.leadingAnchor.constraint(equalTo: productId.trailingAnchor, constant: 5).isActive = true
        productIdContent.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        productIdContent.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
        
        nameContent.centerYAnchor.constraint(equalTo: name.centerYAnchor).isActive = true
        nameContent.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 5).isActive = true
        nameContent.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        nameContent.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
        
        quantityContent.centerYAnchor.constraint(equalTo: quantity.centerYAnchor).isActive = true
        quantityContent.leadingAnchor.constraint(equalTo: quantity.trailingAnchor, constant: 5).isActive = true
        quantityContent.heightAnchor.constraint(equalTo: idLabel.heightAnchor, multiplier: 1).isActive = true
        quantityContent.widthAnchor.constraint(equalTo: idLabel.widthAnchor, multiplier: 1).isActive = true
    }
    
}
