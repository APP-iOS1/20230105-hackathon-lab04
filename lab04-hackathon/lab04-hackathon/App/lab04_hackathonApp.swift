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
    @StateObject var userViewModel = UserStore()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthenticatedView {
                    
                    //
                } content: {
                    ContentView()
                        .environmentObject(feedViewModel)
                        .environmentObject(authViewModel)
                        .environmentObject(userViewModel)
                        
                }
                .environmentObject(authViewModel)
                .environmentObject(userViewModel)
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
}
