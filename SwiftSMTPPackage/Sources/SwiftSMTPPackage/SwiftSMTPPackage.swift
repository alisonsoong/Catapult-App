struct SwiftSMTPPackage {
    public init(hostname: String,
                email: String,
                password: String,
                port: Int32 = 587,
                tlsMode: TLSMode = .requireSTARTTLS,
                tlsConfiguration: TLSConfiguration? = nil,
                authMethods: [AuthMethod] = [],
                domainName: String = "localhost",
                timeout: UInt = 10)
}
