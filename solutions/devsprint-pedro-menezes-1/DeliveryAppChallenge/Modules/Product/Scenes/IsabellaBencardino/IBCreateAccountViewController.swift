import UIKit

class IBCreateAccountViewController: UIViewController {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var documentTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmation: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var passwordConfirmation: UITextField!
    @IBOutlet weak var showConfirmPasswordButton: UIButton!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    @IBOutlet weak var documentErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var emailConfirmationErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    
    var showPassword = true
    var showConfirmPassword = true
    
    var user = User()
    var keyboardAppearenceManager: KeyboardAppearenceManaging?
    var textfieldReturnKeyManager: TextfieldReturnKeyManaging?

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private var document: String {
        replaceDocumentString(document: self.documentTextField.text!)
    }
    private var documentType: String {
        document.count == 11 ? "cpf" : "cnpj"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupManagers()
        setupView()
    }

// MARK: - Actions
    @IBAction func closedButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        if isFormValid() {
            updateUserProperty()
            updateMessagingToken() { token in
                self.startCreateAuthUser(with: token)
            }
        }
    }

    @IBAction func nameEditing(_ sender: Any) {
        validateCreateButton()
        let text = nameTextField.text ?? ""
        let okayChars : Set<Character> =
                Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        let differentLetters = String(text.filter { okayChars.contains($0) })
        if text != differentLetters {
            nameErrorLabel.text = "Por favor, utilize somente letras"
        } else {
            nameErrorLabel.text = ""
        }
        nameTextField.text = differentLetters
    }

    @IBAction func nameBeginEditing(_ sender: Any) {
        nameTextField.setEditingColorBorder()
        nameErrorLabel.text = ""
    }
    @IBAction func nameEndEditing(_ sender: Any) {
        nameTextField.setDefaultColor()
    }
    
    @IBAction func phoneEditing(_ sender: Any) {
        let okayNumbers : Set<Character> = Set("0123456789")
        let phoneNumbers =  String(phoneTextField.text!.filter { okayNumbers.contains($0) })
        phoneTextField.text = phoneNumbers
        validateCreateButton()
    }
    
    @IBAction func phoneBeginEditing(_ sender: Any) {
        phoneTextField.setEditingColorBorder()
        phoneErrorLabel.text = ""
    }
    @IBAction func phoneEndEditing(_ sender: Any) {
        phoneTextField.setDefaultColor()
    }
    
    @IBAction func documetEditing(_ sender: Any) {
        let okayNumbers : Set<Character> = Set("0123456789")
        let documentNumbers =  String(phoneTextField.text!.filter { okayNumbers.contains($0) })
        documentTextField.text = documentNumbers
        validateCreateButton()
    }
    
    @IBAction func documentBeginEditing(_ sender: Any) {
        documentTextField.setEditingColorBorder()
        documentErrorLabel.text = ""
    }
    @IBAction func documentEndEditing(_ sender: Any) {
        documentTextField.setDefaultColor()
    }
    
    @IBAction func emailEditing(_ sender: Any) {
        validateCreateButton()
    }
    
    @IBAction func emailBeginEditing(_ sender: Any) {
        emailTextField.setEditingColorBorder()
        emailErrorLabel.text = ""
    }
    @IBAction func emailEndEditing(_ sender: Any) {
        emailTextField.setDefaultColor()
    }
    
    @IBAction func emailConfirmationEditing(_ sender: Any) {
        validateCreateButton()
    }
    
    @IBAction func emailConfirmationBeginEditing(_ sender: Any) {
        emailConfirmation.setEditingColorBorder()
        emailConfirmationErrorLabel.text = ""
    }
    @IBAction func emailConfirmationEndEditing(_ sender: Any) {
        emailConfirmation.setDefaultColor()
    }
    
    @IBAction func passwordEditing(_ sender: Any) {
        validateCreateButton()
    }
    
    @IBAction func passwordBeginEditing(_ sender: Any) {
        passwordTextField.setEditingColorBorder()
        passwordErrorLabel.text = ""
    }
    @IBAction func passwordEndEditing(_ sender: Any) {
        passwordTextField.setDefaultColor()
    }
    
    @IBAction func passwordConfirmationEditing(_ sender: Any) {
        validateCreateButton()
    }
    
    @IBAction func passwordConfirmationBeginEditing(_ sender: Any) {
        passwordConfirmation.setEditingColorBorder()
        passwordErrorLabel.text = ""
    }
    @IBAction func passwordConfirmationEndEditing(_ sender: Any) {
        passwordConfirmation.setDefaultColor()
    }
    
    @IBAction func showPassword(_ sender: Any) {
        if(showPassword == true) {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage(named: "ic_hide_password"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage(named: "ic_show_password"), for: .normal)
        }
        showPassword = !showPassword
    }
    
    @IBAction func showConfirmPassword(_ sender: Any) {
        if(showConfirmPassword == true) {
            passwordConfirmation.isSecureTextEntry = false
            showConfirmPasswordButton.setImage(UIImage(named: "ic_hide_password"), for: .normal)
        } else {
            passwordConfirmation.isSecureTextEntry = true
            showConfirmPasswordButton.setImage(UIImage(named: "ic_show_password"), for: .normal)
        }
        showConfirmPassword = !showConfirmPassword
    }

    func setupView() {        
        hideKeyboardWhenTappedAround()
        viewMain.layer.cornerRadius = 5
        createButton.layer.cornerRadius = createButton.frame.height / 2

        nameTextField.setDefaultColor()
        phoneTextField.setDefaultColor()
        documentTextField.setDefaultColor()
        emailTextField.setDefaultColor()
        emailConfirmation.setDefaultColor()
        passwordTextField.setDefaultColor()
        passwordConfirmation.setDefaultColor()

        disableCreateButton()
        passwordTextField.textContentType = .oneTimeCode
        passwordConfirmation.textContentType = .oneTimeCode
    }

    func setupManagers() {
        keyboardAppearenceManager = KeyboardAppearenceManager(viewController: self,
                                                              topConstraint: contentViewTopConstraint)

        let textFields: [UITextField] = [
          nameTextField,
          phoneTextField,
          documentTextField,
          emailTextField,
          emailConfirmation,
          passwordTextField,
          passwordConfirmation
        ]
        textfieldReturnKeyManager = TextfieldReturnKeyManager()
        textfieldReturnKeyManager?.start(textfields: textFields,
                                         lastKeyType: .go,
                                         completionLastKey: {
            self.createAccountButton(self.createButton ?? UIButton())
        })
    }

    func updateUserProperty() {
        user.documentType = documentType
        let text = phoneTextField.text ?? ""
        user.phoneNumber = replacePhoneString(phone: text)
        user.name = self.nameTextField.text!
        user.document = document
    }

    func replacePhoneString(phone: String) -> String {
        return phone.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
    }

    func replaceDocumentString(document: String) -> String {
        return document.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "/", with: "")
    }

    func updateMessagingToken(completion: @escaping (String)->Void) {
        Messaging.messaging.token { result, error in
            if let error = error {
                print("[FIREBASE] - Erro ao recuperar instance ID: \(error)")
            } else if let result = result {
                completion(result)
            }
        }
    }

    func startCreateAuthUser(with token: String) {
        let user = [
            "name": self.nameTextField.text!,
            "phone_number": self.replacePhoneString(phone: self.phoneTextField.text!),
            "document": self.document,
            "document_type": self.documentType,
            "email": self.emailTextField.text!,
            "password": self.passwordTextField.text!,
            "token_id_push": token
        ]
        self.createUser(user)
    }

    func disableCreateButton() {
        createButton.backgroundColor = .gray
        createButton.setTitleColor(.lightGray, for: .normal)
        createButton.isEnabled = false
    }

    func enableCreateButton() {
        createButton.backgroundColor = .blue
        createButton.setTitleColor(.white, for: .normal)
        createButton.isEnabled = true
    }

    func isFormValid() -> Bool {
        var isValid = true
        
        if nameTextField.text!.isEmpty {
            nameTextField.setErrorColor()
            nameErrorLabel.text = "Informe seu nome completo."
            isValid = false

        } else {
            let fullNameArr = nameTextField.text!.components(separatedBy: " ")
            if fullNameArr.count <= 1 {
                nameTextField.setErrorColor()
                nameErrorLabel.text = "Informe seu nome completo."
                isValid = false
            }
        }

        if !isPhoneTextfielValid() {
            phoneTextField.setErrorColor()
            phoneErrorLabel.text = "O número deve ter 11 caracteres."
            isValid = false
        }

        if documentTextField.text!.isEmpty {
            documentTextField.setErrorColor()
            documentErrorLabel.text = "Informe seu CPF/CNPJ."
            isValid = false
        }

        if emailTextField.text!.isEmpty ||
            !emailTextField.text!.contains(".") ||
            !emailTextField.text!.contains("@") ||
            emailTextField.text!.count <= 5 {
            emailTextField.setErrorColor()
            emailErrorLabel.text = "E-mail inválido."
            isValid = false
        }

        if emailConfirmation.text!.isEmpty ||
            !emailConfirmation.text!.contains(".") ||
            !emailConfirmation.text!.contains("@") ||
            emailConfirmation.text!.count <= 5 {
            emailConfirmation.setErrorColor()
            emailConfirmationErrorLabel.text = "E-mail inválido."
            isValid = false
        }

        if emailConfirmation.text?.trimmingCharacters(in: .whitespaces) != emailTextField.text?.trimmingCharacters(in: .whitespaces) {
            emailTextField.setErrorColor()
            emailConfirmation.setErrorColor()
            emailErrorLabel.text = "E-mails devem ser iguais."
            emailConfirmationErrorLabel.text = "E-mails devem ser iguais."
            isValid = false
        } else {
            passwordTextField.setDefaultColor()
            passwordConfirmation.setDefaultColor()
        }

        let okayChars : Set<Character> = Set("ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        let capitalizedLetter =  String(passwordTextField.text!.filter { okayChars.contains($0) })
        if capitalizedLetter.count == 0 {
            passwordTextField.setErrorColor()
            passwordConfirmation.setErrorColor()
            passwordErrorLabel.text = "A senha deve ter uma letra"
            isValid = false
        }

        let okayNumbers : Set<Character> = Set("0123456789")
        let numbersPassword =  String(passwordTextField.text!.filter { okayNumbers.contains($0) })
        if numbersPassword.count == 0 {
            passwordTextField.setErrorColor()
            passwordConfirmation.setErrorColor()
            passwordErrorLabel.text = "A senha deve ter um número."
            isValid = false
        }

        if passwordTextField.text!.count < 5 {
            passwordTextField.setErrorColor()
            passwordConfirmation.setErrorColor()
            passwordErrorLabel.text = "A senha deve ter no mínimo 6 caracteres"
            isValid = false
        }

        if passwordConfirmation.text != passwordTextField.text {
            passwordTextField.setErrorColor()
            passwordConfirmation.setErrorColor()
            passwordErrorLabel.text = "Senhas devem ser iguais."
            isValid = false
        }
        return isValid
    }

    func isPhoneTextfielValid() -> Bool {
        let text = replacePhoneString(phone: phoneTextField.text ?? "")
        if text.count == 11 {
            return true
        } else {
            return false
        }
    }

    func validateCreateButton() {
        let isValid =  !nameTextField.text!.isEmpty
        && !phoneTextField.text!.isEmpty
        && !documentTextField.text!.isEmpty
        && !emailTextField.text!.isEmpty
        && !emailConfirmation.text!.isEmpty
        && !passwordTextField.text!.isEmpty
        && !passwordConfirmation.text!.isEmpty

        if isValid {
            self.enableCreateButton()
        }else{
            self.disableCreateButton()
        }
    }
}

