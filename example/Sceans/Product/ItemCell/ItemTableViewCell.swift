//
//  ItemTableViewCell.swift
//  example
//
//  Created by B1591 on 2021/4/28.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    public static let identifier = "Cell"
    
    var cardView = CardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cardView)
        
        cardView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 9/10).isActive = true
        cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 9/10).isActive = true
        
    }
    
}
