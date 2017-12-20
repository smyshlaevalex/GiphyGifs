//
//  NSArray+Map.h
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/20/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Map)

- (NSArray*)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

@end

NS_ASSUME_NONNULL_END
