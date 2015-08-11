//
//  TeamListerTests.m
//  TeamListerTests
//
//  Created by Nicholas Long on 8/9/15.
//  Copyright (c) 2015 longsview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WebServices.h"

@interface TeamListerTests : XCTestCase
{
    WebServices *webServices;
}

@end

@implementation TeamListerTests

- (void)setUp {
    [super setUp];
    
    webServices = [[WebServices alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testWebService
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing web service!"];
    [webServices getUsers:^(NSArray *array, NSError *error) {
        XCTAssert(array.count > 0, @"Pass");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}

@end
