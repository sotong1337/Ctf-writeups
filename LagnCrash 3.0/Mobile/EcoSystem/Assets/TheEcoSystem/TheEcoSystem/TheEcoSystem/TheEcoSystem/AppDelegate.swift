/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An AppDelegate implementation that receives the NSUserActivity for Handoff.
*/

import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // When Handoff launches the app, get the window's content view controller and pass it to
    // the resorationHandler. This results in the view controller receiving the activity in restoreUserActivityState(_:).
    func application(_ application: NSApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        
        guard let rootVC = application.keyWindow?.windowController?.contentViewController as? RootViewController else {
            return false
        }
        
        rootVC.loadView()
        restorationHandler([rootVC])
        return true
    }
}
