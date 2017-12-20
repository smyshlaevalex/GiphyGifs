//
//  NSArray+Map.m
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/20/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

- (NSArray*)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id newObject = block(obj, idx);
        if (newObject != nil) {
            [newArray addObject:block(obj, idx)];
        }
    }];
    
    return newArray;
}

@end
