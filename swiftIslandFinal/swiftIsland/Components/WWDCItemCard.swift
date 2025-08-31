import SwiftUI

struct WWDCItemCard: View {
    let item: WWDCItem
    let namespace: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: item.iconName)
                    .font(.title2)
                    .foregroundColor(item.category.color)
                    // Decorative icon
                    .accessibilityHidden(true)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        
                        if item.isNew {
                            Text("NEW")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(
                                    ConcentricRectangle(corners: .concentric(minimum: 4), isUniform: true)
                                        .fill(.red)
                                )
                                .accessibilityLabel("New announcement")
                        }
                    }
                    
                    Text(item.category.rawValue)
                        .font(.caption)
                        .foregroundColor(item.category.color)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            ConcentricRectangle(corners: .concentric(minimum: 4), isUniform: true)
                                .fill(item.category.color.opacity(0.1))
                                .glassEffect()
                        )
                }
                
                Spacer()
            }
            
            Text(item.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            ConcentricRectangle(corners: .concentric(minimum: 16), isUniform: true)
                .fill(Color(.tertiarySystemBackground))
        )
        .containerShape(.rect(cornerRadius: 16))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(item.title) - \(item.category.rawValue)")
        .accessibilityHint(item.description)
        .accessibilityValue(item.isNew ? "New announcement" : "Existing announcement")
    }
}
