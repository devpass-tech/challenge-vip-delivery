import UIKit

class TRLoginViewController: UIViewController {
    @IBOutlet weak var heightLabelError: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    var errorInLogin = false
    var showPassword = true
    var coordinator: TRLoginUserCoordinator = TRLoginUserCoordinator()
    var viewModel = TRLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyLogin()
        showPlaceholderTextField()
        self.setupView()
        coordinator.controler = self
        self.refreshButtonStatus()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        verifyStatusInternetConnection()
    }
    
    @IBAction func showPassword(_ sender: Any) {
        let imageName = showPassword ? "eye.slash" : "eye"
        let image = UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        showPasswordButton.setImage(image, for: .normal)
        passwordTextField.isSecureTextEntry = showPassword
        showPassword = !showPassword
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        self.coordinator.userResetPassword()
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.coordinator.newAccount()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private   func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            coordinator.goToHomeViewController()
        }
    }
    
    private func showPlaceholderTextField() {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
#endif
    }
    
    private func verifyStatusInternetConnection() {
        let conection = ConnectivityManager.shared.isConnected
        if  conection {
            startLoginRequest()
        } else {
            self.stopLoading()
            coordinator.alertConection(titleAlert: StringsHelper.NOT_CONEXAO, messageAlert: StringsHelper.CONNECT_INTERNET, messageActionAlert: StringsHelper.OK)        }
    }
    
    private func startLoginRequest() {
        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        BadNetworkLayer.shared.login(self, parameters: parameters) { session in
                let didLoginSucced = session != nil
                if didLoginSucced {
                    self.coordinator.changeScreenHome()
                } else {
                    self.handleLoginFailure()
                }
        }
    }
    
    private func handleLoginFailure() {
        self.isErrorLogin(StringsHelper.EMAIL_PASSWORD_INCORRECT)
        alertMensagem(target: self, title:StringsHelper.OPS, message: StringsHelper.THERE_WAS_PROBLEM)
    }
    
    private func alertMensagem(target: UIViewController, title: String, message: String) {
        Globals.alertMessage(title: title, message: message, targetVC: target)
    }
}

// MARK: - Comportamentos de layout
extension TRLoginViewController {
    
    private func setupView() {
        heightLabelError.constant = 0
        showPasswordButton.tintColor = .lightGray
        
        setupLoginButtonLayout()
        setupAccountButtonLayout()
        refreshButtonStatus()
        setupTextFielLayout()
        gestureClickView()
    }
    
    private func setupTextFielLayout() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    private func setupAccountButtonLayout() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    private func setupLoginButtonLayout() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    private func gestureClickView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didClickView))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func didClickView() {
        view.endEditing(true)
    }
    
    //email
    @IBAction func emailBeginEditing(_ sender: Any) {
        if errorInLogin {
            resetLoginAfterError(emailTextField)
        } else {
            emailTextField.setEditingColor()
        }
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        refreshButtonStatus()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        emailTextField.setDefaultColor()
    }
    
    //senha
    @IBAction func passwordBeginEditing(_ sender: Any) {
        if errorInLogin {
            resetLoginAfterError(passwordTextField)
        } else {
            passwordTextField.setEditingColor()
        }
    }
    
    @IBAction func passwordEditing(_ sender: Any) {
        refreshButtonStatus()
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        passwordTextField.setDefaultColor()
    }
    
    private func isErrorLogin(_ message: String) {
        errorInLogin = true
        heightLabelError.constant = 20
        errorLabel.text = message
        emailTextField.setErrorColor()
        passwordTextField.setErrorColor()
    }
    
    private func resetLoginAfterError(_ textField: UITextField) {
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

extension TRLoginViewController {
    private func refreshButtonStatus() {
        self.changeButtonStatus(color: .gray, isEnabled: false)
        let email = emailTextField.text
        
        self.viewModel.validateEmail(textField: email ?? "") ? self.changeButtonStatus(color: .blue, isEnabled: true) : self.changeButtonStatus(color: .gray, isEnabled: false)
    }
    
    private func changeButtonStatus(color: UIColor, isEnabled: Bool) {
        loginButton.backgroundColor = color
        loginButton.isEnabled = isEnabled
    }
}

extension TRLoginViewController{
    enum StringsHelper {
        static let CONNECT_INTERNET = "Conecte-se à internet para tentar novamente"
        static let EMAIL_PASSWORD_INCORRECT = "E-mail ou senha incorretos"
        static let THERE_WAS_PROBLEM = "Houve um problema, tente novamente mais tarde."
        static let OK = "ok"
        static let OPS = "Ops.."
        static let NOT_CONEXAO = "Sem conexão"
        
    }
}
