//
//  RequestManager.m
//  Blendedd
//
//  Created by iOS Developer on 15/11/15.
//  Copyright © 2015 Prabh Kiran Kaur. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager
NSURLSessionConfiguration *defaultConfigObject;
NSURLSession *defaultSession;
NSURL * url;
NSArray *temp;
NSString *paramterString;
NSEnumerator *e;
NSMutableURLRequest * urlRequest;
NSURLSessionDataTask * dataTask;
NSDictionary* responseDict;
NSDictionary *dict;
+(void)getFromServer:(NSString*)api parameters:(NSMutableDictionary*)parameters completionHandler:(RequestManagerHandler)handler
{
    if (defaultSession) {
        defaultSession=nil;
        defaultConfigObject=nil;
        url=nil;
        temp=nil;
        paramterString=nil;
        e=nil;
        dict=nil;
        responseDict=nil;
        dataTask=nil;
        urlRequest=nil;
        
    }
    
    defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    if (!defaultSession) {
        defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

    }
    
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,api]];
    
    temp = [[NSArray alloc] init];
    temp = [parameters allKeys];
    paramterString=@"";
   

    e = [temp objectEnumerator];
    id object;
    while (object = [e nextObject]) {
        paramterString=[[[[paramterString stringByAppendingString:object] stringByAppendingString:@"="]stringByAppendingString:[parameters objectForKey:object]]stringByAppendingString:@"&"];
    }
    paramterString = [paramterString substringToIndex:paramterString.length-1];
    
     urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[paramterString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                    NSLog(@"Response:%@ %@\n", response, error);
                                    NSLog(@"parameters:%@",paramterString);

                                    if(error == nil)
                                    {
                             //      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                           
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0.1), ^{
                                           responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                            NSLog(@"Parsed");
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if(handler != nil && responseDict != nil)
                                                    handler(responseDict);
                                                //  NSLog(@"%@",responseDict);
                                               // NSLog(@"Parse and send");
                                                
                                            });
                                        });
                                    }
                                    else
                                    {
                                        NSLog(@"Connection Error :- %@", [error description]);
                                        
                                        dict =[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"error", nil];
                                        handler(dict);
                                    }
                                    defaultSession=nil;
                                    
                                }];
    [dataTask resume];
    
}

@end
