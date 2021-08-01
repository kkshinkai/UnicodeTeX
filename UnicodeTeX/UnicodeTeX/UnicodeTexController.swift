import Foundation
import InputMethodKit

class UnicodeTexController: IMKInputController {
    
    override class func handle(_ event: NSEvent!, client sender: Any!) -> Bool {
        NSLog("[TexUnicodeController] handle: \(event.debugDescription)")
        return true
    }
    
    override func selectionRange() -> NSRange {
        return NSRange(location: 0, length: 2)
    }
    
}
