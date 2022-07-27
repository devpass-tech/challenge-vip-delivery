import UIKit

class BAResetPasswordViewController: UIViewController {
    
    // MARK: - Private IBOutlet
    
    @IBOutlet private weak var emailTextfield: UITextField!
    @IBOutlet private weak var recoverPasswordButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var helpButton: UIButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var viewSuccess: UIView!
    @IBOutlet private weak var emailLabel: UILabel!
    
    // MARK: - Public Properties
    
    var email = ""
    var loadingScreen = LoadingController()
    var recoveryEmail = false
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupView()
        validateButton()
        checkIfEmailIsEmpty()
    }
    
    private func setupRecoveryPasswordButton() {
        recoverPasswordButton.layer.cornerRadius = recoverPasswordButton.bounds.height / 2
        recoverPasswordButton.backgroundColor = .blue
        recoverPasswordButton.setTitleColor(.white, for: .normal)
    }
    
    private func setupLoginButton() {
        loginButton.layer.cornerRadius = createAccountButton.frame.height / 2
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blue.cgColor
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.backgroundColor = .white
    }
    
    private func setupHelpButton() {
        helpButton.layer.cornerRadius = createAccountButton.frame.height / 2
        helpButton.layer.borderWidth = 1
        helpButton.layer.borderColor = UIColor.blue.cgColor
        helpButton.setTitleColor(.blue, for: .normal)
        helpButton.backgroundColor = .white
    }
    
    private func setupCreateAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    private func closeView() {
        self.view.endEditing(true)
    }
    
    private func sendToAPI() {
        let emailUser = emailTextfield.text!.trimmingCharacters(in: .whitespaces)
        
        let parameters = [
            "email": emailUser
        ]
        recoverPassword(with: parameters)
    }
    
    // MARK: - Actions

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func recoverPasswordButton(_ sender: Any) {
        if recoveryEmail {
            dismiss(animated: true)
            return
        }

        if validateForm() {
            closeView()
            checkIfHasInternetConnection()
            sendToAPI()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let contactUs: BAContactUsViewController = BAContactUsViewController()
        contactUs.modalPresentationStyle = .popover
        contactUs.modalTransitionStyle = .coverVertical
        present(contactUs, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let createAccount: BACreateAccountViewController = BACreateAccountViewController()
        createAccount.modalPresentationStyle = .fullScreen
        present(createAccount, animated: true)
    }
    
    func validateForm() -> Bool {
        let status = emailTextfield.text!.isEmpty ||
            !emailTextfield.text!.contains(".") ||
            !emailTextfield.text!.contains("@") ||
            emailTextfield.text!.count <= 5
        
        if status {
            emailTextfield.setErrorColor()
            textLabel.textColor = .red
            textLabel.text = "Verifique o e-mail informado"
            return false
        }
        
        return true
    }
    
    private func successInRecoveringPassword() {
        recoveryEmail = true
        emailTextfield.isHidden = true
        textLabel.isHidden = true
        viewSuccess.isHidden = false
        emailLabel.text = self.emailTextfield.text?.trimmingCharacters(in: .whitespaces)
        recoverPasswordButton.titleLabel?.text = "REENVIAR E-MAIL"
        recoverPasswordButton.setTitle("Voltar", for: .normal)
    }
    
    private func showErrorMessage() {
        let alertController = UIAlertController(title: "Ops..",
                                                message: "Algo de errado aconteceu. Tente novamente mais tarde.",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func recoverPassword(with parameters: [String : String]) {
        BadNetworkLayer.shared.resetPassword(self, parameters: parameters) { success in
            if success {
                self.successInRecoveringPassword()
            } else {
                self.showErrorMessage()
            }
        }
    }
    
    private func checkIfHasInternetConnection() {
        if !ConnectivityManager.shared.isConnected {
            Globals.showNoInternetCOnnection(controller: self)
            return
        }
    }
}

// MARK: - Comportamentos de layout
extension BAResetPasswordViewController {
    
    func setupView() {
        setupRecoveryPasswordButton()
        setupLoginButton()
        setupHelpButton()
        setupCreateAccountButton()
        emailTextfield.setDefaultColor()
    }
    
    func checkIfEmailIsEmpty() {
        if !email.isEmpty {
            emailTextfield.text = email
            emailTextfield.isEnabled = false
        }
    }
    
    //email
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

extension BAResetPasswordViewController {
    
    func validateButton() {
        if !emailTextfield.text!.isEmpty {
            enableCreateButton()
        } else {
            disableCreateButton()
        }
    }
    
    func disableCreateButton() {
        recoverPasswordButton.backgroundColor = .gray
        recoverPasswordButton.setTitleColor(.white, for: .normal)
        recoverPasswordButton.isEnabled = false
    }
    
    func enableCreateButton() {
        recoverPasswordButton.backgroundColor = .blue
        recoverPasswordButton.setTitleColor(.white, for: .normal)
        recoverPasswordButton.isEnabled = true
    }
}
