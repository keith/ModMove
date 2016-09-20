import CoreGraphics

struct Mouse {
    static func currentPosition() -> CGPoint {
        return CGEvent(source: nil)!.location
    }
}
