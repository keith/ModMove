import AppKit
import Foundation

private let SuppressionKey = "loginAlertSuppressionKey"

struct LoginAlert {
    static func showAlertIfNeeded() {
        if UserDefaults.standard.bool(forKey: SuppressionKey) {
            return
        }

        let alert = NSAlert()
        alert.messageText = "Open ModMove at Login?"
        alert.informativeText = "Would you like to open ModMove at login? To disable it afterwards go to System Preferences -> Accounts"
        alert.showsSuppressionButton = true
        alert.addButton(withTitle: "Open at Login")
        alert.addButton(withTitle: "Cancel")
        let response = alert.runModal()
        if alert.suppressionButton?.state == NSOnState {
            UserDefaults.standard.set(true, forKey: SuppressionKey)
        }

        if response == NSAlertFirstButtonReturn {
            LoginController.setOpensAtLogin(true)
        }
    }
}
