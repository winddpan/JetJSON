//
//  JSONFooterView.swift
//  JetJSON
//
//  Created by winddpan on 8/2/25.
//

import SwiftUI

struct JSONFooterView: View {
    let statistics: JSONStatistics

    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            FooterItem(label: "节点", value: "\(statistics.nodeCount)")
            Divider()
            FooterItem(label: "字符", value: "\(statistics.characterCount)")
            Divider()
            FooterItem(label: "大小", value: statistics.fileSize)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(NSColor.controlBackgroundColor))
        .frame(height: 24)
    }
}

struct FooterItem: View {
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    JSONFooterView(statistics: JSONStatistics(from: testJSON))
}
