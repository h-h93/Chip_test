//
//  CustomHomeCollectionViewCell.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import UIKit

class CustomHomeCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        // apply accessibility to text
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let randomColor = UIColor.random.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 5
        imageView.layer.borderColor = randomColor
        imageView.tintColor = UIColor(cgColor: randomColor)
        self.addSubview(imageView)
        self.addSubview(textView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1)
    }
}
