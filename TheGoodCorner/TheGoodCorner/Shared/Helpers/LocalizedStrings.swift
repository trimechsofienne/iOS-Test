//
//  LocalizedStrings.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Type-safe localization keys.
///
/// Centralizes all user-facing strings. Using `String(localized:)`
/// provides compile-time safety and enables future localization
/// without modifying view code.
enum L10n {

    // MARK: - Navigation

    static let listingsTitle = String(localized: "Annonces")

    // MARK: - Categories

    static let allCategories = String(localized: "Toutes")
    static let unknownCategory = String(localized: "Autre")

    // MARK: - Listing

    static let urgent = String(localized: "URGENT")
    static let searchPlaceholder = String(localized: "Rechercher une annonce")

    // MARK: - States

    static let loading = String(localized: "Chargement…")
    static let errorTitle = String(localized: "Une erreur est survenue")
    static let retry = String(localized: "Réessayer")
    static let emptyCategory = String(localized: "Aucune annonce dans cette catégorie.")
    static let emptyResults = String(localized: "Aucun résultat")
    static let descriptionTitle = String(localized: "Description")

    // MARK: - Accessibility

    static let accessibilityUrgent = String(localized: "Annonce urgente")
    static let accessibilityLoading = String(localized: "Chargement des annonces en cours")
    static let accessibilityRetry = String(localized: "Réessayer le chargement")
    static let accessibilityPhotoAvailable = String(localized: "Photo de l'annonce")
    static let accessibilityPhotoUnavailable = String(localized: "Aucune photo disponible")
}
