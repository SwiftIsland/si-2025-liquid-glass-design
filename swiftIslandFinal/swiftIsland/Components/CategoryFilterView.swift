import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategory: WWDCItem.WWDCCategory?
    let namespace: Namespace.ID
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(WWDCItem.WWDCCategory.allCases, id: \.self) { category in
                    CategoryButton(
                        title: category.rawValue,
                        isSelected: self.selectedCategory == category,
                        color: category.color,
                        namespace: namespace
                    ) {
                        withAnimation(.smooth(duration: 0.1)) {
                            self.selectedCategory = selectedCategory == category ? nil : category
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Category filter")
        .accessibilityHint("Filter WWDC announcements by category")
        .accessibilityValue(selectedCategory?.rawValue ?? "All categories")
    }
}
