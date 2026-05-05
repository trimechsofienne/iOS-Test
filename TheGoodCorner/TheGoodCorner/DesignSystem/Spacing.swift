//
//  Spacing.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Centralized spacing and sizing constants.
///
/// Eliminates magic numbers throughout the codebase.
/// All layout values must reference this enum.
enum Spacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 8
    static let m: CGFloat = 12
    static let l: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24

    // MARK: - Component-specific

    static let rowImageSize: CGFloat = 80
    static let rowCornerRadius: CGFloat = 8
    static let chipHorizontalPadding: CGFloat = 14
    static let chipVerticalPadding: CGFloat = 7
    static let detailHeaderImageHeight: CGFloat = 250
}