// MARK: - Alamofire
extension IBCreateAccountViewController {
    func createUser(_ parameters: [String : String]) {
        if !ConnectivityManager.shared.isConnected {
            let alertController = UIAlertController(title: "Sem conexão", message: "Conecte-se à internet para tentar novamente", preferredStyle: .alert)
            let actin = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(actin)
            present(alertController, animated: true)
            return
        }
        self.showLoading()

        let url = Endpoints.Auth.createUser
        AF.request(url, method: .post, parameters: parameters, headers: nil) { result in
            self.stopLoading()
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let session = try? decoder.decode(Session.self, from: data) {
                    self.successedAPI(session: session)
                } else {
                    print("nao conseguiu decodificar")
                }
            case .failure(let error):
                print("error criando conta: \(error.localizedDescription)")
                self.showDefaultError()
            }
        }
    }

    func successedAPI(session: Session) {
        user.id = session.id
        let userDefaults = UserDefaults.standard
        if let encodedSession = try? JSONEncoder().encode(session) {
            userDefaults.set(encodedSession, forKey: "sessionNewData")
        }
        if let encodedUser = try? JSONEncoder().encode(user){
            userDefaults.set(encodedUser, forKey: "userNewData")
        }
        userDefaults.set(session.id, forKey: "userID")
        signInFirebase(session.token)
    }

    func showDefaultError() {
        Globals.alertMessage(
            title: "Ops",
            message: "Algo de errado aconteceu. Tente novamente mais tarde.",
            targetVC: self
        )
    }
}

// MARK: - Firebase
extension IBCreateAccountViewController {
    func signInFirebase(_ token: String) {
        DispatchQueue.main.async {
            self.showLoading()
        }
        Auth.auth().signIn(withCustomToken: token) { (user, error) in
            DispatchQueue.main.async {
                self.stopLoading()

                if error != nil {
                    Globals.alertMessage(
                        title: "Ops",
                        message: error!.localizedDescription,
                        targetVC: self
                    )
                } else {
                    let vc = UINavigationController(rootViewController: HomeViewController())
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene
                    let window = windowScene?.windows.first
                    window?.rootViewController = vc
                    window?.makeKeyAndVisible()
                }
            }
        }
    }
}

extension IBCreateAccountViewController: KeyboardAppearenceDelegate {
    func keyboardWillShow(_ notification: Notification) {
        keyboardAppearenceManager?.keyboardWillShow(notification)
    }

    func keyboardWillHide(_ notification: Notification) {
        keyboardAppearenceManager?.keyboardWillHide(notification)
    }
}
