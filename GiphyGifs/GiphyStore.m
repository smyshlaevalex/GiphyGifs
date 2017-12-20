//
//  GiphyStore.m
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/18/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import "GiphyStore.h"

#define JSONParsingErrorDomain @"JSONParsingErrorDomain"

@implementation GiphyStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return self;
}

- (void)requestGifsWithSearchQuery:(nonnull NSString*)query limit:(int)limit complition:(nonnull GiphyStoreSearchRequestComplition)complition {
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURL* requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.giphy.com/v1/gifs/search?q=%@&api_key=%@&limit=%i", query, [APIKeyProvider giphyAPIKey], limit]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data == nil) {
            complition(nil, error);
            return;
        }
        
        NSError* jsonConvervionError;
        NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonConvervionError];
        if (jsonConvervionError != nil) {
            complition(nil, jsonConvervionError);
            return;
        }
        
        if (![jsonResponse isKindOfClass:[NSDictionary class]]) {
            complition(nil, [GiphyStore jsonParsingErrorWithCode:0]);
            return;
        }
        
        NSArray* jsonArrayOfGifs = jsonResponse[@"data"];
        if (![jsonArrayOfGifs isKindOfClass:[NSArray class]]) {
            complition(nil, [GiphyStore jsonParsingErrorWithCode:1]);
            return;
        }
        
        NSArray* gifURLs = [jsonArrayOfGifs mapObjectsUsingBlock:^id _Nonnull(id  _Nonnull obj, NSUInteger idx) {
            if (![obj isKindOfClass:[NSDictionary class]]) {
                complition(nil, [GiphyStore jsonParsingErrorWithCode:2]);
                return nil;
            }
            
            NSDictionary* gifTypes = obj[@"images"];
            if (![gifTypes isKindOfClass:[NSDictionary class]]) {
                complition(nil, [GiphyStore jsonParsingErrorWithCode:3]);
                return nil;
            }
            
            NSDictionary* gifData = gifTypes[@"fixed_width"];
            if (![gifData isKindOfClass:[NSDictionary class]]) {
                complition(nil, [GiphyStore jsonParsingErrorWithCode:4]);
                return nil;
            }
            
            NSString* gifURLString = gifData[@"url"];
            if (![gifURLString isKindOfClass:[NSString class]]) {
                complition(nil, [GiphyStore jsonParsingErrorWithCode:5]);
                return nil;
            }
            
            NSURL* gifURL = [NSURL URLWithString:gifURLString];
            if (gifURL == nil) {
                complition(nil, [GiphyStore jsonParsingErrorWithCode:6]);
                return nil;
            }
            
            return gifURL;
        }];
        
        [self downloadGifsWithURLs:gifURLs complition:^(NSArray<FLAnimatedImage *> * _Nonnull gifs) {
            complition(gifs, nil);
        }];
    }];
    
    [task resume];
}

+ (NSError*)jsonParsingErrorWithCode:(NSInteger)code {
    return [NSError errorWithDomain:JSONParsingErrorDomain code:code userInfo:nil];
}

- (void)downloadGifsWithURLs:(nonnull NSArray<NSURL*>*)urls complition:(void (^_Nonnull)(NSArray<FLAnimatedImage*>*_Nonnull))complition {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray<NSData*>* gifData = [NSMutableArray arrayWithCapacity:urls.count];
        
        for (NSURL* url in urls) {
            [_operationQueue addOperationWithBlock:^{
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                
                [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if (data != nil) {
                        [gifData addObject:data];
                    }
                    
                    dispatch_semaphore_signal(semaphore);
                }] resume];
                
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            }];
        }
        
        [_operationQueue waitUntilAllOperationsAreFinished];
        
        NSArray<FLAnimatedImage*>* gifs = [gifData mapObjectsUsingBlock:^id _Nonnull(id  _Nonnull obj, NSUInteger idx) {
            return [[FLAnimatedImage alloc] initWithAnimatedGIFData:obj];
        }];
        
        complition(gifs);
    });
}

@end
