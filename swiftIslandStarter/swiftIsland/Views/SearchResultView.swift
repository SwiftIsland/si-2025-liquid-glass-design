import SwiftUI

struct SearchResultsView: View {
    let query: String
    @StateObject private var fetcher = WWDCDataFetcher()
    @Namespace private var namespace
    
    private var results: [WWDCItem] {
        self.query.isEmpty ? [] : self.fetcher.searchItems(query: self.query)
    }
    
    var body: some View {
        ScrollView {
            if self.query.isEmpty {
                ContentUnavailableView("Search WWDC",
                                       systemImage: "magnifyingglass",
                                       description: Text("Type to find announcements"))
                .padding(.top, 24)
            } else if results.isEmpty {
                ContentUnavailableView("No Results",
                                       systemImage: "magnifyingglass",
                                       description: Text("Try a different term"))
                .padding(.top, 24)
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(results) { item in
                        WWDCItemCard(item: item, namespace: self.namespace)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}
