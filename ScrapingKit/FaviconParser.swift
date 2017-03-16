//
//  FaviconParser.swift
//  ScrapingKit
//
//  Created by Takuya Yokoyama on 2017/03/16.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation
import Ji

open class FaviconParser: Parser {
    
    public struct FaviconParserConfiguration {}
    
    public typealias Result = [URL]
    public typealias Configuration = FaviconParserConfiguration
    
    public var configuration: Configuration?
    private var result = [URL]()
    
    public required init() {}
    public required init(_ configuration: Configuration?) {
        self.configuration = configuration
    }
    
    public func parse(_ url: URL) {
        let jiDoc = Ji(htmlURL: url)
        
        var faviconUrls = [URL]()
        
        if let scheme = url.scheme,
            let host = url.host,
            let url = URL(string: "\(scheme)://\(host)/favicon.ico") {
            faviconUrls.append(url)
        }
        
        [
            "//link[@rel=\"icon\"]",
            "//link[@rel=\"shortcut icon\"]",
            "//link[@rel=\"apple-touch-icon\"]",
            "//link[@rel=\"apple-touch-icon image_src\"]",
            "//link[@rel=\"apple-touch-icon-precomposed\"]"
        ].forEach {
            faviconUrls.append(
                contentsOf: jiDoc?
                    .xPath($0)?
                    .flatMap{ $0.attributes["href"] }
                    .map{ URLCompleter.completeUrlIfNeeded(baseUrl: url, targetUrl: $0) }
                    .flatMap{ URL(string: $0) } ?? []
            )
        }
        
        self.result = faviconUrls
    }
    
    public func getResult(completion: @escaping (Result) -> Void) {
        DispatchQueue.global().async { [weak self] in
            let sortedUrls = self?.result
                .flatMap({ (url) -> (url: URL, image: UIImage)? in
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        return (url: url, image: image)
                    } else {
                        return nil
                    }
                })
                .sorted(by: { (tuple1, tuple2) -> Bool in
                    let size1 = tuple1.image.size
                    let size2 = tuple2.image.size
                    return max(size1.width, size1.height) > max(size2.width, size2.height)
                })
                .map{ $0.url } ?? []
            
            DispatchQueue.main.async {
                completion(sortedUrls)
            }
        }
    }
}
