import CoreGraphics

struct Mouse {
    static func currentPosition() -> CGPoint {
        return CGEventGetLocation(CGEventCreate(nil))
    }
}
