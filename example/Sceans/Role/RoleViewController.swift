//
//  RoleViewController.swift
//  example
//
//  Created by B1591 on 2021/4/27.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class RoleViewController: UIViewController {
    
    private var tableView = UITableView()
    
    private var disposeBag = DisposeBag()
    
    private var viewModel: RoleViewModel
    
    init(viewModel: RoleViewModel) {
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
    
    private func setupUI() {
        self.title = "Role"
        view.addSubview(tableView)
        tableView.tableViewEqualTo(view: view)
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(dismissAction))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc public func dismissAction() {
        self.viewModel.usersButtonDismiss()
    }
    
    private func bindViewModel() {
        let input = RoleViewModel.Input(ready: rx.viewWillAppear.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.role
            .drive(tableView.rx.items(cellIdentifier: ItemTableViewCell.identifier, cellType: ItemTableViewCell.self)) { row, element, cell in
                let url = URL(string: "https://picsum.photos/id/1\(row)/400/300")
                cell.cardView.catImageView.sd_setImage(with: url, completed: .none)
                cell.cardView.nameLabel.text = element.menus?[row].id
                cell.cardView.priceLabel.text = element.menus?[row].title
            }
            .disposed(by: disposeBag)
    }
}

