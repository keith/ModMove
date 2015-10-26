import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(aNotification: NSNotification) {
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
