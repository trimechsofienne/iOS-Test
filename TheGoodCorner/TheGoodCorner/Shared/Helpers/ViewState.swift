//
//  ViewState.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Generic state machine for any screen that loads data.
///
/// Used by ViewModels to express their current state in a type-safe way,
/// avoiding scattered boolean flags (`isLoading`, `hasError`, etc.).
enum ViewState<T: Equatable>: Equatable {
    /// Initial state before any load has been triggered.
    case idle
    /// A load is in progress.
    case loading
    /// Data has been successfully loaded.
    case loaded(T)
    /// An error occurred. The message is user-facing.
    case error(String)
}
