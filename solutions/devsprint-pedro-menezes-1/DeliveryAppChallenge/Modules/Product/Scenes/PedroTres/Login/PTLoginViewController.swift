import UIKit

class PTLoginViewController: UIViewController {
    
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var showPassword = true
    @IBOutlet weak var showPasswordButton: UIButton!
    var errorInLogin = false
    
    private let service = PTLoginWorker()
    private let coordinator = PTCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserDebug()
        heightLabelError.constant = 0
        setupLayout()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction private func loginButton(_ sender: Any) {
        if ConnectivityManager.shared.isConnected {
            fetchLogin()
        } else {
            showAlert()
        }
    }
    
    @IBAction private func showPassword(_ sender: Any) {
        if(showPassword == true) {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage.init(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage.init(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        showPassword = !showPassword
    }
    
    @IBAction private func resetPasswordButton(_ sender: Any) {
        coordinator.showPTResetPasswordViewController(presentController: self)
    }
    
    @IBAction private func createAccountButton(_ sender: Any) {
        let controller = PTCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    
}

//MARK: - Regras de negócio
private extension PTLoginViewController {
    func fetchLogin() {
        showLoading()
        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        
        service.fetchLogin(vc: self, parameters: parameters) { result in
            DispatchQueue.main.async {
                self.stopLoading()
                
                switch result {
                case .success(let result):
                    self.handleSuccess(session: result)
                case .failure:
                    self.handleFailure()
                }
            }
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        present(alertController, animated: true)
    }
    
    func navigateToHome(){
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        return !email.contains(".") ||
        !email.contains("@") ||
        email.count <= 5
    }
    
    func handleSuccess(session: Session) {
        UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        self.navigateToHome()
    }
    
    func handleFailure() {
        self.setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
    }
}

// MARK: - Comportamentos de layout
private extension PTLoginViewController {
    
    func setupLayout() {
        setupLoginButton()
        setupCreateAccountButton()
        setupStyle()
        setupGestureRecognizer()
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
    
    func setupStyle(){
        showPasswordButton.tintColor = .lightGray
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    func setupGestureRecognizer() {
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
    
    func validateButton() {
        let email = emailTextField.text
        let isEmailValid = isValidEmail(email)
        
        isEmailValid ? enableButton() : disableButton()
    }
    
    func disableButton() {
        loginButton.backgroundColor = .gray
        loginButton.isEnabled = false
    }
    
    func enableButton() {
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = true
    }
    
    func setupUserDebug() {
    #if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
    #endif
    }
}
