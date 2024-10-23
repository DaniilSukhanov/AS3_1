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
    private enum Constant {
        static let minHeightTextEditor: CGFloat = 50
        static let offestUpTitleLabel: CGFloat = 10
        static let scrollViewVerticalPadding: CGFloat = 25
        static let spacingMainStackView: CGFloat = 10
        static let customSpacing: CGFloat = 20
        static let heightSubmitButton: CGFloat = 50
        static let widthSubmitButton: CGFloat = 90
        static let botomPaddingSubmitButton: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        static let verticalPaddingPlaceholderTextEditor: CGFloat = 5
        static let leadingPaddingPlaceholderTextEditor: CGFloat = 3
        static let betweenScrollViewStackViewPadding: CGFloat = 10
    }
    
    private lazy var textView: UITextView = {
        let textEditor = UITextView()
        textEditor.isScrollEnabled = false
        textEditor.textColor = AppColor.textColor
        textEditor.layer.borderColor = AppColor.textColor.cgColor
        textEditor.layer.borderWidth = 1
        textEditor.layer.cornerRadius = Constant.cornerRadius
        textEditor.clipsToBounds = true
        textEditor.delegate = self
        return textEditor
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var placeholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Enter text"
        placeholder.textColor = AppColor.textColor.withAlphaComponent(0.3)
        placeholder.font = textView.font ?? (UIFont.systemFont(ofSize: CGFloat(fontSizeSlider.value)))
        return placeholder
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.spacingMainStackView
        return stackView
    }()
    
    private lazy var coloringToggleButton: UIStackView = {
        let toggleButtonColoring = UISwitch()
        toggleButtonColoring.isOn = false
        toggleButtonColoring.addTarget(self, action: #selector(toggleButtonColoringAction), for: .valueChanged)
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let label = UILabel()
        label.text = "Toggle color"
        label.font = .systemFont(ofSize: 14)
        label.textColor = AppColor.textColor
        
        let stackView = UIStackView(arrangedSubviews: [label, spacer, toggleButtonColoring])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 8
        slider.maximumValue = 72
        slider.addTarget(self, action: #selector(sliderValueChangedAction), for: .valueChanged)
        return slider
    }()
    
    private lazy var submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(AppColor.textColor, for: .normal)
        submitButton.backgroundColor = AppColor.backgroudViewButton
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
        setupScrollView()
        setupMainStackView()
        setupTextEditor()
        setupSubmitButton()
        setupPlaceholderTextEditor()
    }
    
    func setupMainStackView() {
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Constant.betweenScrollViewStackViewPadding)
        ])
        
        mainStackView.addArrangedSubview(textView)
        mainStackView.setCustomSpacing(Constant.customSpacing, after: textView)
        mainStackView.addArrangedSubview(coloringToggleButton)
        mainStackView.addArrangedSubview(fontSizeSlider)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.scrollViewVerticalPadding),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.scrollViewVerticalPadding)
        ])
    }
    
    func setupTextEditor() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.minHeightTextEditor).isActive = true
    }
    
    func setupSubmitButton() {
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: Constant.heightSubmitButton),
            submitButton.widthAnchor.constraint(equalToConstant: Constant.widthSubmitButton),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupPlaceholderTextEditor() {
        textView.addSubview(placeholder)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeholder.leadingAnchor.constraint(equalTo: textView.safeAreaLayoutGuide.leadingAnchor, constant: Constant.leadingPaddingPlaceholderTextEditor),
            placeholder.topAnchor.constraint(equalTo: textView.safeAreaLayoutGuide.topAnchor, constant: Constant.verticalPaddingPlaceholderTextEditor),
            placeholder.bottomAnchor.constraint(lessThanOrEqualTo: textView.safeAreaLayoutGuide.bottomAnchor),
       ])
    }
}
            
// MARK: - Setup actions

private extension ViewController {
    func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeFocusTextEditor))
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
        if let touchedView = touch.view, touchedView.isDescendant(of: textView) {
            return false
        }
        return true
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
}

// MARK: - Actions

private extension ViewController {
    @objc func removeFocusTextEditor(_ sender: UITapGestureRecognizer) {
        logger.debug("Tap on remove focuse text editor")
        view.endEditing(true)
    }
    
    @objc func toggleButtonColoringAction(_ sender: UISwitch) {
        logger.debug("toggle button coloring: \(sender.isOn)")
        textView.textColor = sender.isOn ? .red : AppColor.textColor
        textView.layer.borderColor = sender.isOn ? UIColor.red.cgColor : AppColor.textColor.cgColor
        placeholder.textColor = sender.isOn ? .red.withAlphaComponent(0.3) : AppColor.textColor.withAlphaComponent(0.3)
    }
    
    @objc func sliderValueChangedAction(_ sender: UISlider) {
        logger.debug("Sliper value: \(sender.value)")
        let font =  UIFont.systemFont(ofSize: CGFloat(sender.value))
        textView.font = font
        placeholder.font = font
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
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        if let text = textView.text {
            let alert = UIAlertController(title: "Your text!", message: text, preferredStyle: .alert)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            logger.info("Text: \(text)")
        } else {
            let alert = UIAlertController(title: "Error!", message: "Text is incorrect!", preferredStyle: .alert)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            logger.warning("Text is nil!")
        }
    }
}
