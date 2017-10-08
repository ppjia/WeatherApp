//
//  WeatherAPPTests.swift
//  WeatherAPPTests
//
//  Created by ruixue on 7/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import XCTest
@testable import WeatherAPP

class WeatherAPPTests: XCTestCase {
    
    func testWeatherFetching() {
        let session = MockSession()
        session.dataTaskWithRequestCalled = { request in
            (self.loadSampleFileData(fileName: "testjson"), URLResponse(), nil)
        }
        let client = WeatherClient(session: session)
        client.fetchWeatherDataWith(cityID: 11111) { result in
            switch result {
            case let .success(weatherDetails):
                XCTAssert(weatherDetails.main.temperature == 26.28)
            default:
                XCTFail()
            }
        }
    }
    
    func loadSampleFileData(fileName: String) -> Data? {
        guard let sampleFilePath = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: sampleFilePath)
    }
    
}
