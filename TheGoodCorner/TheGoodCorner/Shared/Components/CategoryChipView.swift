//
//  CategoryChipView.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Selectable category chip used in the horizontal filter bar.
///
/// Accessibility: announces the category name and marks itself
/// as selected when active, enabling VoiceOver navigation.
struct CategoryChipView: View {

    // MARK: - Properties

    let title: String
    let isSelected: Bool
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isSelected ? Typography.chipSelected : Typography.chip)
                .padding(.horizontal, Spacing.chipHorizontalPadding)
                .padding(.vertical, Spacing.chipVerticalPadding)
                .background(isSelected ? Theme.chipSelectedBackground : Theme.chipDefaultBackground)
                .foregroundStyle(isSelected ? Theme.chipSelectedForeground : Theme.chipDefaultForeground)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(isSelected ? Color.clear : Theme.chipBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}
