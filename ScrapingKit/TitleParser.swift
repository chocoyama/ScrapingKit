//
//  TitleParser.swift
//  ScrapingKit
//
//  Created by Takuya Yokoyama on 2017/03/18.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation
import Ji

open class TitleParser: Parser {
    public struct TitleParserConfiguration {}
    
    public typealias Result = String?
    public typealias Configuration = TitleParserConfiguration
    
    public var configuration: Configuration?
    private var result: String?

    public required init() {}
    public required init(_ configuration: Configuration?) {
        self.configuration = configuration
    }
    
    public func parse(_ url: URL) {
        let jiDoc = Ji(htmlURL: url)
        let content = jiDoc?.xPath("//title")?.first?.content
        self.result = content?
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
    
    public func getResult(completion: @escaping (Optional<String>) -> Void) {
        completion(result)
    }
}
