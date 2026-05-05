//
//  AsyncCachedImage.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Async image loader with graceful handling of nil, loading, failure, and success states.
///
/// Handles the API's `poisoned-image.jpg` pattern (images that return 404)
/// by displaying a consistent placeholder on failure.
struct AsyncCachedImage: View {

    // MARK: - Properties

    let url: URL?
    var size: CGFloat = Spacing.rowImageSize
    var cornerRadius: CGFloat = Spacing.rowCornerRadius

    // MARK: - Body

    var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                        .overlay { ProgressView() }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .accessibilityHidden(true)
        } else {
            placeholder
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .accessibilityHidden(true)
        }
    }

    // MARK: - Subviews

    private var placeholder: some View {
        Rectangle()
            .fill(Theme.placeholderBackground)
            .overlay {
                Image(systemName: Icon.photoPlaceholder)
                    .font(.title2)
                    .foregroundStyle(Theme.placeholderIcon)
            }
    }
}
