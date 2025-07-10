//
//  File.swift
//  
//
//  Created by Elikem Savie on 31/07/2023.
//

import Foundation
import MangopayVaultSDK

struct Tokenizer {
    
    private static var clientId: String!
    private static var environment: MGPEnvironment!
    private static var checkoutRerefence: String!

    public static func initialize(
        clientId: String,
        checkoutRerefence: String,
        environment: MGPEnvironment
    ) {
        self.clientId = clientId
        self.environment = environment
        self.checkoutRerefence = checkoutRerefence
        MangopayVault.initialize(clientId: clientId, environment: environment == .sandbox ? .sandbox : environment == .t3 ? .t3 : .prod)
    }

    public static func tokenize(
        card: MGPCardInfo,
        with cardReg: CardRegistration,
        mangoPayVaultCallback: @escaping MangopayTokenizedCallBack
    ) {

        guard clientId != nil, !clientId.isEmpty else {
            mangoPayVaultCallback(.none, MGPError.initializationRqd)
            return
        }

         MangopayVault.tokenizeCard(
            card: CardInfo(
                cardNumber: card.cardNumber,
                cardExpirationDate: card.cardExpirationDate,
                cardCvx: card.cardCvx,
                cardType: card.cardType,
                accessKeyRef: card.accessKeyRef,
                data: card.data
            ),
            cardRegistration: cardReg) { tokenisedCard, error in
                guard let _card = tokenisedCard else {
                    mangoPayVaultCallback(.none, MGPError.tokenizationError(additionalInfo: error?.localizedDescription))
                    return
                    
                }
                let res = TokenizedCardData(
                    card: _card
                )
                mangoPayVaultCallback(res, .none)
            }
        
    }
    
    
}
