import AppKit
import Foundation

enum FlagState {
    case Resize
    case Drag
    case Ignore
}

final class Observer {
    private var monitor: AnyObject?

    func startObserving(state: FlagState -> Void) {
        self.monitor = NSEvent.addGlobalMonitorForEventsMatchingMask(.FlagsChangedMask) { event in
            state(self.stateForFlags(event.modifierFlags))
        }
    }

    private func stateForFlags(flags: NSEventModifierFlags) -> FlagState {
        let hasMain = flags.contains(.ControlKeyMask) && flags.contains(.AlternateKeyMask)
        let hasShift = flags.contains(.ShiftKeyMask)

        if hasMain && hasShift {
            return .Resize
        } else if hasMain {
            return .Drag
        } else {
            return .Ignore
        }
    }

    deinit {
        if let monitor = self.monitor {
            NSEvent.removeMonitor(monitor)
        }
    }
}
