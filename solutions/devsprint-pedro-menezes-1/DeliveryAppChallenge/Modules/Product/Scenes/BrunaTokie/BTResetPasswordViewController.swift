import UIKit

class BTResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var viewSuccess: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    var email = ""
    var loadingScreen = LoadingController()
    var recoveryEmail = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func recoverPasswordButton(_ sender: Any) {
        if recoveryEmail {
            dismiss(animated: true)
        } else {
            isValidatedForm()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let vc = BTContactUsViewController()
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let newVc = BTCreateAccountViewController()
        newVc.modalPresentationStyle = .fullScreen
        present(newVc, animated: true)
    }

    private func startPasswordRecovering() {
        if !ConnectivityManager.shared.isConnected {
            Globals.showNoInternetCOnnection(controller: self)
        } else {
            let parameters = createPasswordRequestParameters()
            recoverPasswordData(parameters: parameters)
        }
    }

    private func createPasswordRequestParameters() -> [String: String] {
        let emailUser = emailTextfield.text!.trimmingCharacters(in: .whitespaces)

        let parameters = [
            "email": emailUser
        ]
        return parameters
    }

    private func recoverPasswordData(parameters: [String: String]) {
        BadNetworkLayer.shared.resetPassword(self, parameters: parameters) { (success) in
            if success {
                self.newPasswordCreatedSuccess()
            } else {
                self.createErrorAlert()
            }
        }
    }

    private func createErrorAlert() {
        let alertController = UIAlertController(title: "Ops..", message: "Algo de errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }

    private func newPasswordCreatedSuccess() {
        self.recoveryEmail = true
        self.emailTextfield.isHidden = true
        self.textLabel.isHidden = true
        self.viewSuccess.isHidden = false
        self.emailLabel.text = self.emailTextfield.text?.trimmingCharacters(in: .whitespaces)
        self.recoverPasswordButton.titleLabel?.text = "REENVIAR E-MAIL"
        self.recoverPasswordButton.setTitle("Voltar", for: .normal)
    }

    private func isEmailTextFieldValid() -> Bool {
        let emailNotEmpty = emailTextfield.text?.isEmpty ?? false
        let emailContainsDot = emailTextfield.text?.contains(".") ?? false
        let emailContainsAt = emailTextfield.text?.contains("@") ?? false
        let emailHasValidSize = emailTextfield.text?.count ?? 0 > 5
        let emailIsValid = emailNotEmpty && emailContainsDot && emailContainsAt && emailHasValidSize
        return emailIsValid
    }

    private func isValidatedForm() {
        let emailIsValid = isEmailTextFieldValid()
        if emailIsValid {
            self.startPasswordRecovering()
        } else {
            self.formNotValidated()
        }
    }

    private func formNotValidated() {
        emailTextfield.setErrorColor()
        textLabel.textColor = .red
        textLabel.text = "Verifique o e-mail informado"
    }
}


// MARK: - Comportamentos de layout
extension BTResetPasswordViewController {
    
    func setupView() {
        setupRecoverPasswordButton()
        setupLoginButton()
        setupHelpButton()
        setupCreateAccountButton()
        setupTextField()
    }

    private func setupRecoverPasswordButton() {
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

    private func setupTextField() {
        email.isEmpty ? validateButton() : setupFilledEmail()
        emailTextfield.setDefaultColor()
    }

    private func setupFilledEmail() {
        emailTextfield.text = email
        emailTextfield.isEnabled = false
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

extension BTResetPasswordViewController {
    
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
