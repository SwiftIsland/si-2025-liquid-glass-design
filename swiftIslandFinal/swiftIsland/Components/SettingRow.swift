import SwiftUI

struct SettingRow<Content: View>: View {
    let icon: String
    let title: String
    let subtitle: String
    let content: Content
    
    init(icon: String, title: String, subtitle: String, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 24)
                // Decorative icon
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .accessibilityAddTraits(.isHeader)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            content
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(subtitle)")
    }
}

