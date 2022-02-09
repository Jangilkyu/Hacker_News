//
//  Extension.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/30.
//

import UIKit

extension UIView {
    
    func addSpinner() {
        let background = UIView()
        addSubview(background)
        background.tag = 0001
        background.backgroundColor = .init(white: 0, alpha: 0.7)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        addSubview(spinner)
        spinner.tag = 0002
        spinner.color = .systemPink
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.widthAnchor.constraint(equalToConstant: 500).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 500).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func removeSpinner() {
        let views = subviews.filter { view in
            return view.tag == 0001 || view.tag == 0002
        }
        
        views.forEach { view in
            view.removeAllConstraints()
            view.removeFromSuperview()
        }
    }
    
    func removeAllConstraints() {
        self.removeConstraints(self.constraints)
        for view in self.subviews {
            view.removeAllConstraints()
        }
    }
    
}
