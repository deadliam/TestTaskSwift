//
//  ViewController.swift
//  TestTask
//
//  Created by Anatoly Kasyanov on 10/10/17.
//  Copyright © 2017 MacPaw. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSComboBoxDelegate, NSUserNotificationCenterDelegate {

    @IBOutlet weak var askForProgrammingLangsTextLabel: NSTextField!
    @IBOutlet weak var askForNicknameTextLabel: NSTextField!
    @IBOutlet weak var askForSwiftTextLabel: NSTextField!
    
    @IBOutlet weak var nicknameField: NSTextField!
    @IBOutlet weak var languageComboBox: NSComboBox!
    @IBOutlet weak var whyLearningSwiftField: NSTextField!
    
    @IBOutlet weak var sendButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameField.delegate = self
        whyLearningSwiftField.delegate = self
        languageComboBox.delegate = self
        updateButtonEnabledState()
        NSUserNotificationCenter.default.delegate = self
        
    }
    
    func deliverNotification(title: String, subtitle: String, text: String) {
        let notification = NSUserNotification()
        notification.deliveryDate = Date()
        notification.hasActionButton = true
        notification.actionButtonTitle = "Agree"
        notification.title = title
        notification.informativeText = text
        notification.responsePlaceholder = "Placeholder"
        notification.hasReplyButton = true
        notification.contentImage = NSImage(imageLiteralResourceName: "NotificationImage")
        NSUserNotificationCenter.default.deliver(notification)
        
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    override func controlTextDidChange(_ notification: Notification) {
        updateButtonEnabledState()
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        updateButtonEnabledState()
    }
    
    func updateButtonEnabledState() {
        sendButton.isEnabled = nicknameField.stringValue.isEmpty == false &&
            whyLearningSwiftField.stringValue.isEmpty == false &&
            languageComboBox.indexOfSelectedItem != NSNotFound
    }
    
    
    @IBAction func buttonClick(button: AnyObject) {
        print("Test log")
        let indexCombo = languageComboBox.indexOfSelectedItem
        let valuecombo = languageComboBox.itemObjectValue(at: indexCombo)
        deliverNotification(title: nicknameField.stringValue, subtitle: valuecombo as! String, text: whyLearningSwiftField.stringValue)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

