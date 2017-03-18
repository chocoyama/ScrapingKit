//
//  ScrapingTitleTests.swift
//  ScrapingKit
//
//  Created by Takuya Yokoyama on 2017/03/18.
//  Copyright © 2017年 chocoyama. All rights reserved.
//

import XCTest
@testable import ScrapingKit

class ScrapingTitleTests: XCTestCase {
    
    let scraper = Scraper<TitleParser>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testScrapint() {
        let expectation = self.expectation(description: "scraping")
        
        let testUrlString = "https://matome.naver.jp"
        scraper.scrape(testUrlString) { (result) in
            defer { expectation.fulfill() }
            print("")
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
