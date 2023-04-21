/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An extension on NSUserActivity to declare userInfo keys and add convenience functions
 to encode and decode map regions and AppleStore metadata in the userInfo dictionary.
*/

import Foundation

struct UserInfo {
    let text: String;
    let enc: String;
    let sentby: String;
}

extension NSUserActivity {
    
    // MARK: - Activity types
    public static let editingActivityType = "is.carlvoller.typing"

    // MARK: - Note Editing activity
    // MARK: keys
    private static let editingActivityRequiredKeys: Set<String> = [
        "text", "setby", "enc"
    ]
    
    // MARK: methods
    static func initEditingActivity() -> NSUserActivity {
        let activity = NSUserActivity(activityType: editingActivityType)
        activity.title = NSLocalizedString("Editing Note", comment: "Editing Note")
        activity.requiredUserInfoKeys = editingActivityRequiredKeys
        activity.isEligibleForHandoff = true
        return activity
    }
    
    func updateEditingActivity(_ text: String, _ enc: String?) {
        let updateDict = [
            "text": text,
            "setby": Bundle.main.bundleIdentifier ?? "",
            "enc": enc ?? ""
        ]
        addUserInfoEntries(from: updateDict)
    }
    
    func getUserInfo() -> UserInfo? {
        guard let text = userInfo?["text"] as? String,
              let enc = userInfo?["enc"] as? String,
              let sentby = userInfo?["setby"] as? String else {
                  return nil
              }
        
        return UserInfo(text: text, enc: enc, sentby: sentby)
    }
}
