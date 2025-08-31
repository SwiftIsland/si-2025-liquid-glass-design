import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let namespace: Namespace.ID
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            // Decorative icon
                .accessibilityHidden(true)
            
            TextField("Search WWDC announcements...", text: $text)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .accessibilityLabel("Search WWDC announcements")
                .accessibilityHint("Enter keywords to find specific WWDC features")
                .accessibilityValue(text.isEmpty ? "No search text" : "Searching for: \(text)")
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .accessibilityLabel("Clear search")
                .accessibilityHint("Removes all search text")
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding()
        .background(
            ConcentricRectangle(corners: .concentric(minimum: 12), isUniform: true)
                .fill(.ultraThinMaterial)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Search bar")
        .accessibilityHint("Search through WWDC 2025 announcements and features")
        .animation(.smooth(duration: 0.2), value: isFocused)
    }
}
