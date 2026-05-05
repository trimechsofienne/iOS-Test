//
//  Typography.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Semantic typography styles.
///
/// All views must use `Typography.xxx` instead of inline `.font(...)` calls.
/// Every style uses system fonts to ensure Dynamic Type compliance.
enum Typography {
    static let screenTitle = Font.title2.bold()
    static let sectionTitle = Font.headline
    static let price = Font.title3.bold()
    static let rowTitle = Font.subheadline.weight(.medium)
    static let rowCategory = Font.caption
    static let body = Font.body
    static let chip = Font.subheadline
    static let chipSelected = Font.subheadline.weight(.semibold)
    static let badge = Font.caption2.bold()
}
