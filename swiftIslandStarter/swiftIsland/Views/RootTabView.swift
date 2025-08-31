import SwiftUI

enum MainTab: Hashable {
    case home, settings, search
}

struct RootTabView: View {
    @State private var selection: MainTab = .home
    @State private var searchText = ""
    
    var body: some View {
        TabView(selection: $selection) {
            Tab(value: .home) {
                NavigationStack {
                    HomeView()
                }
            } label: {
                Label("Home", systemImage: "house.fill")
            }
            
            Tab(value: .settings) {
                NavigationStack {
                    SettingsView()
                }
            } label: {
                Label("Settings", systemImage: "gear")
            }
            
            Tab(value: .search) {
                NavigationStack {
                    SearchResultsView(query: searchText)
                }
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
        
    }
}
