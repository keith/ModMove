import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        AccessibilityHelper.askForAccessibilityIfNeeded()

        if !LoginController.opensAtLogin() {
            LoginAlert.showAlertIfNeeded()
        }

        let mover = Mover()
        Observer().startObserving { state in
            mover.state = state
        }
    }
}
