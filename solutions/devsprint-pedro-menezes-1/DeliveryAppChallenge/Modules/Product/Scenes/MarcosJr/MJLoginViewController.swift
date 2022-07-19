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
        verifyLogin()

        #if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
        #endif

        self.setupView()
        self.validateButton()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updateRootViewController(viewController: UINavigationController){
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            let vc = UINavigationController(rootViewController: HomeViewController())
            updateRootViewController(viewController: vc)
        }
    }
    
    func isConnected() -> Bool {
        if !ConnectivityManager.shared.isConnected {
            let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
            let actin = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(actin)
            present(alertController, animated: true)
            return false
        } else {
            return true
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
                switch result {
                case .success(let data):
                    self.saveUser(data: data)
                case .failure:
                    self.setErrorLogin("E-mail ou senha incorretos")
                    Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
                }
            }
        }
    }
    
    func saveUser(data: Data) {
        let decoder = JSONDecoder()
        if let session = try? decoder.decode(Session.self, from: data) {
            let vc = UINavigationController(rootViewController: HomeViewController())
            updateRootViewController(viewController: vc)
            
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        } else {
            Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if isConnected() {
            showLoading()
            loginRequest()
        }
    }
    
    @IBAction func showPassword(_ sender: Any) {
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
        showPasswordButton.tintColor = .lightGray
        
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
        if !emailTextField.text!.contains(".") ||
            !emailTextField.text!.contains("@") ||
            emailTextField.text!.count <= 5 {
            disableButton()
        } else {
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
