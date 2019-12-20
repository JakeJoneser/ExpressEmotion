import Foundation
let FIRST_LAUNCH_KEY: String = "firstLaunch"
extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let firstLaunch = UserDefaults.standard.object(forKey: FIRST_LAUNCH_KEY)
        if firstLaunch == nil {
            return true
        }
        return firstLaunch as! Bool
    }
    static func setFirstLaunch(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: FIRST_LAUNCH_KEY)
    }
}
