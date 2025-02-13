//
//  File.swift
//  
//
//  Created by Elikem Savie on 17/10/2022.
//

import Foundation


public func localize(_ key: String, comment: String = "") -> String {
    let x = NSLocalizedString(key, bundle: Bundle.mgpInternal, comment: comment)
    print("🤣 x", x)
//    NSLocalizedString(key, bundle: Bundle.module, comment: comment)
    return x
}

enum LocalizableString {
    static let CARD_INFO_TITLE = localize("CARD_INFO_TITLE")
    static let CARD_NUMBER_PLACEHOLDER = localize("CARD_NUMBER_PLACEHOLDER")
    static let CARD_NAME_PLACEHOLDER = localize("CARD_NAME_PLACEHOLDER")
    static let CARD_EXPIRIY_PLACEHOLDER = localize("CARD_EXPIRIY_PLACEHOLDER")
    static let CARD_CVV = localize("CARD_CVV")
    static let SAVE_PAYMENT_CHECKMARK = localize("SAVE_PAYMENT_CHECKMARK")
    static let BILLING_ADDRESS_CHECKMARK = localize("BILLING_ADDRESS_CHECKMARK")
    static let BILLING_INFO_TITLE = localize("BILLING_INFO_TITLE")
    static let CARD_COUNTRY_PLACEHOLDER = localize("CARD_COUNTRY_PLACEHOLDER")
    static let CARD_ZIP_PLACEHOLDER = localize("CARD_ZIP_PLACEHOLDER")
    static let ERROR_CARD_NUMBER_INVALID = localize("ERROR_CARD_NUMBER_INVALID")
    static let ERROR_CARD_NUMBER_REQUIRED = localize("ERROR_CARD_NUMBER_REQUIRED")
    static let ERROR_CARD_MIN_NUMBER = localize("ERROR_CARD_MIN_NUMBER")
    static let ERROR_FULLNAME_REQUIRED = localize("ERROR_FULLNAME_REQUIRED")
    static let ERROR_CARD_EXPIRED = localize("ERROR_CARD_EXPIRED")
    static let ERROR_CVC_REQUIRED = localize("ERROR_CVC_REQUIRED")
    static let ERROR_EXPIRED_DATE_REQUIRED = localize("ERROR_EXPIRED_DATE_REQUIRED")
    static let ERROR_EXPIRED_DATE = localize("ERROR_EXPIRED_DATE")
    static let ERROR_FUTURE_DATE = localize("ERROR_FUTURE_DATE")
    static let ERROR_TEXT_TOO_SHORT = localize("ERROR_TEXT_TOO_SHORT")
}
