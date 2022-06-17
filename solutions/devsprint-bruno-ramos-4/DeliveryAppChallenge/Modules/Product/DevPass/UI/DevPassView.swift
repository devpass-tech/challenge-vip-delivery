import UIKit

protocol DevPassViewDelegate: AnyObject {
    func didTapOnLoadScreen()
}

protocol DevPassViewProtocol: UIView {
    func display(viewModel: DevPassView.ViewModel)
}

final class DevPassView: UIView {

    weak var delegate: DevPassViewDelegate?

    struct ViewModel {
        let title: String
        let description: String
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel = UILabel()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapOnActionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc func didTapOnActionButton() {
        delegate?.didTapOnLoadScreen()
    }
}

extension DevPassView: DevPassViewProtocol {
    func display(viewModel: ViewModel) {
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
}

extension DevPassView: ViewCode {
    func setupComponents() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupExtraConfiguration() {
        backgroundColor = .white
    }
}
