import UIKit

extension UITextField {
    func setEditingColor() {
        //visual
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.yellow.cgColor

        //propriedades do texto
        //placeholder
        let color = UIColor.black
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        self.textColor = .black
        self.backgroundColor = .white
    }

    func setDefaultColor() {
        //visual
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor

        //propriedades do texto
        //placeholder
        let color = UIColor.lightGray
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        self.textColor = .black
        self.backgroundColor = .white
    }

    func setErrorColor() {
        //visual
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor

        //propriedades do texto
        //placeholder
        let color = UIColor.black
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        self.textColor = .white
        self.backgroundColor = .black
    }

    func setDisableColor() {
        //visual
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor

        //propriedades do texto
        //placeholder
        let color = UIColor.darkGray
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        self.textColor = .darkGray
        self.isEnabled = false
        self.backgroundColor = .black
    }

    func setEditingColorBorder() {
        //visual
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.yellow.cgColor

        //propriedades do texto
        //placeholder
        let color = UIColor.lightGray
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])

        self.textColor = .black
        self.backgroundColor = .white
    }
}
