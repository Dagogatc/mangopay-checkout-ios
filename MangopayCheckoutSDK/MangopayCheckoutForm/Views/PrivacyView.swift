//
//  PrivacyView.swift
//  
//
//  Created by Elikem Savie on 18/12/2023.
//

import UIKit

public class PrivacyView: UIView {

    lazy var logoInageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(assetIdentifier: .app_icon))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        return imageView
    }()

    lazy var titleLabel = UILabel.create() { label in
        let attrStr = NSMutableAttributedString()
        label.attributedText = {
            attrStr.append(
                NSAttributedString(
                    string: "Processed with Mangopay - ",
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
                        NSAttributedString.Key.foregroundColor: UIColor.gray
                    ])
            )
            
            attrStr.append(NSAttributedString(string: "Privacy", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: UIColor.gray
            ]))
            return attrStr
        }()
    }

    private lazy var hStack = UIStackView.create(
        spacing: 8,
        axis: .horizontal,
        alignment: .leading,
        distribution: .fill,
        views: [titleLabel]
    )

    public var didTapPrivacyAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTapActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = true
        addSubview(hStack)
        hStack.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        hStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        hStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        hStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.backgroundColor = .white
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setupTapActions() {
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUpgradeLabel(gesture:))))
    }

    @objc func didTapUpgradeLabel(gesture: UITapGestureRecognizer) {
        guard let upgradeText = titleLabel.text else {return}
        let updateRange = (upgradeText as NSString).range(of: "Privacy")

        if gesture.didTapAttributedTextInLabel(label: titleLabel, inRange: updateRange) {
            didTapPrivacyAction?()
        }
    }
}
