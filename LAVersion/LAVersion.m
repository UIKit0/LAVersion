//
//  LAVersion.m
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

#import "LAVersion.h"

#import "AFJSONRequestOperation.h"

@implementation NSString(LAVersion)

- (NSComparisonResult)compareVersion:(NSString *)version
{
    return [self compare:version options:NSNumericSearch];
}

- (NSComparisonResult)compareVersionDescending:(NSString *)version
{
    switch ([self compareVersion:version])
    {
        case NSOrderedAscending:
        {
            return NSOrderedDescending;
        }
        case NSOrderedDescending:
        {
            return NSOrderedAscending;
        }
        default:
        {
            return NSOrderedSame;
        }
    }
}

@end

@implementation LAVersion

static LAVersion *sharedInstance = nil;

+ (LAVersion *)sharedInstance
{
	if (sharedInstance == nil)
    {
		sharedInstance = [[self alloc] init];
	}
	return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //[self checkAppVersion:YES];
    }
    return self;
}

- (id)initShowMessage:(BOOL)showMessage
{
    self = [super init];
    if (self)
    {
        [self checkAppVersion:showMessage];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
    if (dicDatosApp != nil)
        [dicDatosApp release];
    
    [super dealloc];
}
#endif

- (void) checkAppVersion:(BOOL)showMessage
{
    // LAVersion works with the bundleID of the current app, you culd change it with the id of the app store with this link: http://itunes.apple.com/%@/lookup?id=[AppStoreID]
    // this example uses the AndryBirds's bundleID to show how it works.
    NSString *urlBase = @"http://itunes.apple.com/%@/lookup?bundleId=%@"; // http://itunes.apple.com/%@/lookup?id=%@
    
    // if you want to use the app store id, you must change this code:
    // [[NSBundle mainBundle] bundleIdentifier]]
    // with your app store id
    
    NSString *url = [NSString stringWithFormat:urlBase, [[NSLocale preferredLanguages] objectAtIndex:0], [[NSBundle mainBundle] bundleIdentifier]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            //NSLog(@"JSON LAVersion: %@", JSON);
        
            NSDictionary *dicJSON = [NSDictionary dictionaryWithDictionary:JSON];
            NSArray *arrResultados = [NSArray arrayWithArray:[dicJSON objectForKey:@"results"]];
            
            // compruebo que me haya devuelto resultados
            if ([arrResultados count] > 0)
            {
                dicDatosApp = [[NSDictionary alloc] initWithDictionary:[arrResultados objectAtIndex:0]];
                
                // compruebo que haya pillado la app del app store
                if ([dicDatosApp objectForKey:@"bundleId"])
                {
                    NSString *applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                    
                    // compruebo si hay una version nueva
                    if ([applicationVersion compareVersion:[dicDatosApp objectForKey:@"version"]] == NSOrderedAscending)
                    {
                        if ([self.delegate respondsToSelector:@selector(laVersionNewVersionAvailable:)])
                        {
                            [self.delegate laVersionNewVersionAvailable:dicDatosApp];
                        }
                        
                        // show an alertview
                        if (showMessage)
                        {
                            // Hay nueva version
                            NSString *releaseNotes = [dicDatosApp objectForKey:@"releaseNotes"];
                            
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"New Version! \n What's new:", @"")
                                                                                message:releaseNotes //[NSString stringWithFormat:NSLocalizedString(@"%@ \n\n Do you want update now?", @""), releaseNotes]
                                                                               delegate:self
                                                                      cancelButtonTitle:NSLocalizedString(@"No, thanks", @"")
                                                                      otherButtonTitles:NSLocalizedString(@"Update", @""), nil];
                            [alertView show];
#if !__has_feature(objc_arc)
                            [alertView release];
#endif
                        }
                        else
                        {
#if !__has_feature(objc_arc)
                            if (sharedInstance)
                            {
                                [sharedInstance release];
                                sharedInstance = nil;
                            }
#endif
                        }
                    }
                    else
                    {
                        NSLog(@"LAVersion without results");
                    }
                }
                else
                {
                    NSLog(@"LAVersion could not find this application on iTunes");
                }
            }
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"LAVersion failed with error: %@", [error localizedDescription]);
    }];
    
    NSOperationQueue *operationQueue = [[[NSOperationQueue alloc] init] autorelease];
    [operationQueue addOperation:operation];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if ([self.delegate respondsToSelector:@selector(laVersionCancelButtonTapped:)])
        {
            [self.delegate laVersionCancelButtonTapped:self];
        }
    }
    else if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dicDatosApp objectForKey:@"trackViewUrl"]]];
        
        if ([self.delegate respondsToSelector:@selector(laVersionUpdateButtonTapped:)])
        {
            [self.delegate laVersionUpdateButtonTapped:self];
        }
    }
    
#if !__has_feature(objc_arc)
    if (sharedInstance)
    {
        [sharedInstance release];
        sharedInstance = nil;
    }
#endif
}


@end
