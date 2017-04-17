//
//  AppDelegate.m
//  Lawyer App
//
//  Created by iOS Developer on 21/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import "AppDelegate.h"
#import "RequestManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication* )application didFinishLaunchingWithOptions:(NSDictionary* )launchOptions {
    // Override point for customization after application launch.
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"otp_Verification_Done"] != nil) {
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"otp_Verification_Done"]boolValue ]== true) {
            
        }else{
            NSMutableDictionary *dictWithUserInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:@"SessionLogininfo"] objectForKey:@"user_id"],@"user_id",[[[NSUserDefaults standardUserDefaults]objectForKey:@"SessionLogininfo"] objectForKey:@"user_security_hash"],@"user_security_hash", nil];
            
            // Get a reference to the storyboard
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //session login api run
            
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"confirmOtpScreen"];
            
            // Save a reference to the current root view controller
            self.rootViewController = self.window.rootViewController;
            
            // Set the login view controller as the root view controller
            [self.window setRootViewController:vc];
        }
    }
    else  if ([[NSUserDefaults standardUserDefaults]objectForKey:@"SessionLogininfo"] != nil) {
        
        NSMutableDictionary *dictWithUserInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:@"SessionLogininfo"] objectForKey:@"user_id"],@"user_id",[[[NSUserDefaults standardUserDefaults]objectForKey:@"SessionLogininfo"] objectForKey:@"user_security_hash"],@"user_security_hash", nil];
        
        // Get a reference to the storyboard
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //session login api run
        [RequestManager getFromServer:@"session_login" parameters:dictWithUserInfo   completionHandler:^(NSDictionary *responseDict) {
            if ([[responseDict valueForKey:@"error"] isEqualToString:@"1"]) {
                return ;
            }
            
            if ([[responseDict valueForKey:@"code"] isEqualToString:@"1"]){
                
                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
                //Save user information in local
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"logged_user_check"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_security_hash"] forKey:@"logged_user_security_hash"];
                
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_email"] forKey:@"logged_user_email"];
                
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_name"] forKey:@"logged_user_name"];
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_contact"] forKey:@"logged_user_contact"];
                
                
                
                
                //
                //                 [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_contact"] forKey:@"logged_user_contact"];
                //
                //
                //
                //                 [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_contact"] forKey:@"logged_user_contact"];
                
                
                [[NSUserDefaults standardUserDefaults]setObject:[dataDict valueForKey:@"user_id"] forKey:@"logged_user_id"];
                
            }
        }];
        
        // Get a reference to the login view controller
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"UserLoggedIn"];
        
        // Save a reference to the current root view controller
        self.rootViewController = self.window.rootViewController;
        
        // Set the login view controller as the root view controller
        [self.window setRootViewController:vc];
        
        
        
    }
    
    
    
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
