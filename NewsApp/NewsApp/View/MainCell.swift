//
//  MainCell.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/15.
//

import Foundation
import UIKit

class MainCell: UICollectionViewCell {
    
    let storyIDsLabel: UILabel = {
        let storyIDsLabel = UILabel()
        storyIDsLabel.textAlignment = .center
        storyIDsLabel.font = .systemFont(ofSize: 30)
        storyIDsLabel.textColor = .black
        
        return storyIDsLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }

    func setup() {
        contentView.backgroundColor = ColorTheme.lightYellow.color
        contentView.layer.cornerRadius = 25
        contentView.layer.masksToBounds = true
        
        addViews()
        setConstratints()
    }
    
    func addViews() {
        addSubview(storyIDsLabel)
    }
    
    func setConstratints() {
        storyIDsLabelConstraints()
    }
    
    func storyIDsLabelConstraints() {
        storyIDsLabel.translatesAutoresizingMaskIntoConstraints = false
        storyIDsLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        storyIDsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        storyIDsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        storyIDsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
