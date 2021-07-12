//
//  LoginViewController.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SHOPSwift
import MaterialComponents
import MaterialComponents

class LoginViewController: UIViewController {
    
    private var viewModel: LoginViewModel
    
    private var disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fubon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "富邦人壽"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    private lazy var usernameTextField: MDCOutlinedTextField = {
        let textField = MDCOutlinedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.applyTheme(withScheme: Color.textFieldColor())
        textField.text = "B1591"
        textField.placeholder = "Enter your Username"
        textField.label.text = "Username"
        return textField
    }()
    
    private lazy var passwordTextField: MDCOutlinedTextField = {
        let textField = MDCOutlinedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.applyTheme(withScheme: Color.textFieldColor())
        textField.isSecureTextEntry = true
        textField.text = "Password1"
        textField.placeholder = "Enter your Password"
        textField.label.text = "Password"
        return textField
    }()
    
    private lazy var loginButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.applyContainedTheme(withScheme: Color.buttonColor())
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isTokenExpired()
    }
    
    private func isTokenExpired() {
        //確認authtoken有沒有過期
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !self.viewModel.isLogin() {
                self.viewModel.usersButtonPressed()
            }
        }
    }
    
    //建立ViewModel
    private func bindViewModel() {
        
        let input = LoginViewModel.Input(username:usernameTextField.rx.text.orEmpty.asDriver(),
                                         password: passwordTextField.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input: input)
        
        //觸發ActivityIndicator
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.loading
            .drive(onNext: { loading in
                CustomProgressHUD().loading(loading: loading)
            })
            .disposed(by: disposeBag)
        
        //登入觸發
        loginButton.rx.tap
            .subscribe(onNext: {
                output.loginResult
                    .drive(onNext: { result in
                        self.viewModel.getAuthToken(authenticationResult: result)
                        guard let success = result.success else { return }
                        if success {
                            self.viewModel.usersButtonPressed()
                        } else {
                            self.showAlert()
                        }
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
    }
    
    //警告訊息
    private func showAlert() {
        let alert = UIAlertController(title: "error",
                                      message: "account or password is false",
                                      preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    //創建畫面
    private func setupUI() {
        self.dismissKey()
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        logoImageView.equalTo(view: view)
        titleLabel.equalTo(imageView: logoImageView)
        usernameTextField.equalToLabel(view: view, titlelabel: titleLabel)
        passwordTextField.equalToUsername(view: view, username: usernameTextField)
        loginButton.equalTo(view: view, password: passwordTextField)
    }
}

extension UIButton {
    
    func equalTo(view: UIView, password: UITextField) {
        centerXAnchor.constraint(equalTo: password.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50).isActive = true
        widthAnchor.constraint(equalTo: password.widthAnchor, multiplier: 1).isActive = true
        heightAnchor.constraint(equalTo: password.heightAnchor, multiplier: 1).isActive = true
    }
}

extension MDCOutlinedTextField {
    
    func equalToLabel(view: UIView, titlelabel: UILabel) {
        centerXAnchor.constraint(equalTo: titlelabel.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 35).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
    }
    
    func equalToUsername(view: UIView, username: UITextField) {
        centerXAnchor.constraint(equalTo: username.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20).isActive = true
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
    }
}

extension UIImageView {
    
    func equalTo(view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        heightAnchor.constraint(equalToConstant: 150).isActive = true
        widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

extension UILabel {
    func equalTo(imageView: UIImageView) {
        centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
    }
}



