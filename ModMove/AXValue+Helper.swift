import Foundation

extension AXValue {
    func toValue<T>() -> T? {
        let pointer = UnsafeMutablePointer<T>.alloc(1)
        let success = AXValueGetValue(self, AXValueGetType(self), pointer)
        return success ? pointer.memory : nil
    }

    static func fromValue<T>(value: T, type: AXValueType) -> AXValue? {
        let pointer = UnsafeMutablePointer<T>.alloc(1)
        pointer.memory = value
        return AXValueCreate(type, pointer)?.takeUnretainedValue()
    }
}
