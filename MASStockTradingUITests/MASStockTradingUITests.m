//
//  MASStockTradingUITests.m
//  MASStockTradingUITests
//
//  Created by Pratap Reddy Guvvala on 20/12/21.
//  Copyright © 2021 CA Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>

#define USER_NAME                         @"admin"
#define PASSWORD                          @"7layer"
#define SYSTEM_ALERT_HANDLER              @"SystemAlertHandler"
#define ALLOW_ONCE                        @"Allow Once"
#define STOCK_CODE                        @"Stock Code"
#define NUMBER_OF_SHARES                  @"NumberOfShares"
#define STOCKS                            @"CA"
#define S_Count                           @"10"
#define BUY                               @"Buy"
#define SELL                              @"Sell"
#define RESULT_TEXT_VIEW                  @"ResultTextView"
#define CANCEL                            @"Cancel"
#define TIME_INTERVAL                     10
#define MAS_UI_CANCEL                     @"masui-cancelBtn"
#define MAS_UI_LogIn                      @"Login"
#define MAS_UI_USER_TEXTFIELD             @"masui-usernameField"
#define MAS_UI_PASSWORD_FIELD             @"masui-passwordField"
#define USER_CANCEL_OTP_SELECTION         @"OTP channel selection has been cancelled by user."
#define MAS_RESPONSE_INFO_BODY_INFO_KEY   @"MASResponseInfoBodyInfoKey"
#define MAS_RESPONSE_INFO_HEADER_INFO_KEY @"MASResponseInfoHeaderInfoKey"
#define INVALID_CREDENTIALS               @"Username or password invalid"
#define OK_BUTTON                         @"OK"


@interface MASStockTradingUITests : XCTestCase

@property(nonatomic,strong) XCUIApplication *app;
@end

@implementation MASStockTradingUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    _app = [[XCUIApplication alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)checkSystemAlerts {
    
    [self addUIInterruptionMonitorWithDescription:SYSTEM_ALERT_HANDLER handler:^BOOL(XCUIElement * _Nonnull interruptingElement) {
        NSString * allowOnce = ALLOW_ONCE;
        XCUIElementQuery * buttons = interruptingElement.buttons;
        if ([buttons[allowOnce] exists]) {
            [buttons[allowOnce] tap];
            return YES;
        }
        return NO;
    }];
}

- (void)checkStocks {
    
    BOOL checkStocksPage = [_app.textFields[STOCK_CODE] waitForExistenceWithTimeout:TIME_INTERVAL];
    if(checkStocksPage) {
        XCUIElement *stockCode = _app.textFields[STOCK_CODE];
        XCUIElement *stockCount = _app.textFields[NUMBER_OF_SHARES];
        
        [stockCode tap];
        [stockCode typeText:STOCKS];
        
        [stockCount tap];
        [stockCount typeText:S_Count];
    }
}

-(void)waitForElement:(XCUIElement *)element {
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:exists evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:TIME_INTERVAL handler:nil];
}
-(BOOL)checkInValidCredentials {
    
    BOOL invalidCredentialFlag = [_app.alerts.staticTexts[INVALID_CREDENTIALS] waitForExistenceWithTimeout:TIME_INTERVAL];

    if(invalidCredentialFlag) {
        XCUIElement *invalidCredential = _app.alerts.staticTexts[INVALID_CREDENTIALS];
        if ([invalidCredential exists]) {
            
            XCUIElement *loginFailureAlert = _app.alerts.buttons[OK_BUTTON];
            if([loginFailureAlert exists]){
                [loginFailureAlert tap];
            }

            return true;
        }
        return false;
    }
    return false;
}

