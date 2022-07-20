import UIKit

class PTResetPasswordViewController: UIViewController {
    
    private let customView: PTResetPasswordView
    private let loadingScreen: LoadingController
    
    let email = ""
    var recoveryEmail = false
    
    init(customView: PTResetPasswordView, loadingScreen: LoadingController){
        self.customView = customView
        self.loadingScreen = loadingScreen
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.customView = PTResetPasswordView()
        self.loadingScreen = LoadingController()
        super.init(coder: coder)
    }
    
    func setupView(){
        if !email.isEmpty {
            self.customView.emailTextfield.text = email
            self.customView.emailTextfield.isEnabled = false
        }
        validateButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            return
        }
        
        if validateForm() {
            self.view.endEditing(true)
            if !ConnectivityManager.shared.isConnected {
                Globals.showNoInternetCOnnection(controller: self)
                return
            }
            
            let emailUser = customView.emailTextfield.text!.trimmingCharacters(in: .whitespaces)
            
            let parameters = [
                "email": emailUser
            ]
            
            resetPassword(self, parameters: parameters)
        }
    }
    
    func resetPassword(_ targetVc: UIViewController, parameters: [String: String]) {
        BadNetworkLayer.shared.resetPassword(targetVc, parameters: parameters) { (success) in
            if success {
                self.recoveryEmail = true
                self.customView.emailTextfield.isHidden = true
                self.customView.textLabel.isHidden = true
                self.customView.viewSuccess.isHidden = false
                self.customView.emailLabel.text = self.customView.emailTextfield.text?.trimmingCharacters(in: .whitespaces)
                self.customView.recoverPasswordButton.titleLabel?.text = "REENVIAR E-MAIL"
                self.customView.recoverPasswordButton.setTitle("Voltar", for: .normal)
            } else {
                let alertController = UIAlertController(title: "Ops..", message: "Algo de errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(action)
                self.present(alertController, animated: true)
            }
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let vc = PTContactUsViewController()
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let newVc = PTCreateAccountViewController()
        newVc.modalPresentationStyle = .fullScreen
        present(newVc, animated: true)
    }
    
    func validateForm() -> Bool {
        let status = !self.customView.emailTextfield.text!.isEmpty ||
        !self.customView.emailTextfield.text!.contains(".") ||
        !self.customView.emailTextfield.text!.contains("@") ||
        self.customView.emailTextfield.text!.count <= 5
        
        if status {
            self.customView.emailTextfield.setErrorColor()
            self.customView.textLabel.textColor = .red
            self.customView.textLabel.text = "Verifique o e-mail informado"
            return false
        }
        
        return true
    }
}

// MARK: - Comportamentos de layout
extension PTResetPasswordViewController {
    
    //email
    @IBAction func emailBeginEditing(_ sender: Any) {
        self.customView.emailTextfield.setEditingColor()
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        self.customView.emailTextfield.setEditingColor()
        validateButton()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        self.customView.emailTextfield.setDefaultColor()
    }
}

extension PTResetPasswordViewController {
    
    func validateButton() {
        if !self.customView.emailTextfield.text!.isEmpty {
            enableCreateButton()
        } else {
            disableCreateButton()
        }
    }
    
    func disableCreateButton() {
        self.customView.recoverPasswordButton.backgroundColor = .gray
        self.customView.recoverPasswordButton.setTitleColor(.white, for: .normal)
        self.customView.recoverPasswordButton.isEnabled = false
    }
    
    func enableCreateButton() {
        self.customView.recoverPasswordButton.backgroundColor = .blue
        self.customView.recoverPasswordButton.setTitleColor(.white, for: .normal)
        self.customView.recoverPasswordButton.isEnabled = true
    }
}
