import SwiftUI
import Firebase
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct lab04_hackathonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var feedViewModel = FeedStore()
    @StateObject var authViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView {
                
                //
            } content: {
                ContentView()
                    .environmentObject(feedViewModel)
                    .environmentObject(authViewModel)
            }
            .environmentObject(authViewModel)
            .onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
            .onAppear {
                GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                    // Check if `user` exists; otherwise, do something with `error`
                }
            }
            
        }
    }
}
