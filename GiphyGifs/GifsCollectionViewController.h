//
//  GifsCollectionViewController.h
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/18/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GifCollectionViewCell.h"

#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

#import "GiphyStore.h"

@interface GifsCollectionViewController : UICollectionViewController <UISearchBarDelegate, UISearchResultsUpdating> {
    GiphyStore* _giphyStore;
    
    NSArray<FLAnimatedImage*>* _gifs;
    
    __weak IBOutlet UIActivityIndicatorView *_activityIndicator;
}

- (void)addActivityIndicator;
- (void)removeActivityIndicator;

@end
