import UIKit

class CAResetPasswordViewController: UIViewController {

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
    var isPasswordRecovered = false

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

    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let vc = CAContactUsViewController()
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let newVc = CACreateAccountViewController()
        newVc.modalPresentationStyle = .fullScreen
        present(newVc, animated: true)
    }
    
    @IBAction func recoverPasswordButton(_ sender: Any) {
        if(isPasswordRecovered) {
            dismiss(animated: true)
        } else {
            validateForm()
        }
    }
    
    func validateForm() {
        let isEmailValid = verifyIfEmailIsValid()
        
        if isEmailValid {
            onValidEmailTyped()
        } else {
            onInvalidEmailTyped()
        }
    }
    
    func onInvalidEmailTyped() {
        emailTextfield.setErrorColor()
        textLabel.textColor = .red
        textLabel.text = "Verifique o e-mail informado"
    }
    
    func verifyIfEmailIsValid() -> Bool {
        let emailContainsAnyInvalidCondition = emailTextfield.text!.isEmpty ||
            !emailTextfield.text!.contains(".") ||
            !emailTextfield.text!.contains("@") ||
            emailTextfield.text!.count <= 5
        
        return !emailContainsAnyInvalidCondition
    }
    
    func onValidEmailTyped() {
        self.view.endEditing(true)
        
        if !ConnectivityManager.shared.isConnected {
            Globals.showNoInternetCOnnection(controller: self)
        } else {
            recoverPassword()
        }
    }
    
    func recoverPassword() {
        let userEmail = emailTextfield.text!.trimmingCharacters(in: .whitespaces)
        
        let parameters = [
            "email": userEmail
        ]
        
        BadNetworkLayer.shared.resetPassword(self, parameters: parameters) { (success) in
            if success {
                self.presentSuccessStyle()
            } else {
                self.presentErrorAlert()
            }
        }
    }
    
    func presentSuccessStyle() {
        self.isPasswordRecovered = true
        
        self.emailTextfield.isHidden = true
        self.textLabel.isHidden = true
        self.viewSuccess.isHidden = false
        
        self.emailLabel.text = self.emailTextfield.text?.trimmingCharacters(in: .whitespaces)
        
        self.recoverPasswordButton.titleLabel?.text = "REENVIAR E-MAIL"
        self.recoverPasswordButton.setTitle("Voltar", for: .normal)
    }
    
    func presentErrorAlert() {
        let alertController = UIAlertController(
            title: "Ops..",
            message: "Algo de errado aconteceu. Tente novamente mais tarde.",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "OK",
            style: .default
        )
        
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}

// MARK: - Comportamentos de layout
extension CAResetPasswordViewController {
    
    func setupView() {
        setupRecoverPasswordButton()
        setupLoginButton()
        setupHelpButton()
        setupCreateAccountButton()
        setupEmailField()
        
        validateEmailField()
    }
    
    func setupRecoverPasswordButton() {
        recoverPasswordButton.layer.cornerRadius = recoverPasswordButton.bounds.height / 2
        recoverPasswordButton.backgroundColor = .blue
        recoverPasswordButton.setTitleColor(.white, for: .normal)
    }
    
    func setupLoginButton() {
        loginButton.setupStyle(cornerRadiusHeight: createAccountButton.frame.height)
    }
    
    func setupHelpButton() {
        helpButton.setupStyle(cornerRadiusHeight: createAccountButton.frame.height)
    }
    
    func setupCreateAccountButton() {
        createAccountButton.setupStyle(cornerRadiusHeight: createAccountButton.frame.height)
    }
    
    func setupEmailField() {
        emailTextfield.setDefaultColor()
        if !email.isEmpty {
            emailTextfield.text = email
            emailTextfield.isEnabled = false
        }
    }
    
    @IBAction func emailBeginEditing(_ sender: Any) {
        emailTextfield.setEditingColor()
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        emailTextfield.setEditingColor()
        validateEmailField()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        emailTextfield.setDefaultColor()
    }
}

extension CAResetPasswordViewController {
    
    func validateEmailField() {
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
