//
//  GifsCollectionViewController.m
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/18/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import "GifsCollectionViewController.h"

@interface GifsCollectionViewController ()

@end

@implementation GifsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gifs = [[NSArray alloc] init];
    _giphyStore = [[GiphyStore alloc] init];
    
    self.navigationItem.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.navigationItem.searchController.searchBar.delegate = self;
    self.navigationItem.searchController.searchResultsUpdater = self;
    self.navigationItem.searchController.obscuresBackgroundDuringPresentation = NO;
    self.navigationItem.searchController.searchBar.placeholder = @"Search gifs";
    
    self.collectionView.allowsSelection = NO;
    
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationItem.searchController.active = YES;
    
    [self removeActivityIndicator];
}

- (void)addActivityIndicator {
    _activityIndicator.hidden = NO;
    [_activityIndicator startAnimating];
}

- (void)removeActivityIndicator {
    _activityIndicator.hidden = YES;
    [_activityIndicator stopAnimating];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _gifs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.animatedImage = _gifs[indexPath.row];
    
    return cell;
}

#pragma mark <UISearchResultsUpdating>

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self addActivityIndicator];
    
    [_giphyStore requestGifsWithSearchQuery:searchBar.text limit:20 complition:^(NSArray<FLAnimatedImage *> * _Nullable gifs, NSError * _Nullable error) {
        if (gifs != nil) {
            _gifs = gifs;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                
                [self removeActivityIndicator];
            });
        } else if (error != nil) {
            NSLog(@"Error:---  %@", error.localizedDescription);
        }
    }];
    
    self.navigationItem.searchController.active = NO;
}

@end
