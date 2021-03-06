//
//  M80RecentImageFinder.h
//  M80ImageMerger
//
//  Created by amao on 2016/12/7.
//  Copyright © 2016年 M80. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@protocol M80RecentImageFinderDelegate <NSObject>
- (void)onFindRecentImages:(NSArray<PHAsset*> *)images  date:(NSArray<NSDate*> *)date;
@end

@interface M80RecentImageFinder : NSObject
@property (nonatomic,weak)  id<M80RecentImageFinderDelegate>    delegate;
- (void)run;
@end
