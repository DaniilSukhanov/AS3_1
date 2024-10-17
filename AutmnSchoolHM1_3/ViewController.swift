//
//  ViewController.swift
//  AutmnSchoolHM1_3
//
//  Created by Даниил Суханов on 14.10.2024.
//

import UIKit

class ViewController: UIViewController {
    private struct Constant {
        static let minHeightTextEditor: CGFloat = 50
        static let offestUpTitleLabel: CGFloat = 10
        static let verticalPaddingScrollView: CGFloat = 25
        static let spacingMainStackView: CGFloat = 10
    }
    
    private lazy var textEditor: AutoResizeTextView = {
        let textEditor = AutoResizeTextView()
        textEditor.textColor = AppColor.text
        textEditor.layer.borderColor = UIColor.red.cgColor
        textEditor.layer.borderWidth = 1
        textEditor.clipsToBounds = true
        return textEditor
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.spacingMainStackView
        return stackView
    }()
    
    private lazy var labelToggleButtonColoring: UILabel = {
        let labelToggleButtonColoring = UILabel()
        labelToggleButtonColoring.text = "Toggle button coloring"
        labelToggleButtonColoring.font = .systemFont(ofSize: 14)
        labelToggleButtonColoring.textColor = AppColor.text
        return labelToggleButtonColoring
    }()
    
    private lazy var toggleButtonColoring: UISwitch = {
        let toggleButtonColoring = UISwitch()
        toggleButtonColoring.isOn = false
        toggleButtonColoring.addTarget(self, action: #selector(toggleButtonColoringAction), for: .valueChanged)
        return toggleButtonColoring
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupAction()
        title = "Test"
        
        view.backgroundColor = AppColor.backgroudView
    }
    
}

// MARK: - Layouts

private extension ViewController {
    func setupLayouts() {
        setupLayoutsScrollView()
        setupLayoutsMainStackView()
        setupLayoutsTextEditor()
        setupLayoutsToggleButtonColoring()
    }
    
    func setupLayoutsToggleButtonColoring() {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        let stackView = UIStackView(arrangedSubviews: [labelToggleButtonColoring, spacer, toggleButtonColoring])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        mainStackView.addArrangedSubview(stackView)
    }
    
    func setupLayoutsMainStackView() {
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupLayoutsScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.verticalPaddingScrollView),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.verticalPaddingScrollView)
        ])
    }
    
    func setupLayoutsTextEditor() {
        mainStackView.addArrangedSubview(textEditor)
        textEditor.translatesAutoresizingMaskIntoConstraints = false
        textEditor.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.minHeightTextEditor).isActive = true
    }
}
            
// MARK: - Setup actions

private extension ViewController {
    func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeFocuseTextEditor))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tapGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view, touchedView.isDescendant(of: textEditor) {
            return false
        }
        return true
    }
}

// MARK: - Actions

private extension ViewController {
    @objc func removeFocuseTextEditor(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func toggleButtonColoringAction(_ sender: UISwitch) {
        textEditor.textColor = sender.isOn ? .red: AppColor.text
    }
}
