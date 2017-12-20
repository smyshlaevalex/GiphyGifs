//
//  GifCollectionViewCell.h
//  GiphyGifs
//
//  Created by Alexander Smyshlaev on 12/18/17.
//  Copyright © 2017 Alexander Smyshlaev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLAnimatedImageView.h"

@interface GifCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet FLAnimatedImageView* imageView;

@end
