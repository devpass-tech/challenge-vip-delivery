import UIKit

class BTLoginViewController: UIViewController {
    
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    var showPassword = true
    var errorInLogin = false
    let coordinator = BTLoginCoordinator()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        verifyLogin()
        self.setupTextFieldsEnabledDebugBuild()
        self.setupView()
        self.validateEmailButton()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func loginButton(_ sender: Any) {
        if ConnectivityManager.shared.isConnected {
            requestLogin()
        } else {
            let alert = coordinator.createAlertWhenConectionFailed(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", actionTitle: "Ok")
        }
    }

    @IBAction func configurePasswordPresentation(_ sender: Any) {
        let imageName = showPassword ? "eye.slash" : "eye"
        showPasswordButton.setImage(
            UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        showPassword ? (passwordTextField.isSecureTextEntry = false) : (passwordTextField.isSecureTextEntry = true)
        showPassword = !showPassword
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
       coordinator.goToResetPasswordView()
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        coordinator.goToCreateAccountView()
    }

    private func setupTextFieldsEnabledDebugBuild () {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
#endif
    }

    private func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            coordinator.goToHomeView()
        }
    }

    private func requestLogin() {
        showLoading()
        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        let endpoint = Endpoints.Auth.login
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            DispatchQueue.main.async {
                self.stopLoading()
                self.handleLogindResult(result)
            }
        }
    }

    private func handleLogindResult(_ result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            self.handleRequestSuccess(with: data)
        case .failure:
            self.handleRequestFailure()
        }
    }

    private func handleRequestSuccess(with data: Data) {
        do {
            let session = try decodeUser(with: data)
            coordinator.goToHomeView()
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        } catch {
            Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
        }
    }

    private func decodeUser(with data: Data) throws -> Session {
        let decoder = JSONDecoder()
        let session = try decoder.decode(Session.self, from: data)
        return session
    }

    private func handleRequestFailure() {
        self.setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
    }
}

// MARK: - Comportamentos de layout
extension BTLoginViewController {

    private func setupView() {
        heightLabelError.constant = 0
        showPasswordButton.tintColor = .lightGray
        setupLoginButton()
        setupCreateAccountButton()
        setupGesture()
        validateEmailButton()
        setupTextfieldColor()
    }

    private func setupLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }

    private func setupCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }

    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }

    private func setupTextfieldColor() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }


    @objc
    func didClickView() {
        view.endEditing(true)
    }
    
    //email
    @IBAction func emailBeginEditing(_ sender: Any) {
        if errorInLogin {
            resetErrorLogin(emailTextField)
        } else {
            emailTextField.setEditingColor()
        }
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        validateEmailButton()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        emailTextField.setDefaultColor()
    }
    
    //senha
    @IBAction func passwordBeginEditing(_ sender: Any) {
        if errorInLogin {
            resetErrorLogin(passwordTextField)
        } else {
            passwordTextField.setEditingColor()
        }
    }
    
    @IBAction func passwordEditing(_ sender: Any) {
        validateEmailButton()
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        passwordTextField.setDefaultColor()
    }
    
    private func setErrorLogin(_ message: String) {
        errorInLogin = true
        heightLabelError.constant = 20
        errorLabel.text = message
        emailTextField.setErrorColor()
        passwordTextField.setErrorColor()
    }
    
    private func resetErrorLogin(_ textField: UITextField) {
        heightLabelError.constant = 0
        if textField == emailTextField {
            emailTextField.setEditingColor()
            passwordTextField.setDefaultColor()
        } else {
            emailTextField.setDefaultColor()
            passwordTextField.setDefaultColor()
        }
    }
}

extension BTLoginViewController {
    
    private func validateEmailButton() {
        let isEmailTextFieldValid = emailTextField.isPasswordTextFieldValid(withText: emailTextField.text)
        if isEmailTextFieldValid {
            handleEmailIsValid()
        } else {
            disableButton()
        }
    }

    private func handleEmailIsValid() {
        guard let atIndex = emailTextField.text!.firstIndex(of: "@") else { return disableButton() }
        let substring = emailTextField.text![atIndex...]
        substring.contains(".") ? enableButton() : disableButton()
    }

    private func disableButton() {
        loginButton.backgroundColor = .gray
        loginButton.isEnabled = false
    }
    
    private func enableButton() {
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = true
    }
}


