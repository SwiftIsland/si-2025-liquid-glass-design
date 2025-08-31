import SwiftUI

struct HomeView: View {
    @StateObject private var fetcher = WWDCDataFetcher()
    @State private var searchText = ""
    @State private var selectedCategory: WWDCItem.WWDCCategory?
    @Namespace private var namespace
    
    private var filteredItems: [WWDCItem] {
        var items = self.fetcher.items
        
        if !searchText.isEmpty {
            items = self.fetcher.searchItems(query: searchText)
        }
        
        if let selectedCategory = selectedCategory, selectedCategory != .all {
            items = self.fetcher.items(for: selectedCategory)
        }
        
        return items
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                        // Decorative icon
                        .accessibilityHidden(true)
                    
                    Text("Welcome to WWDC 2025")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("Discover the latest iOS features")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Welcome to WWDC 2025")
                .accessibilityHint("Discover the latest iOS features and announcements")
                
                SearchBar(text: $searchText, namespace: namespace)
                CategoryFilterView(selectedCategory: $selectedCategory, namespace: namespace)
                LazyVStack(spacing: 16) {
                    ForEach(filteredItems) { item in
                        WWDCItemCard(item: item, namespace: namespace)
                            .transition(.asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .scale.combined(with: .opacity)
                            ))
                    }
                }
                .animation(.smooth(duration: 0.6), value: filteredItems)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("WWDC announcements list")
                .accessibilityHint("List of WWDC 2025 announcements and features")
                .accessibilityValue("\(filteredItems.count) announcements")
            }
            .padding()
        }
        .refreshable {
            self.fetcher.load()
        }
        .accessibilityLabel("WWDC announcements scroll view")
        .accessibilityHint("Scroll to view all WWDC 2025 announcements")
        .overlay {
            if self.fetcher.isLoading {
                LoadingView(namespace: namespace)
            }
        }
        .navigationTitle("WWDC 2025")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Refresh") {
                    self.fetcher.load()
                }
                .font(.system(.body, design: .default))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(minWidth: 60, minHeight: 32)
                .accessibilityLabel("Refresh announcements")
                .accessibilityHint("Reload WWDC announcements from server")
            }
        }
    
        .alert("Error", isPresented: .constant(self.fetcher.errorMessage != nil)) {
            Button("OK") {
                self.fetcher.clearError()
            }
            .accessibilityLabel("Dismiss error")
        } message: {
            if let errorMessage = self.fetcher.errorMessage {
                Text(errorMessage)
                    .accessibilityLabel("Error message")
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("WWDC 2025 Home")
        .accessibilityHint("Main screen showing WWDC 2025 announcements and features")
    }
    
}
