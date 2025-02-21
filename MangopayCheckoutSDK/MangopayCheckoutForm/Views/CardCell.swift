//
//  File.swift
//  
//
//  Created by Elikem Savie on 13/10/2022.
//

#if os(iOS)
import UIKit
#endif

class CardCell: UICollectionViewCell {
    static let id = "\(CardCell.self)"

    lazy var cardImage = IconImage.create(
        iconName: "dropDownIcon",
        iconHeight: 20,
        iconWidth: 32,
        contentMode: .scaleAspectFit
    )

    var topconstriant: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(cardImage)
        topconstriant = cardImage.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        topconstriant.isActive = true
        cardImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        cardImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        cardImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        cardImage.clipsToBounds = true
        self.clipsToBounds = true
    }

 
    func configure(with card: CardType) {
        cardImage.image = card.icon

        if card == .cb {
            cardImage.contentMode = .scaleAspectFill
        }
    }

}
