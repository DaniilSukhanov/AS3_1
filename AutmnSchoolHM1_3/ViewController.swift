//
//  ViewController.swift
//  AutmnSchoolHM1_3
//
//  Created by Даниил Суханов on 14.10.2024.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    private let logger = Logger(subsystem: "AutmnSchoolHM1_3", category: "ViewController")
    private struct Constant {
        static let minHeightTextEditor: CGFloat = 50
        static let offestUpTitleLabel: CGFloat = 10
        static let verticalPaddingScrollView: CGFloat = 25
        static let spacingMainStackView: CGFloat = 10
        static let customSpacing: CGFloat = 20
        static let heightSubmitButton: CGFloat = 50
        static let widthSubmitButton: CGFloat = 90
        static let botomPaddingSubmitButton: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        static let verticalPaddingPlaceholderTextEditor: CGFloat = 5
        static let leadingPaddingPlaceholderTextEditor: CGFloat = 3
    }
    
    private lazy var textEditor: UITextView = {
        let textEditor = UITextView()
        textEditor.isScrollEnabled = false
        textEditor.textColor = AppColor.text
        textEditor.layer.borderColor = AppColor.text.cgColor
        textEditor.layer.borderWidth = 1
        textEditor.layer.cornerRadius = Constant.cornerRadius
        textEditor.clipsToBounds = true
        textEditor.delegate = self
        return textEditor
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var placeholderTextEditor: UILabel = {
        let placeholderTextEditor = UILabel()
        placeholderTextEditor.text = "Enter text"
        placeholderTextEditor.textColor = AppColor.text.withAlphaComponent(0.3)
        placeholderTextEditor.font = textEditor.font ?? (UIFont.systemFont(ofSize: CGFloat(sliderSizeFont.value)))
        return placeholderTextEditor
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.spacingMainStackView
        return stackView
    }()
    
    private lazy var toggleButtonColoring: UIStackView = {
        let toggleButtonColoring = UISwitch()
        toggleButtonColoring.isOn = false
        toggleButtonColoring.addTarget(self, action: #selector(toggleButtonColoringAction), for: .valueChanged)
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let labelToggleButtonColoring = UILabel()
        labelToggleButtonColoring.text = "is red text"
        labelToggleButtonColoring.font = .systemFont(ofSize: 14)
        labelToggleButtonColoring.textColor = AppColor.text
        
        let stackView = UIStackView(arrangedSubviews: [labelToggleButtonColoring, spacer, toggleButtonColoring])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var sliderSizeFont: UISlider = {
        let sliderSizeFont = UISlider()
        sliderSizeFont.minimumValue = 8
        sliderSizeFont.maximumValue = 72
        sliderSizeFont.addTarget(self, action: #selector(sliderValueChangedAction), for: .valueChanged)
        return sliderSizeFont
    }()
    
    private lazy var submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(AppColor.text, for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.layer.cornerRadius = Constant.cornerRadius
        submitButton.addTarget(self, action: #selector(submitRemoveOpacityAction), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitOpacityAction), for: .touchDown)
        submitButton.addTarget(self, action: #selector (submitRemoveOpacityAction), for: .touchUpOutside)
        submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        return submitButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupAction()
        
        title = "Editor"
        view.backgroundColor = AppColor.backgroudView
    }
    
}

// MARK: - Layouts

private extension ViewController {
    func setupLayouts() {
        setupLayoutsScrollView()
        setupLayoutsMainStackView()
        setupLayoutsTextEditor()
        setupLayoutsSubmitButton()
        setupLayoutsPlaceholderTextEditor()
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
        
        mainStackView.addArrangedSubview(textEditor)
        mainStackView.setCustomSpacing(Constant.customSpacing, after: textEditor)
        mainStackView.addArrangedSubview(toggleButtonColoring)
        mainStackView.addArrangedSubview(sliderSizeFont)
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
        textEditor.translatesAutoresizingMaskIntoConstraints = false
        textEditor.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.minHeightTextEditor).isActive = true
    }
    
    func setupLayoutsSubmitButton() {
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: Constant.heightSubmitButton),
            submitButton.widthAnchor.constraint(equalToConstant: Constant.widthSubmitButton),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.botomPaddingSubmitButton),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupLayoutsPlaceholderTextEditor() {
        textEditor.addSubview(placeholderTextEditor)
        placeholderTextEditor.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeholderTextEditor.leadingAnchor.constraint(equalTo: textEditor.safeAreaLayoutGuide.leadingAnchor, constant: Constant.leadingPaddingPlaceholderTextEditor),
            placeholderTextEditor.topAnchor.constraint(equalTo: textEditor.safeAreaLayoutGuide.topAnchor, constant: Constant.verticalPaddingPlaceholderTextEditor),
            placeholderTextEditor.bottomAnchor.constraint(lessThanOrEqualTo: textEditor.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.verticalPaddingPlaceholderTextEditor),
       ])
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

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderTextEditor.isHidden = !textEditor.text.isEmpty
    }
}

// MARK: - Actions

private extension ViewController {
    @objc func removeFocuseTextEditor(_ sender: UITapGestureRecognizer) {
        logger.debug("Tap on remove focuse text editor")
        view.endEditing(true)
    }
    
    @objc func toggleButtonColoringAction(_ sender: UISwitch) {
        logger.debug("toggle button coloring: \(sender.isOn)")
        textEditor.textColor = sender.isOn ? .red : AppColor.text
        textEditor.layer.borderColor = sender.isOn ? UIColor.red.cgColor : AppColor.text.cgColor
        placeholderTextEditor.textColor = sender.isOn ? .red.withAlphaComponent(0.3) : AppColor.text.withAlphaComponent(0.3)
    }
    
    @objc func sliderValueChangedAction(_ sender: UISlider) {
        logger.debug("Sliper value: \(sender.value)")
        let font =  UIFont.systemFont(ofSize: CGFloat(sender.value))
        textEditor.font = font
        placeholderTextEditor.font = font
    }
    
    @objc func submitOpacityAction() {
        logger.debug("Tap on submit opacity")
        submitButton.layer.opacity = 0.5
    }
    
    @objc func submitRemoveOpacityAction() {
        logger.debug("Tap on remove submit opacity")
        submitButton.layer.opacity = 1
    }
    
    @objc func submitAction() {
        if let text = textEditor.text {
            logger.info("Text: \(text)")
        } else {
            logger.warning("Text is nil!")
        }
    }
}
