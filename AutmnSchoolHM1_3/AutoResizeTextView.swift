//
//  AutoResizeTextView.swift
//  AutmnSchoolHM1_3
//
//  Created by Даниил Суханов on 16.10.2024.
//

import UIKit

final class AutoResizeTextView: UITextView, UITextViewDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .null, textContainer: nil)
        isScrollEnabled = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var newFrame = frame
        
        let fixedWidth = frame.size.width
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.frame = newFrame
    }
}
