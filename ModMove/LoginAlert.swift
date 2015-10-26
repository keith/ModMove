import AppKit
import Foundation

private let SuppressionKey = "loginAlertSuppressionKey"

struct LoginAlert {
    static func showAlertIfNeeded() {
        if NSUserDefaults.standardUserDefaults().boolForKey(SuppressionKey) {
            return
        }

        let alert = NSAlert()
        alert.messageText = "Open ModMove at Login?"
        alert.informativeText = "Would you like to open ModMove at login? To disable it afterwards go to System Preferences -> Accounts"
        alert.showsSuppressionButton = true
        alert.addButtonWithTitle("Open at Login")
        alert.addButtonWithTitle("Cancel")
        let response = alert.runModal()
        if alert.suppressionButton?.state == NSOnState {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: SuppressionKey)
        }

        if response == NSAlertFirstButtonReturn {
            LoginController.setOpensAtLogin(true)
        }
    }
}
