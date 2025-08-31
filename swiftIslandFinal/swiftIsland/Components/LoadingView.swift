import SwiftUI

struct LoadingView: View {
    let namespace: Namespace.ID
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                }
                
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(24)
            .background(
                ConcentricRectangle(corners: .concentric(minimum: 16), isUniform: true)
                    .fill(.ultraThinMaterial)
            )
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Loading overlay")
        .accessibilityHint("Content is being loaded")
        .accessibilityValue("Loading in progress")
        .onAppear {
            isAnimating = true
        }
        .onDisappear {
            isAnimating = false
        }
    }
}
