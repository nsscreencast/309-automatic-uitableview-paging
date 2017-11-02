//
//  BeerCell.swift
//  BeerScroller
//
//  Created by Ben Scheirman on 10/25/17.
//  Copyright © 2017 NSScreencast. All rights reserved.
//

import UIKit

class BeerCell : UITableViewCell {
    var beerNameLabel: UILabel!
    var breweryLabel: UILabel!
    var abvLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeSubviews() {
        beerNameLabel = UILabel()
        beerNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        beerNameLabel.textColor = UIColor(white: 0.3, alpha: 1.0)
        beerNameLabel.numberOfLines = 1
        
        breweryLabel = UILabel()
        breweryLabel.font = UIFont.systemFont(ofSize: 14)
        breweryLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        beerNameLabel.numberOfLines = 1
        
        abvLabel = UILabel()
        abvLabel.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        abvLabel.textColor = .white
        abvLabel.layer.cornerRadius = 10
        abvLabel.layer.masksToBounds = true
        abvLabel.font = UIFont.boldSystemFont(ofSize: 10)
        abvLabel.textAlignment = .center
        abvLabel.text = "5.8%"
        
        abvLabel.widthAnchor.constraint(equalToConstant: 36).isActive = true
        abvLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [beerNameLabel, breweryLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        
        let horizontalStack = UIStackView(arrangedSubviews: [stack, abvLabel])
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .center
        
        contentView.addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        
    }
}
