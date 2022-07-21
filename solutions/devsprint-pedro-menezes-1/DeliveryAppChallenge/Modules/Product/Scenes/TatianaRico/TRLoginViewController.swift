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
    var coordinator = LoginUserCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyLogin()
        
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
#endif
        self.setupView()
        self.validateButton()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if !ConnectivityManager.shared.isConnected {
            alertConection(titleAlert: StringsHelper.SEM_CONEXAO, messageAlert: StringsHelper.CONECTE_SE_A_INTERNET, actionMsgAlert: StringsHelper.OK)
            return
        }
        
        showLoading()
        requestLogin()
    }
    
    @IBAction func showPassword(_ sender: Any) {
        self.showPassword ? self.userShowPasswordOurNot(showPassword: false, nameImage: "eye.slash") : self.userShowPasswordOurNot(showPassword: true, nameImage: "eye")
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
    
    func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            let vc = UINavigationController(rootViewController: HomeViewController())
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
    
    func alertConection(titleAlert: String, messageAlert: String, actionMsgAlert: String) {
        let alertController = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        let actin = UIAlertAction(title: actionMsgAlert, style: .default)
        alertController.addAction(actin)
        present(alertController, animated: true)
    }
    
    func requestLogin() {
        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        let endpoint = Endpoints.Auth.login
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            DispatchQueue.main.async {
                self.stopLoading()
                self.handleLoginResult(result)
            }
        }
    }
    
    
    func handleLoginResult(_ result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            handleLoginSucess(data: data)
        case .failure:
            handleLoginFailure()
        }
    }
    
    func handleLoginSucess(data: Data) {
        do {
            let json = try JSONDecoder().decode(Session.self, from: data)
            self.coordinator.changeScreenHome()
            UserDefaultsManager.UserInfos.shared.save(session: json , user: nil)
        } catch {
            handleLoginMsgError()
        }
    }
    
    func handleLoginMsgError() {
        self.alertMensagem(target: self, title: StringsHelper.OPS, message: StringsHelper.HOUVE_UM_PROBLEMA)
    }
    
    func handleLoginFailure() {
        self.setErrorLogin(StringsHelper.EMAIL_SENHA_INCORRETO)
        self.alertMensagem(target: self, title:StringsHelper.OPS, message: StringsHelper.HOUVE_UM_PROBLEMA)
    }
    
    private func alertMensagem(target: UIViewController, title: String, message: String) {
        Globals.alertMessage(title: title, message: message, targetVC: target)
    }
    
    private func userShowPasswordOurNot(showPassword: Bool, nameImage: String) {
        passwordTextField.isSecureTextEntry = showPassword
        showPasswordButton.setImage(UIImage.init(systemName: nameImage)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}

// MARK: - Comportamentos de layout
extension TRLoginViewController {
    
    func setupView() {
        heightLabelError.constant = 0
        showPasswordButton.tintColor = .lightGray
        
        setupLoginButtonLayout()
        setupAccountButtonLayout()
        validateButton()
        setupTextFielLayout()
        gestureClickView()
    }
    
    func setupTextFielLayout() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    func setupAccountButtonLayout() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    func setupLoginButtonLayout() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    func gestureClickView() {
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

extension TRLoginViewController {
    
    func validateButton() {
        let emailHasDot = emailTextField.text?.contains(".") ?? false
        let emailHasAt = emailTextField.text?.contains("@") ?? false
        let emailHasValidSize = emailTextField.text?.count ?? 0 > 5
        let emailIsValid = emailHasDot && emailHasAt && emailHasValidSize
        
        let atIndexFirst = emailTextField.text!.firstIndex(of: "@")
        
        if emailIsValid && (atIndexFirst != nil) {
            let substring = emailTextField.text![atIndexFirst!...]
            if substring.contains(".") {
                enableButton()
            } else {
                disableButton()
            }
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
