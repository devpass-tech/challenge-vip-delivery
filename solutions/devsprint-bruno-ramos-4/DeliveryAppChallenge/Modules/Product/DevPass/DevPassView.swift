import UIKit

protocol DevPassViewProtocol: UIView {
    func display(viewModel: DevPassView.ViewModel)
}

final class DevPassView: UIView {

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
    private let actionButton = UIButton()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DevPassView: DevPassViewProtocol {
    func display(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}

extension DevPassView: ViewCode {
    func setupComponents() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
    }

    func setupConstraints() {}
}
