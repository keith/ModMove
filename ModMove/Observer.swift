import AppKit
import Foundation

enum FlagState {
    case Resize
    case Drag
    case Ignore
}

final class Observer {
    private var monitor: Any?

    func startObserving(state: @escaping (FlagState) -> Void) {
        self.monitor = NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { event in
            state(self.state(for: event.modifierFlags))
        }
    }

    private func state(for flags: NSEvent.ModifierFlags) -> FlagState {
        let hasMain = flags.contains(.control) && flags.contains(.option)
        let hasShift = flags.contains(.shift)

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
