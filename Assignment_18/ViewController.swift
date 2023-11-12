//
//  ViewController.swift
//  Assignment_18
//
//  Created by Macbook Air 13 on 12.11.23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let tbcLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TBC IT Academy"
        label.font = UIFont(name: "Helvetica-Bold", size: 25.0)
        label.textColor = UIColor(red: 93.0 / 255.0, green: 193.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0)
        label.alpha = 0
        
        return label
    }()
    
    private var tbcLabelCenterYConstraint: NSLayoutConstraint?
    
    private var mainAnimator: UIViewPropertyAnimator?
    

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAndLoadAnimation()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        setupTBCLabel()
    }
    
    private func setupTBCLabel() {
        view.addSubview(tbcLabel)
        activateTBCLabelConstraints()
    }
    
    
    // MARK: - Animations
    private func setupAndLoadAnimation() {
        let duration = 2.0
        
        mainAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
            self.tbcLabelCenterYConstraint?.constant = -50
            self.tbcLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        }
        
        mainAnimator?.addCompletion({ position in
            if position == .end {
                let reverseAnimation = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
                    self.tbcLabelCenterYConstraint?.constant = 0
                    self.tbcLabel.alpha = 0.0
                    self.view.layoutIfNeeded()
                }
                
                reverseAnimation.startAnimation()
                
                reverseAnimation.addCompletion { [weak self] position in
                    if position == .end {
                        self?.setupAndLoadAnimation()
                    }
                }
            }
        })
        
        mainAnimator?.startAnimation()
    }
    
    
    // MARK: - Constraints
    private func activateTBCLabelConstraints() {
        tbcLabelCenterYConstraint = tbcLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        tbcLabelCenterYConstraint?.isActive = true
        
        tbcLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }


}

