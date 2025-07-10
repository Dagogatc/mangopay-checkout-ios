import Foundation
import UIKit

public struct MangopayCheckoutSDK {

    static var clientId: String!
    public static var apiKey: String!
    static var environment: MGPEnvironment!

    public static func initialize(clientId: String, checkoutRerefence: String, environment: MGPEnvironment) {
        self.clientId = clientId
        self.environment = environment

        Tokenizer.initialize(clientId: clientId, checkoutRerefence: checkoutRerefence, environment: environment)
    }

    public static func tokenizeCard(
        form: MGPPaymentForm,
        with cardReg: MGPCardRegistration,
        payData: Payable? = nil,
        presentIn viewController: UIViewController? = nil,
        callBack: @escaping MangopayTokenizedCallBack
    ) {


        guard form.isFormValid else {
            callBack(nil, MGPError.invalidForm)
            return
        }

        Tokenizer.tokenize(
            card: form.cardData,
            with: cardReg.toVaultCardReg,
        ) { tokenizedCardData, error in
            var _payinData = payData
            _payinData?.cardID = tokenizedCardData?.card.cardID
            DispatchQueue.main.async {
                callBack(tokenizedCardData, error)
            }
        }
    }

    public static func launch3DSIfPossible(
        payData: Payable? = nil,
        presentIn viewController: UIViewController?,
        on3DSSucces: ((String) -> ())? = nil,
        on3DSFailure: ((String) -> ())? = nil,
        on3DSError: ((MGPError) -> ())? = nil
    ) {
        guard payData?.secureModeNeeded == true else {
            print("secureModeNeeded is false ")
            return
        }
        
        guard let _ = payData else {
            on3DSError?(MGPError._3dsPayInDataRqd)
            return
        }
        
        guard let _ = viewController else {
            on3DSError?(MGPError._3dsPresentingVCRqd)
            return
        }
        
        guard let urlStr = payData?.secureModeRedirectURL, let url = URL(string: urlStr) else {
            return
        }

        let _3dsVC = ThreeDSController(
            secureModeReturnURL: url,
            secureModeRedirectURL: nil,
            transactionType: .cardDirect,
            onComplete: { result in
                switch result.status {
                case .SUCCEEDED:
                    on3DSSucces?(result.id)
                case .FAILED:
                    on3DSFailure?(result.id)
                default: break
                }
            }) { error in
                on3DSError?(MGPError._3dsError(additionalInfo: error?.localizedDescription))
            }
        
        viewController?.present(_3dsVC, animated: true)
    }
}
