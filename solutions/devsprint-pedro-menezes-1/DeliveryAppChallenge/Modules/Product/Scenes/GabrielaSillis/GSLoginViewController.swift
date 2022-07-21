import UIKit

final class GSLoginViewController: UIViewController {
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    private var coordinator: GSCoordinating = GSCoordinator()
    private var serviceLayer: GSNetworkRequesting = GSNetworkManager()
    
    var showPassword = true
    var errorInLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyIfUserIsAlreadyLoggedIn()
        coordinator.controller = self
#if DEBUG
        configureTextFieldWithDefaultValue()
#endif
        
        setupView()
        validateButton()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func verifyIfUserIsAlreadyLoggedIn() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            coordinator.startNavigatingFlow()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if !ConnectivityManager.shared.isConnected {
            Globals.showNoInternetCOnnection(
                controller: self)
            return
        }
        makeAuthenticationRequest()
    }
    
    @IBAction func showPassword(_ sender: Any) {
        shouldShowOrHiddenPasswordInput()
        showPassword.toggle()
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        coordinator.navigatingToResetPassword()
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        coordinator.navigatingToCreateAccount()
    }
}

// MARK: - Comportamentos de layout
extension GSLoginViewController {
    
    func setupView() {
        heightLabelError.constant = 0
        configureButtons()
        setupDefaultColorOfTextField()
        validateButton()
        addGestureRecognizerOnView()
    }
    
    func configureButtons() {
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
    }
    
    func setupDefaultColorOfTextField() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    func addGestureRecognizerOnView() {
        view.isUserInteractionEnabled = true
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

extension GSLoginViewController {
    
    func validateButton() {
        if !emailTextField.text!.contains(".") ||
            !emailTextField.text!.contains("@") ||
            emailTextField.text!.count <= 5 {
            disableButton()
        } else {
            if let atIndex = emailTextField.text!.firstIndex(of: "@") {
                let substring = emailTextField.text![atIndex...]
                if substring.contains(".") {
                    enableButton()
                } else {
                    disableButton()
                }
            } else {
                disableButton()
            }
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

private extension GSLoginViewController {
    func configureTextFieldWithDefaultValue(
        emailTextField: String = "clean.code@devpass.com",
        passwordTextField: String = "111111") {
        self.emailTextField.text = emailTextField
        self.passwordTextField.text = passwordTextField
    }
    
    func makeAuthenticationRequest() {
        showLoading()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let userData = UserEmailAndPasswordData(email: email, password: password)
        serviceLayer.makeAuthenticationRequest(userData: userData) { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case .success(let data):
                self.coordinator.startNavigatingFlow()
                UserDefaultsManager.UserInfos.shared.save(session: data, user: nil)
            case .failure:
                self.showErrorMessage()
            }
        }
    }
    
    func showErrorMessage() {
        self.setErrorLogin("E-mail ou senha incorretos")
        coordinator.displayErrorAlertView()
    }
    
    func shouldShowOrHiddenPasswordInput() {
        if showPassword {
            isPasswordTextFieldSecureTextEntry(false)
            configureImageButton(imageName: "eye.slash")
        } else {
            isPasswordTextFieldSecureTextEntry(true)
            configureImageButton(imageName: "eye")
        }
    }
    
    func isPasswordTextFieldSecureTextEntry(_ isSecureTextEntry: Bool) {
        passwordTextField.isSecureTextEntry = isSecureTextEntry
    }
    
    func configureImageButton(imageName: String) {
        showPasswordButton.setImage(UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}