- (void)test_BUY_Stocks {
    [_app launch];
    
    [self checkSystemAlerts];
    [self checkStocks];
    
    XCUIElement *buyStocks = _app.staticTexts[BUY];
    if([buyStocks exists]) {
        [buyStocks tap];
    }
    
    BOOL masuiCancelBtn = [_app.buttons[MAS_UI_CANCEL] waitForExistenceWithTimeout:TIME_INTERVAL];
    
    if(masuiCancelBtn) {
        
        XCUIElement *userElement = _app.textFields[MAS_UI_USER_TEXTFIELD];
        XCUIElement *passwordElement = _app.secureTextFields[MAS_UI_PASSWORD_FIELD];
        
        [userElement tap];
        [userElement typeText:USER_NAME];
        
        [passwordElement tap];
        [passwordElement typeText:PASSWORD];
        
        XCUIElement *logInElement = _app.staticTexts[MAS_UI_LogIn];
        [logInElement tap];
        
        BOOL invalidCredentials = [self checkInValidCredentials];
        if(invalidCredentials) {
            XCTAssertFalse(true);
        }
    }
    
    XCUIElement *textViewElement = _app.textViews[RESULT_TEXT_VIEW];

    BOOL masui_OTP_CancelBtn_Flag = [_app.tables.staticTexts[CANCEL] waitForExistenceWithTimeout:TIME_INTERVAL];
    if(masui_OTP_CancelBtn_Flag) {
        XCUIElement *masui_OTP_CancelBtn = _app.tables.staticTexts[CANCEL];
        [masui_OTP_CancelBtn tap];
        
        [self waitForElement:textViewElement];

        NSString *strResult = [NSString stringWithFormat:@"%@",textViewElement.value];
        XCTAssertTrue([strResult isEqualToString:USER_CANCEL_OTP_SELECTION]);
        
    } else {
        
        [self waitForElement:textViewElement];
        NSString *strResult=[NSString stringWithFormat:@"%@",textViewElement.value];
        XCTAssert([strResult containsString:MAS_RESPONSE_INFO_BODY_INFO_KEY]);
        XCTAssert([strResult containsString:MAS_RESPONSE_INFO_HEADER_INFO_KEY]);
    }
}



- (void)test_SELL_Stocks {
    
    [_app launch];
    
    [self checkSystemAlerts];
    [self checkStocks];
    
    XCUIElement *buyStocks = _app.staticTexts[SELL];
    if([buyStocks exists]) {
        [buyStocks tap];
    }
    
    BOOL masuiCancelBtn = [_app.buttons[MAS_UI_CANCEL] waitForExistenceWithTimeout:TIME_INTERVAL];
    
    if(masuiCancelBtn) {
        
        XCUIElement *userElement = _app.textFields[MAS_UI_USER_TEXTFIELD];
        XCUIElement *passwordElement = _app.secureTextFields[MAS_UI_PASSWORD_FIELD];
        
        [userElement tap];
        [userElement typeText:USER_NAME];
        
        [passwordElement tap];
        [passwordElement typeText:PASSWORD];
        
        XCUIElement *logInElement = _app.staticTexts[MAS_UI_LogIn];
        [logInElement tap];
        
        BOOL invalidCredentials = [self checkInValidCredentials];
        if(invalidCredentials) {
            XCTAssertFalse(true);
        }
    }
    
    XCUIElement *textViewElement = _app.textViews[RESULT_TEXT_VIEW];

    BOOL masui_OTP_CancelBtn_Flag = [_app.tables.staticTexts[CANCEL] waitForExistenceWithTimeout:TIME_INTERVAL];
    if(masui_OTP_CancelBtn_Flag) {
        XCUIElement *masui_OTP_CancelBtn = _app.tables.staticTexts[CANCEL];
        [masui_OTP_CancelBtn tap];
        
        [self waitForElement:textViewElement];

        NSString *strResult = [NSString stringWithFormat:@"%@",textViewElement.value];
        XCTAssertTrue([strResult isEqualToString:USER_CANCEL_OTP_SELECTION]);
        
    } else {
        
        [self waitForElement:textViewElement];
        NSString *strResult=[NSString stringWithFormat:@"%@",textViewElement.value];
        XCTAssert([strResult containsString:MAS_RESPONSE_INFO_BODY_INFO_KEY]);
        XCTAssert([strResult containsString:MAS_RESPONSE_INFO_HEADER_INFO_KEY]);
    }
}

@end
