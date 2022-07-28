import UIKit

class LALoginViewController: UIViewController {
    
    @IBOutlet weak private var heightLabelError: NSLayoutConstraint!
    
    @IBOutlet weak private var errorLabel: UILabel!
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var createAccountButton: UIButton!
    @IBOutlet weak private var showPasswordButton: UIButton!
    
    private var passwordFieldIsSecure = true
    private var formLoginIsInvalid = false
    
    private var badNetworkLayer: LABadNetworkLayer = LABadNetworkLayer()
    
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
    
    private func configView() {
        self.configInitView()
        self.configLoginButton()
        self.configCreateAccountButton()
        self.configGestureTapInView()
    }
    
    private func configInitView() {
        heightLabelError.constant = 0
        showPasswordButton.tintColor = .lightGray
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    private func configLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    private func configCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    private func configGestureTapInView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc
    private func didClickView() {
        view.endEditing(true)
    }
    
    private func configPasswordTextField() {
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
    
    private func initTextFieldValue() {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "Abcde"
#endif
    }
    
    private func verifyUserLoggedAndNavegateToHome() {
        let userIsLogged = verifyIfUserIsLogged()
        if userIsLogged {
            LALoginCoordinator.shared.navigateToHomeRoot()
        }
    }
    
    private func verifyIfUserIsLogged() -> Bool {
        let userSession = UserDefaultsManager.UserInfos.shared.readSesion()
        let hasUserLogged = userSession != nil
        return hasUserLogged
    }
    
    @IBAction private func handleLoginButton(_ sender: Any) {
        let nextStep = getNextStepToLogin()
        switch nextStep {
        case .invalidData:
            LALoginCoordinator.shared.alertMessage(title: "Ops..",
                                                   message: "Verifique os dados informados e tente novamente!",
                                                   controller: self)
        case .noInternet:
            LALoginCoordinator.shared.showNoInternetConnection(controller: self)
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
        
        badNetworkLayer.login(self, parameters: parametersAuthRequest) { result in
            guard let session = result else {
                self.handleLoginFailure()
                return
            }
            
            self.handleLoginSuccess(with: session)
        }
    }
    
    private func handleLoginSuccess(with session: Session) {
        UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        LALoginCoordinator.shared.navigateToHomeRoot()
    }
    
    private func handleLoginFailure() {
        self.setErrorLogin("E-mail ou senha incorretos")
        LALoginCoordinator.shared.alertMessage(title: "Ops..",
                                               message: "Houve um problema, tente novamente mais tarde.",
                                               controller: self)
    }
    
    private func setErrorLogin(_ message: String) {
        formLoginIsInvalid = true
        heightLabelError.constant = 20
        errorLabel.text = message
        emailTextField.setErrorColor()
        passwordTextField.setErrorColor()
    }
    
    
    @IBAction private func showOrHidePasswordFieldValue(_ sender: Any) {
        passwordFieldIsSecure = !passwordFieldIsSecure
        configPasswordTextField()
    }
    
    @IBAction private func navigateToResetPassword(_ sender: Any) {
        LALoginCoordinator.shared.navigateToResetPassword(controller: self)
    }
    
    
    @IBAction private func navigateToCreateAccount(_ sender: Any) {
        LALoginCoordinator.shared.navigateToCreateAccount(controller: self)
    }
}

// MARK: - Validação e Desativação de Formulário
private extension LALoginViewController {
    func validateForm() {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            disableFormButton()
            return
        }
        
        let emailIsValid = LAEmailValidatorUseCase.shared.isEmailValid(emailText)
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
