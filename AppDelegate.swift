import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var LoginOrientations: NSInteger = 0
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
        let entity = JPUSHRegisterEntity()
                         entity.types = 1 << 0 | 1 << 1 | 1 << 2
                         JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
                         JPUSHService.setup(withOption: launchOptions, appKey: "b61961a5cff7613902b9d079", channel: "expressemotion", apsForProduction: false, advertisingIdentifier: nil)
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
               JPUSHService.setBadge(0)
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExpressEmotion")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
              if(LoginOrientations == 1)
              {
                  return  UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue|UIInterfaceOrientationMask.landscapeLeft.rawValue|UIInterfaceOrientationMask.landscapeRight.rawValue)
              }
              else
              {
                  return  UIInterfaceOrientationMask.portrait
              }
          }
}
extension AppDelegate : JPUSHRegisterDelegate {
       @available(iOS 10.0, *)
       func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
           
           let userInfo = notification.request.content.userInfo
           if notification.request.trigger is UNPushNotificationTrigger {
               JPUSHService.handleRemoteNotification(userInfo)
           }
           completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
       }
       
       @available(iOS 10.0, *)
       func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
           let userInfo = response.notification.request.content.userInfo
           if response.notification.request.trigger is UNPushNotificationTrigger {
               JPUSHService.handleRemoteNotification(userInfo)
           }
           completionHandler()
       }
       
       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           JPUSHService.handleRemoteNotification(userInfo)
           completionHandler(UIBackgroundFetchResult.newData)
           
       }
       func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           JPUSHService.registerDeviceToken(deviceToken)
       }
       func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
           print("did Fail To Register For Remote Notifications With Error: \(error)")
       }
   }

