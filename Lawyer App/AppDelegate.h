//
//  AppDelegate.h
//  Lawyer App
//
//  Created by iOS Developer on 21/11/16.
//  Copyright © 2016 Paramjeet Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BaseUrl @"http://erginus.net/lawyer_web/api/"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UIViewController *rootViewController;

//                NSDictionary *dataDict = [responseDict valueForKey:@"data"];
//                //Save user information in local
//                NSMutableDictionary *mutableDict = [dataDict mutableCopy];
//                for (NSDictionary *dict in mutableDict) {
//                    for (NSString *key in [dict allKeys])
//                    {
//                        if ([dataDict[key] isEqual:[NSNull null]])
//                        {
//                            mutableDict[key] = @"";//or [NSNull null] or whatever value you want to change it to
//                        }
//                    }
//                }
//
//                dataDict = [mutableDict copy];
//               dataArray = [dataDict valueForKey:@"data"];
@end

