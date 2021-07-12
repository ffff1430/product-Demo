//
//  SideMenuViewController.swift
//  example
//
//  Created by B1591 on 2021/5/3.
//

import UIKit
import RxSwift
import RxCocoa
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class SideMenuViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var tableView = UITableView()
    
    var viewModel: MainViewModel
    
    private var disposeBag = DisposeBag()
    
    lazy var logoutButton: MDCButton = {
        let button = MDCButton()
        button.layer.cornerRadius = 5
        button.applyContainedTheme(withScheme: Color.buttonColor())
        button.setTitle("LogOut", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttonImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "account"), for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
        setTitleinTableView()
        setSideMenuImage()
    }
    
    //view的backgroundcolor漸層顏色效果
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            Color.SideMenuColor1().cgColor,
            Color.SideMenuColor2().cgColor,
            Color.SideMenuColor3().cgColor
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //設定tableView的資料
    func setTitleinTableView() {
        let title = Driver.just(["產品列表", "富邦活動", "行動辦公", "員工福利", "關懷信箱", "員工設定"])
        
        title
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.backgroundColor = .clear
                cell.textLabel?.textColor = .white
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { index in
                switch index {
                case [0, 0]:
                    self.viewModel.usersButtonPressedAtProduct()
                case [0, 3]:
                    self.viewModel.usersButtonPressedAtRole()
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.viewModel.logout()
            })
            .disposed(by: disposeBag)
    }
    
    //創建畫面
    func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        tableView.backgroundColor = .clear
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonImage)
        buttonImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        buttonImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(logoutButton)
        logoutButton.centerYAnchor.constraint(equalTo: buttonImage.centerYAnchor).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: buttonImage.heightAnchor, multiplier: 2/3).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: buttonImage.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setSideMenuImage() {
        buttonImage.rx.tap
            .subscribe(onNext: {
                let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                photoSourceRequestController.addAction(cancelAction)
                
                let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        let imagePicker = UIImagePickerController()
                        imagePicker.allowsEditing = false
                        imagePicker.sourceType = .camera
                        imagePicker.delegate = self
                        
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
                
                let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                        let imagePicker = UIImagePickerController()
                        imagePicker.allowsEditing = false
                        imagePicker.sourceType = .photoLibrary
                        imagePicker.delegate = self
                        
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
                
                photoSourceRequestController.addAction(cameraAction)
                photoSourceRequestController.addAction(photoLibraryAction)
                
                self.present(photoSourceRequestController, animated: true, completion: nil)
            })
            .disposed(by:disposeBag)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            buttonImage.setImage(selectedImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
