//
//  MASStockTradingUITestsLaunchTests.m
//  MASStockTradingUITests
//
//  Created by Pratap Reddy Guvvala on 20/12/21.
//  Copyright © 2021 CA Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MASStockTradingUITestsLaunchTests : XCTestCase

@end

@implementation MASStockTradingUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return NO;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

//- (void)testLaunch {
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app launch];
//
//    // Insert steps here to perform after app launch but before taking a screenshot,
//    // such as logging into a test account or navigating somewhere in the app
//
//    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
//    attachment.name = @"Launch Screen";
//    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
//    [self addAttachment:attachment];
//}

@end
