import SwiftUI
import Combine

struct WWDCItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    let category: WWDCCategory
    let isNew: Bool
    let iconName: String
    let releaseDate: Date
    
    enum WWDCCategory: String, CaseIterable, Codable {
        case all = "All"
        case swiftUI = "SwiftUI"
        case swift = "Swift"
        case visionOS = "visionOS"
        case frameworks = "Frameworks"
        
        var color: Color {
            switch self {
            case .all: return .blue
            case .swiftUI: return .blue
            case .swift: return .orange
            case .visionOS: return .indigo
            case .frameworks: return .pink
            }
        }
    }
    
    static func == (lhs: WWDCItem, rhs: WWDCItem) -> Bool {
        lhs.id == rhs.id
    }
}

@MainActor
class WWDCDataFetcher: ObservableObject {
    @Published private(set) var items: [WWDCItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    private var loadTask: Task<Void, Never>?
    
    init() {
        self.load()
    }
    
    deinit {
        self.loadTask?.cancel()
    }
    
    func load() {
        self.loadTask?.cancel()
        self.loadTask = Task {
            await performLoad()
        }
    }
    
    func clearError() {
        self.errorMessage = nil
    }
    
    private func performLoad() async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            try await Task.sleep(for: .seconds(1.0))
            
            let newItems = [
                WWDCItem(
                    title: "Liquid Glass Design System",
                    description: "Introducing the revolutionary liquid glass design system that brings fluid, organic interfaces.",
                    category: .swiftUI,
                    isNew: true,
                    iconName: "drop.fill",
                    releaseDate: Date()
                ),
                WWDCItem(
                    title: "Enhanced SwiftUI Animations",
                    description: "New animation APIs for creating stunning visual effects with minimal code.",
                    category: .swiftUI,
                    isNew: true,
                    iconName: "sparkles",
                    releaseDate: Date()
                ),
                WWDCItem(
                    title: "Vision Pro Integration",
                    description: "Seamless integration between iOS and visionOS with shared data models.",
                    category: .visionOS,
                    isNew: true,
                    iconName: "visionpro",
                    releaseDate: Date()
                ),
                WWDCItem(
                    title: "Advanced Swift Concurrency",
                    description: "Enhanced async/await patterns and improved actor isolation.",
                    category: .swift,
                    isNew: false,
                    iconName: "bolt.fill",
                    releaseDate: Date().addingTimeInterval(-86400)
                ),
                WWDCItem(
                    title: "Privacy-First APIs",
                    description: "New privacy-focused frameworks that give users more control over their data.",
                    category: .frameworks,
                    isNew: true,
                    iconName: "lock.shield",
                    releaseDate: Date()
                )
            ]
            
            withAnimation(.smooth(duration: 0.8)) {
                self.items = newItems
            }
            
        } catch {
            self.errorMessage = "Failed to load data: \(error.localizedDescription)"
        }
        self.isLoading = false
    }
    
    func items(for category: WWDCItem.WWDCCategory?) -> [WWDCItem] {
        guard let category = category else {
            return items
        }
        if category == .all {
            return items
        }
        return items.filter {
            $0.category == category
        }
    }
    
    func searchItems(query: String) -> [WWDCItem] {
        guard !query.isEmpty else {
            return items
        }
        return items.filter { item in
            item.title.localizedCaseInsensitiveContains(query) ||
            item.description.localizedCaseInsensitiveContains(query)
        }
    }
}
