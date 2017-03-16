//
//  ScrapingFaviconTests.swift
//  ScrapingKit
//
//  Created by Takuya Yokoyama on 2017/03/16.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ScrapingKit

class ScrapingFaviconTests: XCTestCase {

    let scraper = Scraper<FaviconParser>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testScraping() {
        let expectation = self.expectation(description: "scraping")
        
        let testUrlString = "http://qiita.com/masamoto/items/798eca8f565c3dde6b1e"
        scraper.scrape(testUrlString) { (result) in
            defer { expectation.fulfill() }
            print("")
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
