//
//  SettingsView.swift
//  JsonZen
//
//  Created by winddpan on 8/2/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var settings = AppSettings.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("设置")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 15) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("高亮主题")
                        .font(.headline)
                    
                    Picker("高亮主题", selection: $settings.highlightTheme) {
                        ForEach(HighlightThemeType.allCases, id: \.self) { theme in
                            Text(theme.displayName).tag(theme)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("编辑器选项")
                        .font(.headline)
                    
                    Toggle("显示行号", isOn: $settings.showLineNumbers)
                    
                    Toggle("自动格式化", isOn: $settings.autoFormat)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("文件关联")
                        .font(.headline)
                    
                    Toggle("关联 .json 文件", isOn: $settings.associateJsonFiles)
                    
                    if settings.associateJsonFiles {
                        Text("重启应用后生效")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button("完成") {
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(20)
        .frame(width: 400, height: 350)
    }
}

struct SettingsWindow: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> NSViewController {
        let hostingController = NSHostingController(rootView: SettingsView())
        return hostingController
    }
    
    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {}
}

#Preview {
    SettingsView()
}