/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view controller that manages a map and the user's activity within it, creating and receiving NSUserActivity objects for Handoff.
*/

import AppKit
import SwiftUI
import Combine

class RootViewController: NSViewController, ObservableObject {
    
    private lazy var editingActivity: NSUserActivity = {
        let activity = NSUserActivity.initEditingActivity()
        activity.delegate = self
        return activity
    }()
    
    @Published var text = "Type here..."
    @Published var enc = ""
    private var anyCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Publishers.CombineLatest($text, $enc)
            .sink { [weak self] (a, b) in
                guard let self = self,
                      let activity = self.userActivity else { return }
                
                let encoder = SuperSecureEncryptionMechanism()
                let enc = encoder.encrypt(b == "" ? a : b, activity)
                activity.updateEditingActivity(a, enc)
            }.store(in: &anyCancellable)
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        editingActivity.needsSave = true
        editingActivity.isEligibleForHandoff = true
        editingActivity.becomeCurrent()
        userActivity = editingActivity
        
        // Add SwiftUI View to RootViewController
        let controller = NSHostingController(rootView: ContentView(viewController: self))
        
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            controller.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Handoff support
    override func updateUserActivityState(_ activity: NSUserActivity) {
        
        let encoder = SuperSecureEncryptionMechanism()
        let enc = encoder.encrypt(text, activity)
        
        activity.updateEditingActivity(text, enc)
    }
    
    override func restoreUserActivityState(_ userActivity: NSUserActivity) {
        super.restoreUserActivityState(userActivity)
        
        switch userActivity.activityType {
            case NSUserActivity.editingActivityType:
                guard let userInfo = userActivity.getUserInfo() else {
                    return
                }
                
                text = userInfo.text
                enc = userInfo.enc
                
            default:
                break
        }
    }
    
}

// MARK: - NSUserActivityDelegate
extension RootViewController: NSUserActivityDelegate {
    
    func userActivityWasContinued(_ userActivity: NSUserActivity) {
        DispatchQueue.main.async {
            self.enc = "Continued on another device..."
        }
    }
}
