//
//  LAVersion.h
//  LAVersion
//
//  Created by Luis Ascorbe on 21/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//
/*
 
 LAVersion is available under the MIT license.
 
 Copyright © 2012 Luis Ascorbe.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <Foundation/Foundation.h>

@protocol LAVersionDelegate <NSObject>
@optional
- (void) laVersionNewVersionAvailable:(NSDictionary *)appDataDictionary;
- (void) laVersionUpdateButtonTapped:(id)laVersion;
- (void) laVersionCancelButtonTapped:(id)laVersion;
@end

@interface LAVersion : NSObject <UIAlertViewDelegate>
{
    NSDictionary *dicDatosApp;
}

@property (nonatomic, assign) id<LAVersionDelegate> delegate;

// show an alertview or not (default is YES)
- (id) initShowMessage:(BOOL)showMessage __attribute__((deprecated)); // initShowMessage is deprecated, you should use 'sharedInstance' instead, and then call to checkAppVersion:

// get the shared instance of LAVersion
+ (LAVersion *)sharedInstance;
// method to check if there is a new version available
- (void) checkAppVersion:(BOOL)showMessage;

@end
