import UIKit

class THResetPasswordViewController: UIViewController {
    // MARK: - Properties
    var email = ""
    var loadingScreen = LoadingController()
    var recoveryEmail = false
    var coordinator = THResetPasswordCoordinator()
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var viewSuccess: UIView!
    @IBOutlet weak var emailLabel: UILabel!

    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.controller = self
        setupView()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Actions
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func recoverPasswordButton(_ sender: Any) {
        if recoveryEmail {
            dismiss(animated: true)
            return
        } else if isValidEmail() {
            validateEmailError()
        } else {
            haveConnection()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        self.coordinator.THContactUSViewController()
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.coordinator.THCreateAccontouViewController()
    }
    
    @IBAction func emailBeginEditing(_ sender: Any) {
        emailTextfield.setEditingColor()
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        emailTextfield.setEditingColor()
        validateButton()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        emailTextfield.setDefaultColor()
    }
}

// MARK: - Extensions
// MARK: - Methods
extension THResetPasswordViewController {
    func haveConnection() {
        self.view.endEditing(true)
        if !ConnectivityManager.shared.isConnected {
            Globals.showNoInternetCOnnection(controller: self)
            return
        }
        fetchResetPassword()
    }
    
    func fetchResetPassword() {
        let emailUser = emailTextfield.text!.trimmingCharacters(in: .whitespaces)
        let parameters = [ "email" : emailUser ]
        
        BadNetworkLayer.shared.resetPassword(self, parameters: parameters) { (success) in
            if success {
                self.resetPasswordSuccess()
            } else {
                self.coordinator.showAlertController(title: "Ops..", message: "Algo de errado aconteceu. Tente novamente mais tarde.", messageAction: "Ok")
            }
        }
    }
    
    func isValidEmail() -> Bool {
        let emailIsEmpty = emailTextfield.text!.isEmpty
        let isNotEmailContainDot = !emailTextfield.text!.contains(".")
        let isNotEmailContainAt = !emailTextfield.text!.contains("@")
        let isEmailSmaller = emailTextfield.text!.count <= 5
        let statusEmail = emailIsEmpty || isNotEmailContainDot || isNotEmailContainAt || isEmailSmaller
        return statusEmail
    }
    
    func validateEmailError() {
        emailTextfield.setErrorColor()
        textLabel.textColor = .red
        textLabel.text = "Verifique o e-mail informado"
    }
    
    func validateButton() {
        let isEmailEmpty = (emailTextfield.text ?? "").isEmpty
        let isButtonEnabled = !isEmailEmpty
        toggleCreateButtonStatus(isButtonEnabled)
    }

    func toggleCreateButtonStatus(_ isEnabled: Bool) {
        recoverPasswordButton.backgroundColor = isEnabled ? .blue : .gray
        let titleColor: UIColor = .white
        recoverPasswordButton.setTitleColor(titleColor, for: .normal)
        recoverPasswordButton.isEnabled = isEnabled
    }

    func validateEmailEmpty() {
        let emailEmpty = email.isEmpty
        let emailValidate = !emailEmpty
        if emailValidate {
            emailTextfield.text = email
            emailTextfield.isEnabled = false
        }
    }
    
    func resetPasswordSuccess() {
        self.recoveryEmail = true
        self.emailTextfield.isHidden = true
        self.textLabel.isHidden = true
        self.viewSuccess.isHidden = false
        self.emailLabel.text = self.emailTextfield.text?.trimmingCharacters(in: .whitespaces)
        self.recoverPasswordButton.titleLabel?.text = "REENVIAR E-MAIL"
        self.recoverPasswordButton.setTitle("Voltar", for: .normal)
    }
}

// MARK: - UI Components
extension THResetPasswordViewController {
    func setupView() {
        buildComponentsLayout()
        emailTextfield.setDefaultColor()
        validateEmailEmpty()
        validateButton()
    }
    
    func buildComponentsLayout() {
        setupRecoverPasswordButton()
        setupLoginButton()
        setupHelpButton()
        setupCreateAccountButton()
    }
    
    func setupRecoverPasswordButton() {
        recoverPasswordButton.layer.cornerRadius = recoverPasswordButton.bounds.height / 2
        recoverPasswordButton.backgroundColor = .blue
        recoverPasswordButton.setTitleColor(.white, for: .normal)
    }
    
    func setupLoginButton() {
        loginButton.layer.cornerRadius = createAccountButton.frame.height / 2
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blue.cgColor
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.backgroundColor = .white
    }

    func setupHelpButton() {
        helpButton.layer.cornerRadius = createAccountButton.frame.height / 2
        helpButton.layer.borderWidth = 1
        helpButton.layer.borderColor = UIColor.blue.cgColor
        helpButton.setTitleColor(.blue, for: .normal)
        helpButton.backgroundColor = .white
    }
    
    func setupCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
}
