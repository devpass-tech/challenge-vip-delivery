import UIKit

class TRLoginViewController: UIViewController {
    
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
    
    func alertConection() {
        let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
        let actin = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(actin)
        present(alertController, animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if !ConnectivityManager.shared.isConnected {
            alertConection()
            return
        }

        showLoading()
        let parameters: [String: String] = ["email": emailTextField.text!,
                                            "password": passwordTextField.text!]
        let endpoint = Endpoints.Auth.login
        requestLogin(endpoint: endpoint, parameters: parameters)
    }
    
    func requestLogin(endpoint: String, parameters: [String:String]) {
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            DispatchQueue.main.async {
                self.stopLoading()
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let session = try? decoder.decode(Session.self, from: data) {
                        self.goToHome()
                        UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
                    } else {
                        self.alertMensagem(target: self, title: "Ops..", message: "Houve um problema, tente novamente mais tarde.")
                    }
                case .failure:
                    self.setErrorLogin("E-mail ou senha incorretos")
                    self.alertMensagem(target: self, title: "Ops..", message: "Houve um problema, tente novamente mais tarde.")
                }
            }
        }
    }
    
   private func alertMensagem(target: UIViewController, title: String, message: String) {
        Globals.alertMessage(title: title, message: message, targetVC: target)
    }
    
    private func goToHome() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    @IBAction func showPassword(_ sender: Any) {
        if(showPassword == true) {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage.init(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage.init(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        showPassword = !showPassword
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        self.goToResetPassword()
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.goToCreatAccount()
    }
    
    func goToResetPassword() {
        let storyboard = UIStoryboard(name: "TRUser", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TRResetPasswordViewController") as! TRResetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func goToCreatAccount() {
        let controller = TRCreateAccountViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}

// MARK: - Comportamentos de layout
extension TRLoginViewController {
    
    func setupView() {
        heightLabelError.constant = 0
        showPasswordButton.tintColor = .lightGray

        setupLoginButton()
        setupAccountButton()
        validateButton()
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
        gestureClickView()
    }
    
    func setupAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    func setupLoginButton() {
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

extension TRLoginViewController {
    
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
