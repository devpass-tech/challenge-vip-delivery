import UIKit

class RLLoginViewController: UIViewController {
    
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
        verifyIfIsAlreadyLogIn()
        setupView()
        validateButton()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func verifyIfIsAlreadyLogIn() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            showHomeViewController()
        } else {
            setLoginInformation()
        }
    }

    func showHomeViewController() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func setLoginInformation() {
        #if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
        #endif
    }
    
    @IBAction func loginButton(_ sender: Any) {
        verifyIsHadConnection()
        showLoading()

        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        let endpoint = Endpoints.Auth.login

        makeLoginRequest(with: endpoint, and: parameters)
    }

    func verifyIsHadConnection() {
        if !ConnectivityManager.shared.isConnected {
            showNoConnectionAlert()
        }
    }

    func showNoConnectionAlert() {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        present(alertController, animated: true)
        return
    }

    func makeLoginRequest(with endpoint: String, and parameters: [String: String]) {
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            self.handleRequest(result: result)
        }
    }

    func handleRequest(result: Result<Data, Error>) {
        DispatchQueue.main.async {
            self.stopLoading()
            switch result {
            case .success(let data):
                self.decodeUser(with: data)
            case .failure:
                self.showRequestError()
            }
        }
    }

    func decodeUser(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let session = try decoder.decode(Session.self, from: data)
            self.showHomeViewController()
            UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
        } catch {
            Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
        }
    }

    func showRequestError() {
        self.setErrorLogin("E-mail ou senha incorretos")
        Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        if(showPassword == true) {
            configureLayout(toShowPassword: true)
        } else {
            configureLayout(toShowPassword: false)
        }
        showPassword = !showPassword
    }

    func configureLayout(toShowPassword: Bool) {
        if toShowPassword {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage.init(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage.init(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        showResetPasswordViewController()
    }

    func showResetPasswordViewController() {
        let storyboard = UIStoryboard(name: "RLUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RLResetPasswordViewController") as! RLResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        showCreateAccountViewController()
    }

    func showCreateAccountViewController() {
        let controller = RLCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

// MARK: - Comportamentos de layout
extension RLLoginViewController {
    
    func setupView() {
        heightLabelError.constant = 0

        configureLoginButton()
        configureShowPasswordButton()
        configureCreateAccountButton()

        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()

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
        if isEmailValid() {
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

    func isEmailValid() -> Bool {
        return !emailTextField.text!.contains(".") ||
        !emailTextField.text!.contains("@") ||
        emailTextField.text!.count <= 5
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
