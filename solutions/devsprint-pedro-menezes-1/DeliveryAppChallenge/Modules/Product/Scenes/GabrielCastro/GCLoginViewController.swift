import UIKit




class GCLoginViewController: UIViewController, LoginApiDelegate {
    
    
    //MARK: Vars
    
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var showPassword = true
    @IBOutlet weak var showPasswordButton: UIButton!
    var errorInLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyLogin()
        loginDefault()
        setupView()
        validateButton()
    }
    
    func loginDefault() {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
#endif
    }
    
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            Coordinator().showViewController(vc: UINavigationController(rootViewController: HomeViewController()))
        }
    }
    
    func IsInternetConnected(_ controller: UIViewController) -> Bool {
        if ConnectivityManager.shared.isConnected {
            return true
        } else {
            Globals.showNoInternetCOnnection(controller: controller)
        }
        return false
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        if IsInternetConnected(self) == true {
            showLoading()
            LoginApi().apiRequest(emailParameter: emailTextField, passwordParameter: passwordTextField)
        } else {
            return
        }
    }
    
    @IBAction func showPassword(_ sender: Any) {
        
        if(showPassword == true) {
            passwordTextField.isSecureTextEntry = false
            setupButtonImage(button: showPasswordButton, image: "eye.slash")
        } else {
            passwordTextField.isSecureTextEntry = true
            setupButtonImage(button: showPasswordButton, image: "eye")
        }
        showPassword = !showPassword
    }
    
    func setupButtonImage(button : UIButton, image: String) {
        button.setImage(UIImage.init(systemName: image)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        showGCResetPasswordViewController()
    }
    
    func showGCResetPasswordViewController() {
        let storyboard = UIStoryboard(name: "GCUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GCResetPasswordViewController") as! GCResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let controller = GCCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

// MARK: - Comportamentos de layout
extension GCLoginViewController {
    
    func setupView() {
        setupLoginButton()
        showPasswordButton.tintColor = .lightGray
        setupCreateAccountButton()
        setupTextFields()
        gestureDidClickView()
        heightLabelError.constant = 0
        validateButton()
    }
    
    
    func setupLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    
    func setupCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    func setupTextFields() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    
    func gestureDidClickView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
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

extension GCLoginViewController {
    
    func validateButton() {
        if validateEmail() {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    
    func validateEmail() -> Bool {
        guard let email = emailTextField.text, let atIndex = email.firstIndex(of: "@") else {
            return false
        }
        let substring = email[atIndex...]
        if !email.contains(".") ||
            !email.contains("@") ||
            email.count <= 5 ||
            !substring.contains(".") {
            return false
        } else {
            return true
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
