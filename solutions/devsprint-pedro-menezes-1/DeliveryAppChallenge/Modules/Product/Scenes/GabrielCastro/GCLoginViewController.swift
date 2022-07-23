import UIKit

protocol GCLoginViewControllerDelegate: AnyObject {
    func showViewController(vc: UIViewController)
    func showRequestError(_ targetVC: UIViewController)
    func showGCResetPasswordViewController()
}

final class GCLoginViewController: UIViewController {
  
    //MARK: Vars
    weak var gCLoginViewControllerDelegate: GCLoginViewControllerDelegate?
            
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
    
    
    private func LoginApiRequest(with endpoint: String, and parameters: [String: String]) {
        // usar reset password como referencia
        
        AF.request(endpoint, method: .get, parameters: parameters, headers: nil) { result in
            self.handleRequest(result: result)
        }
    }
    
    private func handleRequest(result: Result<Data, Error>) {
            DispatchQueue.main.async {
                self.stopLoading()
                switch result {
                case .success(let data):
                    self.decodeUser(with: data)
                case .failure:
                    self.gCLoginViewControllerDelegate?.showRequestError(self)
                }
            }
        }

       private func decodeUser(with data: Data) {
            let decoder = JSONDecoder()
            do {
                let session = try decoder.decode(Session.self, from: data)
                gCLoginViewControllerDelegate?.showViewController(vc: HomeViewController())
                UserDefaultsManager.UserInfos.shared.save(session: session, user: nil)
            } catch {
                Globals.alertMessage(title: "Ops..", message: "Houve um problema, tente novamente mais tarde.", targetVC: self)
            }
        }


    
    
    private func loginDefault() {
#if DEBUG
        emailTextField.text = "clean.code@devpass.com"
        passwordTextField.text = "111111"
#endif
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func verifyLogin() {
        if let _ = UserDefaultsManager.UserInfos.shared.readSesion() {
            gCLoginViewControllerDelegate?.showViewController(vc: UINavigationController(rootViewController: HomeViewController()))
        }
    }
    
    
    
    private func isInternetConnected(_ controller: UIViewController) -> Bool {
        if ConnectivityManager.shared.isConnected {
            return true
        } else {
            Globals.showNoInternetCOnnection(controller: controller)    
            return false
        }
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
     
        if ConnectivityManager.shared.isConnected {
            showLoading()
            let parameters: [String: String] = ["email": emailTextField.text!,
                                               "password": passwordTextField.text!]
                    let endpoint = Endpoints.Auth.login
            LoginApiRequest(with: endpoint, and: parameters)
        } else {
            Globals.showNoInternetCOnnection(controller: self)
        }
    }
    
    @IBAction func showPassword(_ sender: Any) {
       
        if(showPassword == true) {
            passwordTextField.isSecureTextEntry = true
            setupPasswordButtonImage()
        } else {
            passwordTextField.isSecureTextEntry = false
            setupPasswordButtonImage()
        }
        showPassword = !showPassword
    }
    
    private func setupPasswordButtonImage() {
        let imageName = showPassword ? "eye.slash" : "eye"
        let image = UIImage.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        showPasswordButton.setImage(image, for: .normal)
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        showGCResetPasswordViewController()
    }
    
    private func showGCResetPasswordViewController() {
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
    
    private func setupView() {
        setupLoginButton()
        showPasswordButton.tintColor = .lightGray
        setupCreateAccountButton()
        setupTextFields()
        gestureDidClickView()
        heightLabelError.constant = 0
        validateButton()
    }
    
    
    private func setupLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    
    private func setupCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    private func setupTextFields() {
        emailTextField.setDefaultColor()
        passwordTextField.setDefaultColor()
    }
    
    
    private func gestureDidClickView() {
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
    
    
    
    private func resetErrorLogin(_ textField: UITextField) {
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
    
    private func validateButton() {
        if validateEmail() {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    
    private func validateEmail() -> Bool {
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
    
    private func disableButton() {
        loginButton.backgroundColor = .gray
        loginButton.isEnabled = false
    }
    
    private func enableButton() {
        loginButton.backgroundColor = .blue
        loginButton.isEnabled = true
    }
}

extension GCLoginViewController: GCCoordinatorDelegate {
    internal func setErrorLogin(_ message: String) {
        errorInLogin = true
        heightLabelError.constant = 20
        errorLabel.text = message
        emailTextField.setErrorColor()
        passwordTextField.setErrorColor()
    }
}
