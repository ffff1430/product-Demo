//
//  TableViewConstraints.swift
//  example
//
//  Created by B1591 on 2021/4/28.
//
import UIKit

extension UITableView {
    func tableViewEqualTo(view: UIView) {
        rowHeight = 260
        backgroundColor = .gray
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
    }
}
