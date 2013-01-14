//
//  ViewController.m
//  LAVersionExample
//
//  Created by Luis Ascorbe on 27/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//

#import "ViewController.h"

#import "LAVersion.h"

@interface ViewController () <LAVersionDelegate>
{
    LAVersion *laVersion;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // LAVersion works with the bundleID of the current app, you culd change it with the id of the app store
    // this example uses the AndryBirds's bundleID to show how it works.
    
    // check if there is a new version
    // do:
    //laVersion = [LAVersion sharedInstance];
    //laVersion.delegate = self;
    //[laVersion checkAppVersion:YES];
    
    // or:
    [[LAVersion sharedInstance] checkAppVersion:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
    // do:
    //[laVersion release];
    
    [super dealloc];
}
#endif

#pragma mark - LAVersionDelegate

- (void)laVersionNewVersionAvailable:(NSDictionary *)appDataDictionary
{
    // newVersionAvailable
}

/*
- (void)laVersionCancelButtonTapped:(id)laVersion
{
    // user tap cancel ('No, thanks') in the UIAlertView
}

- (void)laVersionUpdateButtonTapped:(id)laVersion
{
    // user tap update ('Update') in the UIAlertView
}
 */

@end
