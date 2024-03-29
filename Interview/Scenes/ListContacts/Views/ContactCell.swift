import UIKit

final class ContactCell: UITableViewCell {
    private let contactImageSize: CGFloat = 100
    private var imageLoadingTask: URLSessionDataTask?
    
    lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadingTask?.cancel()
        fullnameLabel.text = ""
        contactImage.image = nil
    }
    
    func configureViews() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullnameLabel)
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: contactImageSize),
            contactImage.widthAnchor.constraint(equalToConstant: contactImageSize),
            
            fullnameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contactImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contactImage.centerYAnchor)
        ])
    }
    
    func configure(with contact: Contact) {
        fullnameLabel.text = contact.name
        activityIndicator.startAnimating()
        
        guard let imageURL = URL(string: contact.photoURL) else {
            activityIndicator.stopAnimating()
            return
        }
        
        ImageHelper.shared.loadImage(from: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.contactImage.image = image
            }
        }
    }
}
