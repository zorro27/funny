//
//  Keyboard.swift
//  funny
//
//  Created by Роман Зобнин on 31.01.2021.
//

import Foundation

func registerForKeyboardNotification() {
    NotificationCenter.default.addObserver(self , selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self , selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
}


