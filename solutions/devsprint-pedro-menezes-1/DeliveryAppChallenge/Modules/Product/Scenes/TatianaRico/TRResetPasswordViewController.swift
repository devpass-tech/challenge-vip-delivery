import UIKit

class TRResetPasswordViewController: UIViewController {
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
    
    var coordinator: TRResetPasswordCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.coordinator = TRResetPasswordCoordinator(viewController: self)
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
        } else if isValidateEmail() {
            self.view.endEditing(true)
        } else if !ConnectivityManager.shared.isConnected {
            Globals.showNoInternetCOnnection(controller: self)
            return
        } else {
            networkResetPassoword()
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        self.coordinator?.contactViewController()
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.coordinator?.createAccountViewController()
    }
    
    func isValidateEmail() -> Bool {
        let emailHasDot = emailTextfield.text?.contains(".") ?? false
        let emailHasAt = emailTextfield.text?.contains("@") ?? false
        let emailHasValidSize = emailTextfield.text?.count ?? 0 > 5
        let emailIsValid = emailHasDot && emailHasAt && emailHasValidSize
        
        if !emailIsValid {
            emailTextfield.setErrorColor()
            textLabel.textColor = .red
            textLabel.text = StringsHelper.checkEmail
            return false
        }
        return true
    }
    
    private func networkResetPassoword() {
        let emailUser = emailTextfield.text!.trimmingCharacters(in: .whitespaces)
        
        let parameters = [ "email": emailUser ]
        
        BadNetworkLayer.shared.resetPassword(self, parameters: parameters) { (success) in
            if success {
                self.resetSucessPassword()
            } else {
                self.coordinator?.alertMsg(title: StringsHelper.OPS, msg: StringsHelper.SOMETHING_WENT_WRONG, titleAction: StringsHelper.OK)
            }
        }
    }
    
    private func resetSucessPassword() {
        self.recoveryEmail = true
        self.emailTextfield.isHidden = true
        self.textLabel.isHidden = true
        self.viewSuccess.isHidden = false
        self.emailLabel.text = self.emailTextfield.text?.trimmingCharacters(in: .whitespaces)
        self.recoverPasswordButton.titleLabel?.text = "REENVIAR E-MAIL"
        self.recoverPasswordButton.setTitle("Voltar", for: .normal)
    }
}

// MARK: - Comportamentos de layout
extension TRResetPasswordViewController {
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
    
    func setupView() {
        configRecoverPassword()
        configLoginButton()
        configHelperButton()
        configAccountButton()
        
        emailTextfield.setDefaultColor()
        validateEmailIsEmpty()
        validateButton()
    }
    
    private func configRecoverPassword() {
        recoverPasswordButton.layer.cornerRadius = recoverPasswordButton.bounds.height / 2
        recoverPasswordButton.backgroundColor = .blue
        recoverPasswordButton.setTitleColor(.white, for: .normal)
    }
    
    private func configLoginButton() {
        loginButton.layer.cornerRadius = createAccountButton.frame.height / 2
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blue.cgColor
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.backgroundColor = .white
    }
    
    private func configHelperButton() {
        helpButton.layer.cornerRadius = createAccountButton.frame.height / 2
        helpButton.layer.borderWidth = 1
        helpButton.layer.borderColor = UIColor.blue.cgColor
        helpButton.setTitleColor(.blue, for: .normal)
        helpButton.backgroundColor = .white
    }
    
    private func configAccountButton() {
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        createAccountButton.layer.borderWidth = 1
        createAccountButton.layer.borderColor = UIColor.blue.cgColor
        createAccountButton.setTitleColor(.blue, for: .normal)
        createAccountButton.backgroundColor = .white
    }
    
    private func validateEmailIsEmpty() {
        if !email.isEmpty {
            emailTextfield.text = email
            emailTextfield.isEnabled = false
        }
    }
}

extension TRResetPasswordViewController {
    func validateButton() {
        let emailIsEmpty = emailTextfield.text
        
        emailIsEmpty?.isEmpty ?? false ? disableCreateButton() : enableCreateButton()
    }
    
    func disableCreateButton() {
        configRecoverPassoworBtn(color: .gray, isEnabled: false, colorTitle: .white)
    }
    
    func enableCreateButton() {
        configRecoverPassoworBtn(color: .blue, isEnabled: true, colorTitle: .white)
    }
    
    func configRecoverPassoworBtn(color: UIColor, isEnabled: Bool, colorTitle: UIColor) {
        recoverPasswordButton.backgroundColor = color
        recoverPasswordButton.setTitleColor(colorTitle, for: .normal)
        recoverPasswordButton.isEnabled = isEnabled
    }
}

extension TRResetPasswordViewController {
    enum StringsHelper {
        static var checkEmail = "Verifique o e-mail informado"
        static var SOMETHING_WENT_WRONG = "Algo de errado aconteceu. Tente novamente mais tarde."
        static var OK = "ok"
        static var OPS = "Ops.."
    }
}
