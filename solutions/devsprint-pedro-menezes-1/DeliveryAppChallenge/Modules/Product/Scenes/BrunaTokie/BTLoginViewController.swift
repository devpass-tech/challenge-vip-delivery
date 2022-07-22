import UIKit

class BTLoginViewController: UIViewController {
    
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var showPassword = true
    @IBOutlet weak var showPasswordButton: UIButton!
    var errorInLogin = false
    var coordinator = BTLoginCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyLogin()
        self.setupTextFieldsEnabledDebugBuild()
        self.setupView()
        self.validateButton()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func loginButton(_ sender: Any) {
        if ConnectivityManager.shared.isConnected {
            showLoading()
            requestLogin()
        } else {
            let alert = coordinator.createAlertWhenConectionFailed(
                title: "Sem conexão",
                message: "Conecte-se à internet para tentar novamente",
                actionTitle: "Ok"
            )
            present(alert, animated: true)
        }
    }

    //Falta refatorar aqui
    @IBAction func configurePasswordPresentation(_ sender: Any) {
        if(showPassword == true) {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage.init(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage.init(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        showPassword = !showPassword
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        let resetPasswordViewController = coordinator.goToResetPasswordView()
        present(resetPasswordViewController, animated: true)
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        let createAccountViewController = coordinator.goToCreateAccountView()
        present(createAccountViewController, animated: true)
    }

    func setupTextFieldsEnabledDebugBuild () {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
#endif
    }

    func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            coordinator.goToHomeView()
        }
    }

    func requestLogin() {
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

    func handleLogindResult(_ result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            self.handleRequestSuccess(data: data)
        case .failure:
            self.handleRequestFailure()
        }
    }

    func handleRequestSuccess(data: Data) {
        do {
            let session = try decodeUser(data: data)
            coordinator.goToHomeView()
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        } catch {
            Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
        }
    }

    func decodeUser(data: Data) throws -> Session {
        let decoder = JSONDecoder()
        do {
            let session = try decoder.decode(Session.self, from: data)
            return session
        } catch {
            throw error
        }
    }

    func handleRequestFailure() {
        self.setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
    }
}

// MARK: - Comportamentos de layout
extension BTLoginViewController {
    //Falta refatorar aqui
    func setupView() {
        heightLabelError.constant = 0
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true

        showPasswordButton.tintColor = .lightGray

        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
        
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        validateButton()
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
        validateButton()
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
        validateButton()
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        passwordTextField.setDefaultColor()
    }
    
    func setErrorLogin(_ message: String) {
        errorInLogin = true
        heightLabelError.constant = 20
        errorLabel.text = message
        emailTextField.setErrorColor()
        passwordTextField.setErrorColor()
    }
    
    func resetErrorLogin(_ textField: UITextField) {
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
    
    func validateButton() {
        let emailContainsDot = emailTextField.text?.contains(".") ?? false
        let emailContainsAt = emailTextField.text?.contains("@") ?? false
        let emailHasValidSize = emailTextField.text?.count ?? 0 > 5
        let emailIsValid = emailContainsDot && emailContainsAt && emailHasValidSize

        if emailIsValid {
            handleEmailIsValid()
        } else {
            disableButton()
        }
    }

    func handleEmailIsValid() {
        guard let atIndex = emailTextField.text!.firstIndex(of: "@") else { return disableButton() }
        let substring = emailTextField.text![atIndex...]
        substring.contains(".") ? enableButton() : disableButton()
    }

    func disableButton() {
        loginButton.backgroundColor = .gray
        loginButton.isEnabled = false
    }
    
    func enableButton() {
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = true
    }
}
