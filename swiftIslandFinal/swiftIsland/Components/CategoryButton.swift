import SwiftUI

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let namespace: Namespace.ID
    let action: () -> Void
    
    init(title: String, isSelected: Bool, color: Color = .primary, namespace: Namespace.ID, action: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.color = color
        self.namespace = namespace
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(self.isSelected ? .white : self.color)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    ConcentricRectangle(corners: .concentric(minimum: 8), isUniform: true)
                        .fill(self.isSelected ? self.color : Color.clear)
                        .opacity(self.isSelected ? 0.8 : 0)
                )
        }
        .buttonStyle(.glass)
        .accessibilityLabel("\(self.title) category")
        .accessibilityHint("Filter by \(self.title) announcements")
        .accessibilityValue(self.isSelected ? "Selected" : "Not selected")
        .accessibilityAddTraits(self.isSelected ? .isSelected : [])
    }
}
