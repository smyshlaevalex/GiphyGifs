//
//  GiphyStore.h
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/18/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAnimatedImage.h"
#import "APIKeyProvider.h"
#import "NSArray+Map.h"

typedef void(^GiphyStoreSearchRequestComplition)(NSArray<FLAnimatedImage*>*__nullable, NSError*__nullable);

@interface GiphyStore : NSObject {
    NSOperationQueue* _operationQueue;
}

- (void)requestGifsWithSearchQuery:(nonnull NSString*)query limit:(int)limit complition:(nonnull GiphyStoreSearchRequestComplition)complition;

@end
