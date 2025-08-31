import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("enableHaptics") private var enableHaptics = true
    @AppStorage("autoRefresh") private var autoRefresh = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 48))
                                .foregroundColor(.blue)
                            // Decorative icon
                                .accessibilityHidden(true)
                            Text("WWDC Instructor")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .accessibilityAddTraits(.isHeader)
                            
                            Text("Teaching iOS Features")
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            HStack(spacing: 20) {
                                StatView(title: "Features", value: "25+", icon: "sparkles")
                                StatView(title: "Sessions", value: "10", icon: "video")
                                StatView(title: "Students", value: "500+", icon: "person.3")
                            }
                        }
                        .padding()
                        .background(
                            ConcentricRectangle(corners: .concentric(minimum: 16), isUniform: true)
                                .fill(.regularMaterial)
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Profile section")
                        .accessibilityHint("Your instructor profile and statistics")
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Settings")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .accessibilityAddTraits(.isHeader)
                            
                            VStack(spacing: 12) {
                                SettingRow(icon: "moon.fill", title: "Dark Mode", subtitle: "Use dark appearance") {
                                    Toggle("", isOn: $isDarkMode)
                                        .accessibilityLabel("Dark mode")
                                        .accessibilityHint("Switch between light and dark appearance")
                                }
                                
                                SettingRow(icon: "hand.tap.fill", title: "Haptic Feedback", subtitle: "Enable vibration feedback") {
                                    Toggle("", isOn: $enableHaptics)
                                        .accessibilityLabel("Haptic feedback")
                                        .accessibilityHint("Enable or disable vibration feedback")
                                }
                                
                                SettingRow(icon: "arrow.clockwise", title: "Auto Refresh", subtitle: "Automatically refresh content") {
                                    Toggle("", isOn: $autoRefresh)
                                        .accessibilityLabel("Auto refresh")
                                        .accessibilityHint("Automatically refresh WWDC announcements")
                                }
                                
                                SettingRow(icon: "bell.fill", title: "Notifications", subtitle: "Receive push notifications") {
                                    Toggle("", isOn: $notificationsEnabled)
                                        .accessibilityLabel("Notifications")
                                        .accessibilityHint("Enable or disable push notifications")
                                }
                            }
                        }
                        .padding()
                        .background(
                            ConcentricRectangle(corners: .concentric(minimum: 16), isUniform: true)
                                .fill(.regularMaterial)
                        )
                        .accessibilityElement(children: .contain)
                        .accessibilityLabel("Settings section")
                        .accessibilityHint("Configure app preferences and behavior")
                        
                        
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("About")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .accessibilityAddTraits(.isHeader)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("SwiftIsland WWDC 2025")
                                    .font(.headline)
                                    .accessibilityAddTraits(.isHeader)
                                
                                Text("Version 1.0.0")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .accessibilityLabel("App version")
                                
                                Text("Teaching iOS features with liquid glass design system")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .accessibilityLabel("App description")
                            }
                        }
                        .padding()
                        .background(
                            ConcentricRectangle(corners: .concentric(minimum: 16), isUniform: true)
                                .fill(.regularMaterial)
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("About section")
                        .accessibilityHint("App information and version details")
                    }
                    .padding()
                }
                .accessibilityLabel("Settings scroll view")
                .accessibilityHint("Scroll to view all settings and preferences")
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Settings")
        .accessibilityHint("Configure app settings and view profile information")
    }
}
