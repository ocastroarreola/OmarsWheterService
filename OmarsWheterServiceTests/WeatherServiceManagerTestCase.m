//
//  WeatherServiceManagerTestCase.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/3/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherServiceManager.h"

@interface WeatherServiceManagerTestCase : XCTestCase <WeatherServiceManagerDelegate>

@property (nonatomic, strong) WeatherServiceManager * manager;
@property (nonatomic, strong) XCTestExpectation *expectation;
@end

@implementation WeatherServiceManagerTestCase

-(WeatherServiceManager*)manager {
    if (!_manager) {
        _manager = [[WeatherServiceManager alloc]init];
        _manager.delegate = self;
        
    }
    return _manager;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPathForImage {
    // This is an example of a functional test case.
    NSString * imageName = @"testimage.png";
    NSString * path = [WeatherServiceManager pathForImage:imageName];
    BOOL result = [path hasSuffix:[NSString stringWithFormat:@"/Documents/%@",imageName]];
    XCTAssertEqual(result, TRUE);
}

- (void)testZipList {
    XCTAssertNotNil([WeatherServiceManager zipList]);
}

-(void)testGetImages {
     self.expectation = [self expectationWithDescription:@"downloadImage"];
    [self.manager getWeatherImageForCode:@"01n"];
    [self waitForExpectationsWithTimeout:2
                                 handler:nil];
}

-(void)testGetCurrentWeather {
    self.expectation = [self expectationWithDescription:@"getCurrentWeather"];
    [self.manager getWeatherDetailsForZip:@"11206"];
    [self waitForExpectationsWithTimeout:2
                                 handler:nil];
}

-(void)didFinishGettingService:(WeatherServices)service details:(NSDictionary *)details {
    [self.expectation fulfill];
    self.expectation = nil;
    if (WeatherServicesCurrentWeather) {
        XCTAssertNotNil(details);
    }
    XCTAssert(@"success");
}

-(void)didFailingService:(WeatherServices)service error:(NSError *)error details:(NSDictionary *)details {
    [self.expectation fulfill];
    self.expectation = nil;
    if ([error.domain isEqualToString:(NSString*)kCFErrorDomainCFNetwork]) {
        XCTAssertNotNil(@"fail");
    }
    XCTAssert(@"networkError");
}

@end
