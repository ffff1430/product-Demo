//
//  MainCollectionViewCell.swift
//  example
//
//  Created by B1591 on 2021/4/27.
//

import UIKit
import MaterialComponents.MaterialCards

class MainCollectionViewCell: MDCCardCollectionCell {
    public static let identifier = "Cell"
    
    lazy var imageView = UIImageView()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.cornerRadius = 4.0;
        self.applyTheme(withScheme: Color.cellColor())
        self.setBorderWidth(1.0, for:.normal)
        self.setBorderColor(.lightGray, for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }
}
