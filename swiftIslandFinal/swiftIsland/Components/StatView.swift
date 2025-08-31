import SwiftUI

struct StatView: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            // Decorative icon
                .accessibilityHidden(true)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)")
    }
}
