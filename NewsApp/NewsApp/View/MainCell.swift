//
//  MainCell.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/15.
//

import Foundation
import UIKit

class MainCell: UICollectionViewCell {
    
    let stackView: UIStackView = {
      let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    let storyIDsLabel: UILabel = {
        let storyIDsLabel = UILabel()
        storyIDsLabel.font = .systemFont(ofSize: 30)
        storyIDsLabel.textColor = .black
        storyIDsLabel.adjustsFontSizeToFitWidth = true
        return storyIDsLabel
    }()
    
    let authorByLabel: UILabel = {
        let authorByLabel = UILabel()
        authorByLabel.adjustsFontSizeToFitWidth = true
        authorByLabel.textColor = ColorTheme.lightGray.color
        authorByLabel.font = .boldSystemFont(ofSize: 10)
        return authorByLabel
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.font = .boldSystemFont(ofSize: 10)
        timeLabel.textColor = ColorTheme.timeGray.color
        
        return timeLabel
    }()
    
    let authorTimeContainer: UIStackView = {
        let authorTimeContainer = UIStackView()
        authorTimeContainer.axis = .horizontal
        
        return authorTimeContainer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }

    func setup() {
        contentView.layer.addBorder([.bottom], color: UIColor.gray, width: 1.0)
        
        addViews()
        setConstratints()
    }
    
    func addViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(storyIDsLabel)
        
        stackView.addArrangedSubview(authorTimeContainer)
        authorTimeContainer.addArrangedSubview(authorByLabel)
        authorTimeContainer.setCustomSpacing(15, after: authorByLabel)
        authorTimeContainer.addArrangedSubview(timeLabel)
        
    }
    
    func setConstratints() {
        stackViewConstratins()
        storyIDsLabelConstraints()
        authorByLabelConstraints()
    }
    
    func stackViewConstratins() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func storyIDsLabelConstraints() {
        storyIDsLabel.translatesAutoresizingMaskIntoConstraints = false
        storyIDsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func authorByLabelConstraints() {
        authorByLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
