import AppKit
import Foundation

final class Mover {
    var state: FlagState = .Ignore {
        didSet {
            if self.state != oldValue {
                self.changedState(self.state)
            }
        }
    }

    private var monitor: AnyObject?
    private var lastMousePosition: CGPoint?
    private var window: AccessibilityElement?

    private func mouseMoved(handler: (window: AccessibilityElement, mouseDelta: CGPoint) -> Void) {
        let point = Mouse.currentPosition()
        if self.window == nil {
            self.window = AccessibilityElement.systemWideElement.elementAtPoint(point)?.window()
        }

        guard let window = self.window else {
            return
        }

        let currentPid = NSRunningApplication.currentApplication().processIdentifier
        if let pid = window.pid() where pid != currentPid {
            NSRunningApplication(processIdentifier: pid)?.activateWithOptions(.ActivateIgnoringOtherApps)
        }

        window.bringToFront()
        if let lastPosition = self.lastMousePosition {
            let mouseDelta = CGPoint(x: lastPosition.x - point.x, y: lastPosition.y - point.y)
            handler(window: window, mouseDelta: mouseDelta)
        }

        self.lastMousePosition = point
    }

    private func resizeWindow(window: AccessibilityElement, mouseDelta: CGPoint) {
        if let size = window.size {
            let newSize = CGSize(width: size.width - mouseDelta.x, height: size.height - mouseDelta.y)
            window.size = newSize
        }
    }

    private func moveWindow(window: AccessibilityElement, mouseDelta: CGPoint) {
        if let position = window.position {
            let newPosition = CGPoint(x: position.x - mouseDelta.x, y: position.y - mouseDelta.y)
            window.position = newPosition
        }
    }

    private func changedState(state: FlagState) {
        self.removeMonitor()

        switch state {
        case .Resize:
            self.monitor = NSEvent.addGlobalMonitorForEventsMatchingMask(.MouseMovedMask) { _ in
                self.mouseMoved(self.resizeWindow)
            }
        case .Drag:
            self.monitor = NSEvent.addGlobalMonitorForEventsMatchingMask(.MouseMovedMask) { _ in
                self.mouseMoved(self.moveWindow)
            }
        case .Ignore:
            self.lastMousePosition = nil
            self.window = nil
        }
    }

    private func removeMonitor() {
        if let monitor = self.monitor {
            NSEvent.removeMonitor(monitor)
        }
        self.monitor = nil
    }

    deinit {
        self.removeMonitor()
    }
}
