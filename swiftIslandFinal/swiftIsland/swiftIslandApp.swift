import SwiftUI

@main
struct swiftIslandApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .preferredColorScheme(.none)
                .animation(.smooth, value: true)
        }
        .windowResizability(.contentSize)
    }
}
