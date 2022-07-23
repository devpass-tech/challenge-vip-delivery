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
       
        let userIsLogged = verifyIfUserIsLogged()
        if(userIsLogged) {
            LALoginCoordinator.shared.navigateToHomeRoot()
        }

        #if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "Abcde"
        #endif

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
extension LALoginViewController {
    @IBAction func emailBeginEditing(_ sender: Any) {
        if formLoginIsInvalid {
            resetErrorLogin(emailTextField)
        } else {
            emailTextField.setEditingColor()
        }
    }
    
    @IBAction func passwordBeginEditing(_ sender: Any) {
        if formLoginIsInvalid {
            resetErrorLogin(passwordTextField)
        } else {
            passwordTextField.setEditingColor()
        }
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
    
    @IBAction func emailEditing(_ sender: Any) {
        validateForm()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        emailTextField.setDefaultColor()
    }
    
    @IBAction func passwordEditing(_ sender: Any) {
        validateForm()
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        passwordTextField.setDefaultColor()
    }
}

// MARK: - Funções
extension LALoginViewController {
    
    func verifyIfUserIsLogged() -> Bool {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            return true
        }
        
        return false
    }
    
    @IBAction func handleLoginButton(_ sender: Any) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            Globals.alertMessage(title: "Ops..", message: "Verifique os dados informados e tente novamente!", targetVC: self)
            return
        }
        
        let deviceIsDisconnectedInternet = !ConnectivityManager.shared.isConnected
        if deviceIsDisconnectedInternet {
            Globals.showNoInternetCOnnection(controller: self)
            return
        }
        
        handleLoginRequest(email: emailText, password: passwordText)
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
        
        if(emailIsValid && passwordIsValid) {
            enableFormButton()
			return
        }
        
        disableFormButton()
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
