import UIKit



class LALoginViewController: UIViewController {
    
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    var passwordFieldIsSecure = true
    var formLoginIsInvalid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.verifyUserLoggedAndNavegateToHome()
        self.initTextFieldValue()
        
        self.configView()
        self.validateForm()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Configurações de Layout
extension LALoginViewController {
    
    func configView() {
        self.configInitView()
        self.configLoginButton()
        self.configCreateAccountButton()
        self.configGestureTapInView()
    }
    
    func configInitView() {
        heightLabelError.constant = 0
        showPasswordButton.tintColor = .lightGray
        
        emailTextField.setDefaultColor()
        emailTextField.delegate = self
        passwordTextField.setDefaultColor()
        passwordTextField.delegate = self
    }
    
    func configLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    func configCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    func configGestureTapInView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc
    func didClickView() {
        view.endEditing(true)
    }
    
    func configPasswordTextField() {
        let imageIcon: UIImage? = passwordFieldIsSecure ? .init(systemName: "eye") : .init(systemName: "eye.slash")
        passwordTextField.isSecureTextEntry = passwordFieldIsSecure
        showPasswordButton.setImage((imageIcon ?? UIImage()).withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    
}

// MARK: - Edição de Campos
extension LALoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField) {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if formLoginIsInvalid {
            resetErrorLogin(textField)
        } else {
            textField.setEditingColor()
        }
        
        return true
    }
    
    func resetErrorLogin(_ textField: UITextField) {
        heightLabelError.constant = 0
        
        switch(textField) {
        case emailTextField:
            emailTextField.setEditingColor()
            passwordTextField.setDefaultColor()
        default:
            emailTextField.setDefaultColor()
            passwordTextField.setDefaultColor()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validateForm()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.setDefaultColor()
        
        return true
    }
}

// MARK: - Funções
extension LALoginViewController {
    
    func initTextFieldValue() {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "Abcde"
#endif
    }
    
    func verifyUserLoggedAndNavegateToHome() {
        let userIsLogged = verifyIfUserIsLogged()
        if userIsLogged {
            LALoginCoordinator.shared.navigateToHomeRoot()
        }
    }
    
    func verifyIfUserIsLogged() -> Bool {
        let userSession = UserDefaultsManager.UserInfos.shared.readSesion()
        let hasUserLogged = userSession != nil
        return hasUserLogged
    }
    
    @IBAction func handleLoginButton(_ sender: Any) {
        let nextStep = getNextStepToLogin()
        switch nextStep {
        case .invalidData:
            Globals.alertMessage(title: "Ops..", message: "Verifique os dados informados e tente novamente!", targetVC: self)
        case .noInternet:
            Globals.showNoInternetCOnnection(controller: self)
        case .loginRequest(let email, let password):
            handleLoginRequest(email: email, password: password)
        }
    }
    
    private func getNextStepToLogin() -> StepToLogin {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            return .invalidData
        }
        
        let deviceIsDisconnectedInternet = !ConnectivityManager.shared.isConnected
        if deviceIsDisconnectedInternet {
            return .noInternet
        }
        
        return .loginRequest(email: emailText, password: passwordText)
    }
    
    private func handleLoginRequest(email: String, password: String) {
        let parametersAuthRequest = ["email": email, "password": password]
        let authEndpoint = Endpoints.Auth.login
        
        showLoading()
        
        AF.request(authEndpoint, method: .get, parameters: parametersAuthRequest, headers: nil) { result in
            DispatchQueue.main.async {
                self.stopLoading()
                switch result {
                case .success(let data):
                    self.handleLoginSuccess(with: data)
                case .failure:
                    self.handleLoginFailure()
                }
            }
        }
    }
    
    private func handleLoginSuccess(with data: Data) {
        let decoder = JSONDecoder()
        if let session = try? decoder.decode(Session.self, from: data) {
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
            LALoginCoordinator.shared.navigateToHomeRoot()
        } else {
            Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
        }
    }
    
    private func handleLoginFailure() {
        self.setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
    }
    
    func setErrorLogin(_ message: String) {
        formLoginIsInvalid = true
        heightLabelError.constant = 20
        errorLabel.text = message
        emailTextField.setErrorColor()
        passwordTextField.setErrorColor()
    }
    
    
    @IBAction func showOrHidePasswordFieldValue(_ sender: Any) {
        passwordFieldIsSecure = !passwordFieldIsSecure
        configPasswordTextField()
    }
    
    @IBAction func navigateToResetPassword(_ sender: Any) {
        LALoginCoordinator.shared.navigateToResetPassword(controller: self)
    }
    
    
    @IBAction func navigateToCreateAccount(_ sender: Any) {
        LALoginCoordinator.shared.navigateToCreateAccount(controller: self)
    }
}

// MARK: - Validação e Desativação de Formulário
extension LALoginViewController {
    func validateForm() {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            disableFormButton()
            return
        }
        
        let emailIsValid = Validations.shared.isEmail(emailText)
        let passwordIsValid = passwordText.count > 0
        let formIsValid = emailIsValid && passwordIsValid
        
        formIsValid ? enableFormButton() : disableFormButton()
    }
    
    func disableFormButton() {
        loginButton.backgroundColor = .gray
        loginButton.isEnabled = false
    }
    
    func enableFormButton() {
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = true
    }
}
