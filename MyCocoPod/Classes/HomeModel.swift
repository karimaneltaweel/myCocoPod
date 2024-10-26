//
//  HomeModel.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import Foundation
// MARK: - Home
struct Home: Codable {
    var data: [Datum]?
    let status: Bool?
}

// MARK: - Datum
struct Datum: Codable {
    var id: Int?
    var type:InstallmentLoockUpTypeEnum?
    var serviceTypeImgURL: String?
    var serivceTypesCategories: [SerivceTypesCategory]?

    enum CodingKeys: String, CodingKey {
        case id, type
        case serviceTypeImgURL = "serviceTypeImgUrl"
        case serivceTypesCategories
    }
}

// MARK: - SerivceTypesCategory
struct SerivceTypesCategory: Codable {
    var id: Int?
    var name, sdkImgURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sdkImgURL = "sdkImgUrl"
    }
}

struct SubCategoriesItems: Codable {
    let id: String
    let name, providerName, imageUrl: String?
    let rate: Double
    let startFrom: Int
    let maxMonth: Int
    let isFavourite: Bool
}

/// MARK: - TopProvider
struct TopProvider: Codable {
    var data: [TopProviderDatum]?
    var status: Bool?
}

// MARK: - Datum
struct TopProviderDatum: Codable {
    var id, name, imageURL: String?
    var type: ProviderTypeEnum?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case type
    }
}

