import Foundation
import WalletConnectUtils
import WalletConnectNetworking

public class PairingPingService {
    private let pairingStorage: WCPairingStorage
    private let pingRequester: PingRequester
    private let pingResponder: PingResponder
    private let pingResponseSubscriber: PingResponseSubscriber

    public var onResponse: ((String)->())? {
        get {
            return pingResponseSubscriber.onResponse
        }
        set {
            pingResponseSubscriber.onResponse = newValue
        }
    }

    public init(
        pairingStorage: WCPairingStorage,
        networkingInteractor: NetworkInteracting,
        logger: ConsoleLogging) {
            self.pairingStorage = pairingStorage
            self.pingRequester = PingRequester(networkingInteractor: networkingInteractor, method: PairingProtocolMethod.ping)
            self.pingResponder = PingResponder(networkingInteractor: networkingInteractor, method: PairingProtocolMethod.ping, logger: logger)
            self.pingResponseSubscriber = PingResponseSubscriber(networkingInteractor: networkingInteractor, method: PairingProtocolMethod.ping, logger: logger)
        }

    public func ping(topic: String) async throws {
        guard pairingStorage.hasPairing(forTopic: topic) else { return }
        try await pingRequester.ping(topic: topic)
    }
}
