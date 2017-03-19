//
//  ImageUrlValidator.swift
//  ScrapingKit
//
//  Created by Takuya Yokoyama on 2017/03/19.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import Foundation

struct ImageUrlValidator {
    static func valiedate(urlString: String) -> URL? {
        guard let url = URL(string: urlString) else { return nil }
        return ImageUrlValidator.validate(url: url)
    }
    
    static func validate(url: URL) -> URL? {
        guard let _ = url.scheme, let _ = url.host else { return nil}
        let path = url.path
        
        if path.hasSuffix(".html") || path.hasSuffix(".php") {
            return nil
        }
        
        return url
    }
}
