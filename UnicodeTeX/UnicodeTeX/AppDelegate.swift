import Cocoa
import InputMethodKit

let kConnectionName = "TexUnicode_1_Connection"
var server = IMKServer()
var candidatesWindow = IMKCandidates()

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        server = IMKServer(name: kConnectionName,
                               bundleIdentifier: Bundle.main.bundleIdentifier)
        candidatesWindow = IMKCandidates(
            server: server, panelType: kIMKSingleColumnScrollingCandidatePanel)
    }

    func applicationWillTerminate(_ aNotification: Notification) {}

}

