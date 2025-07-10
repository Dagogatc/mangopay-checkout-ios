//
//  File.swift
//  
//
//  Created by Elikem Savie on 04/10/2023.
//

import Foundation

public enum _3DSTransactionType: String, Codable, CaseIterable {
    case cardDirect = "CARD_DIRECT"
    case preauthorized = "PREAUTHORIZED"
    case cardValidated = "CARD_VALIDATION"
    case depositPreAuth = "DEPOSIT_PREAUTH"
    case recurring

    public var id: String {
        switch self {
        case .cardDirect:
            return "transactionId"
        case .preauthorized:
            return "preAuthorizationId"
        case .cardValidated:
            return "cardValidationId"
        case .depositPreAuth:
            return "depositId"
        case .recurring:
            return "recurringId"
        }
    }
}

public enum _3DSStatus: String, Codable {
    case SUCCEEDED
    case FAILED
    case CANCELLED
}

public struct _3DSResult: Codable {
    public let type: _3DSTransactionType
    public let status: _3DSStatus
    public let id: String

}
