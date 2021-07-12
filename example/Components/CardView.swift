//
//  CardView.swift
//  example
//
//  Created by B1591 on 2021/6/15.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 5

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = Color.primaryColor()
    @IBInspectable var shadowOpacity: Float = 1
    
    var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = Color.primaryColor()
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        
        setImageView()
        setLabel()
    }
    
    private func setImageView() {
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(catImageView)
        catImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        catImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        catImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        catImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    private func setLabel() {
        addSubview(nameLabel)
        addSubview(priceLabel)
        
        nameLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: catImageView.leadingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 5).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: catImageView.trailingAnchor).isActive = true
    }
}
