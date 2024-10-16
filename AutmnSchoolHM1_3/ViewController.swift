//
//  ViewController.swift
//  AutmnSchoolHM1_3
//
//  Created by Даниил Суханов on 14.10.2024.
//

import UIKit

class ViewController: UIViewController {
    private struct Constant {
        static let minHeightTextEditor: CGFloat = 100
    }
    
    private lazy var textEditor: AutoResizeTextView = {
        let textEditor = AutoResizeTextView()
        textEditor.textColor = AppColor.text
        textEditor.layer.borderColor = UIColor.red.cgColor
        textEditor.layer.borderWidth = 1
        textEditor.clipsToBounds = true
        return textEditor
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

private extension ViewController {
    func setup() {
        setupTextEditor()
    }
    
    func setupTextEditor() {
        view.addSubview(textEditor)
        textEditor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textEditor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textEditor.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textEditor.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.minHeightTextEditor)
        ])
    }
}
            
            
            
