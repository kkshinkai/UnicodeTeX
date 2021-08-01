import Carbon

class Install {
    static let installLocation = "/Library/Input Methods/UnicodeTeX.app"
    static let kSourceID = "moe.kkshinkai.inputmethod.UnicodeTeX"
    static let kInputModeID = "moe.kkshinkai.inputmethod.UnicodeTeX"
    
    static func register() {
        if let location =
            CFURLCreateFromFileSystemRepresentation(
                nil, installLocation, installLocation.count, false) {
            TISRegisterInputSource(location)
        }
        
    }
    
    private static func find() -> (TISInputSource, NSString)? {
        let sourceList = TISCreateInputSourceList(nil, true)
            .takeUnretainedValue()
        
        for index in 0..<CFArrayGetCount(sourceList) {
            let inputSource = Unmanaged<TISInputSource>
                .fromOpaque(CFArrayGetValueAtIndex(sourceList, index))
                .takeUnretainedValue()
            if let result = transformTargetSource(inputSource) {
                return result
            }
        }
        return nil
    }
    
    private static func transformTargetSource(_ inputSource: TISInputSource)
        -> (TISInputSource, NSString)? {
        let ptr = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID)
        let sourceID = Unmanaged<CFString>
            .fromOpaque(ptr!)
            .takeUnretainedValue() as NSString
        if (sourceID.isEqual(to: kSourceID)) || sourceID.isEqual(to: kInputModeID) {
            return (inputSource, sourceID)
        }
        return nil
    }
    
    static func enable() {
        guard let (inputSource, _sourceID) = find() else {
            return
        }
        TISEnableInputSource(inputSource)
        
        let isSelectable = Unmanaged<CFBoolean>.fromOpaque(
            TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsSelectCapable)
        ).takeUnretainedValue()
        if CFBooleanGetValue(isSelectable) {
            TISSelectInputSource(inputSource)
        }
        
    }
}
