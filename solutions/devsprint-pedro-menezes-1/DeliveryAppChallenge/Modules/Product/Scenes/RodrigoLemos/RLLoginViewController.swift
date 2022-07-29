import UIKit

class RLLoginViewController: UIViewController {

    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!

    var showPassword = true
    var errorInLogin = false
    let coordinator = RLLoginCoordinator()
    let emailUseCase = EmailValidatorUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        verifyIfIsAlreadyLogIn()
        setupView()
        validateButton()
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func verifyIfIsAlreadyLogIn() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            coordinator.showHomeViewController()
        } else {
            setLoginDefaultValue()
        }
    }

    func setLoginDefaultValue() {
        #if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
        #endif
    }

    @IBAction func loginButton(_ sender: Any) {
        let isUserConnected = verifyIfUserHasConnection()
        if isUserConnected {
            startLoginRequest()
        } else {
            coordinator.showNoConnectionAlert(on: self)
        }
    }

    func startLoginRequest() {
        showLoading()

        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        let endpoint = Endpoints.Auth.login

        makeLoginRequest(with: endpoint, and: parameters)
    }

    func verifyIfUserHasConnection() -> Bool {
        if ConnectivityManager.shared.isConnected {
            return true
        } else {
            return false
        }
    }

    func makeLoginRequest(with endpoint: String, and parameters: [String: String]) {
        BadNetworkLayer.shared.login(self, parameters: parameters) { session in
            DispatchQueue.main.async {
                self.handleLoginRequestResult(session: session)
            }
        }
    }

    func handleLoginRequestResult(session: Session?) {
        if let session = session {
            self.coordinator.showHomeViewController()
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        } else {
            self.setErrorLogin("E-mail ou senha incorretos")
            self.coordinator.showRequestError(on: self)
        }
    }

    @IBAction func showPassword(_ sender: Any) {
        showPassword ? configureLayout(toShowPassword: true) : configureLayout(toShowPassword: false)
        showPassword = !showPassword
    }

    func configureLayout(toShowPassword: Bool) {
        let passwordButtonImage = UIImage(named: toShowPassword ? "eye.slash" : "eye")?.withRenderingMode(.alwaysOriginal)
        passwordTextField.isSecureTextEntry = toShowPassword ? false : true
        showPasswordButton.setImage(passwordButtonImage, for: .normal)
    }

    @IBAction func resetPasswordButton(_ sender: Any) {
        coordinator.showResetPasswordViewController(on: self)
    }

    @IBAction func createAccountButton(_ sender: Any) {
        coordinator.showCreateAccountViewController(on: self)
    }
}

// MARK: - Comportamentos de layout
extension RLLoginViewController {

    func setupView() {
        heightLabelError.constant = 0
        configureLoginButton()
        configureShowPasswordButton()
        configureCreateAccountButton()
        configureTextFields()
        setViewBehavior()
        validateButton()
    }

    func configureLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }

    func configureShowPasswordButton() {
        showPasswordButton.tintColor = .lightGray
    }

    func configureCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }

    func configureTextFields() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }

    func setViewBehavior() {
        addTapGestureToView()
        view.isUserInteractionEnabled = true
    }

    func addTapGestureToView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
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

extension RLLoginViewController {

    func validateButton() {
        let isEmailValid = emailUseCase.isEmailValid(for: emailTextField.text!)
        if isEmailValid {
            enableButton()
        } else {
            disableButton()
        }
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
