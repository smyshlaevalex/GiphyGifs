//
//  AppDelegate.m
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/18/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.giphy.com/v1/gifs/search?q=cat&api_key=Bk89RNokSMXJjhDDaHrC0h5gFPc6GJr5&limit=2"]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //[request setHTTPBody:jsonData];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //NSLog(@"%@\n", jsonResponse);
        
        @try {
            NSArray* imageURLs = @[jsonResponse[@"data"][0][@"images"][@"fixed_width"][@"url"], jsonResponse[@"data"][2][@"images"][@"fixed_width"][@"url"]];
            
            NSLog(@"%@\n", imageURLs);
        } @catch (NSException* exception) {
            NSLog(@"Something bad happend, but nobody cares");
        }
    }];
    
    [task resume];*/
    
    /*[[GiphyStore new] requestGifsWithSearchQuery:@"cat" limit:4 complition:^(NSArray<FLAnimatedImage *> * _Nullable gifs, NSError * _Nullable error) {
        
    }];*/
    
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
