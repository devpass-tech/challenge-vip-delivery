import UIKit

class MJLoginViewController: UIViewController {
    
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
        verifyLoginAndUpdateRootViewController()
        shouldSetupDebugMode()
        self.setupView()
        self.validateButton()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func shouldSetupDebugMode() {
        #if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
        #endif
    }
    
    func updateRootViewController(navigationController: UINavigationController){
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func verifyLoginAndUpdateRootViewController() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            let vc = UINavigationController(rootViewController: HomeViewController())
            updateRootViewController(navigationController: vc)
        }
    }
    
    func loginRequest() {
        let endpoint = Endpoints.Auth.login
        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        
        getUserData(endpoint: endpoint, parameters: parameters)
    }
    
    func getUserData(endpoint: String, parameters: [String: String]) {
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
            handleLoginSuccess(userData: data)
        case .failure:
            handleLoginFailure()
        }
    }
    
    func handleLoginSuccess(userData: Data) {
        do {
            let session = try decodeUser(userData)
            let vc = UINavigationController(rootViewController: HomeViewController())
            updateRootViewController(navigationController: vc)
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        } catch {
            handleLoginFailure()
        }
    }
    
    func decodeUser(_ userData: Data) throws -> Session {
        let decoder = JSONDecoder()
        do {
            let session = try decoder.decode(Session.self, from: userData)
            return session
        } catch {
            throw error
        }
    }
    
    func handleLoginFailure() {
        setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..",
                             message: "Houve um problema, tente novamente mais tarde.",
                             targetVC: self)
    }
    
    func showAllert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        present(alertController, animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if ConnectivityManager.shared.isConnected {
            showLoading()
            loginRequest()
        } else {
            showAllert(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente")
        }
    }
    
    @IBAction func changePasswordPresentationStatus(_ sender: Any) {
        let image = showPassword == true ? "eye" : "eye.slash"
        passwordTextField.isSecureTextEntry = !showPassword
        showPasswordButton.setImage(UIImage.init(systemName: image)?.withRenderingMode(.alwaysTemplate), for: .normal)
        showPassword = !showPassword
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MJUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MJResetPasswordViewController") as! MJResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        let controller = MJCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

// MARK: - Comportamentos de layout
extension MJLoginViewController {
    
    func setupView() {
        heightLabelError.constant = 0
        setupColors()
        setupLoginButton()
        setupCreateAccountButton()
        setupGesture()
        validateButton()
    }
    
    func setupColors() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
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
    
    func setupGesture() {
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
        textField == emailTextField ? emailTextField.setEditingColor() : emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
}

extension MJLoginViewController {
    
    func validateButton() {
        let emailContainsDot = emailTextField.text!.contains(".")
        let emailContainsAt = emailTextField.text!.contains("@")
        let emailSizeGreaterThanFive = emailTextField.text!.count > 5
        
        if !emailContainsDot || !emailContainsAt || !emailSizeGreaterThanFive {
            if let atIndex = emailTextField.text!.firstIndex(of: "@") {
                let substring = emailTextField.text![atIndex...]
                substring.contains(".") ? enableButton() : disableButton()
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
