//
//  File 2.swift
//  
//
//  Created by Elikem Savie on 07/06/2023.
//

import Foundation
import MangopayVaultSDK

public typealias MangopayTokenizedCallBack = ((TokenizedCardData?, MGPError?) -> ())


public struct TokenizedCardData: Codable {
    public var card: CardRegistration

    public init(card: CardRegistration) {
        self.card = card
    }

    public var str: String {
        guard let id = card.cardID else { return "" }
        return "Tokenised Card: \(id)"
    }
}
