//
//  CollectionViewCell.swift
//  testNews
//
//  Created by Malygin Georgii on 29.10.2020.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "cellId"
    
    
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageLikes = UIImageView(image: UIImage(named: "iconLikes"))
    
    private lazy var imageHours = UIImageView(image: UIImage(named: "iconTime"))
    
    private lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 5
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var sityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var tagsItem: UILabel = {
        let tags = UILabel()
        
        tags.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        tags.textColor = .darkGray
        tags.layer.cornerRadius = 5
        tags.layer.masksToBounds = true
        tags.font = .systemFont(ofSize: 15)
        tags.textAlignment = .center
        
        return tags
    }()
    
    private lazy var countLikes: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        
        
        return label
    }()
    
    private lazy var howHours: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        
        
        return label
    }()
    
    private func createImage(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        self.imageView.kf.setImage(with: url)
        
    }
    
    func configureView(photoURL: String, nameLocation: String, sityName: String, tagsName: String, rating: Int, time: String ) {
        createImage(url: photoURL)
        tagsItem.text = tagsName
        sityLabel.text = sityName
        nameLabel.text = nameLocation
        countLikes.text = String(rating)
        howHours.text = time
        
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(tagsItem)
        addSubview(sityLabel)
        addSubview(nameLabel)
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageLikes)
        stackView.addArrangedSubview(countLikes)
        stackView.addArrangedSubview(imageHours)
        stackView.addArrangedSubview(howHours)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tagsItem.translatesAutoresizingMaskIntoConstraints = false
        sityLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            tagsItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tagsItem.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            tagsItem.heightAnchor.constraint(equalToConstant: 25),
            tagsItem.widthAnchor.constraint(equalToConstant: 70),
            
            sityLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            sityLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: sityLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
}
