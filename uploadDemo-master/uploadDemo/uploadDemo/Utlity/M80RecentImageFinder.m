 //
//  M80RecentImageFinder.m
//  M80ImageMerger
//
//  Created by amao on 2016/12/7.
//  Copyright © 2016年 M80. All rights reserved.
//

#import "M80RecentImageFinder.h"
#import "uploadDemo-Swift.h"
@import Photos;

#define M80LASTSEARCHDATE   @"last_search_date_key"


@interface M80RecentImageFinder ()
@property (nonatomic,strong)    NSDate *lastSearchDate;  //防止每次启动就检查一遍
@end

@implementation M80RecentImageFinder
- (instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)run
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                
//                PHFetchResult *recentCollections = [PHAssetCollection
//
//                   fetchAssetCollectionsWithType  :   PHAssetCollectionTypeSmartAlbum
//                                        subtype   :   PHAssetCollectionSubtypeSmartAlbumRecentlyAdded
//                                                                                            options:nil];

                PHFetchResult *recentCollections = [PHAssetCollection
                                                    
                                                    fetchAssetCollectionsWithType  :   PHAssetCollectionTypeSmartAlbum
                                                    subtype   :   PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                                    options:nil];
                
                
                
                
                
                
                PHFetchOptions *fetchOptions = [PHFetchOptions new];
                fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
//                fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeVideo];
                
                
                PHAssetCollection *collection = [recentCollections firstObject];
                PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
                
//                NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-120];
                NSDate *lastSearchDate = self.lastSearchDate;
                
                NSMutableArray *items = [NSMutableArray array];
                 NSMutableArray *dates = [NSMutableArray array];
                
                [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[PHAsset class]])
                    {
                        PHAsset *asset = (PHAsset *)obj;
                        NSDate *creationDate = asset.creationDate;
                        

                        
                        //1.备份现在时间之前的照片 2.备份过的不要备份
                            if ([creationDate timeIntervalSinceDate:[NSDate dateWithTimeIntervalSinceNow:0]] < 0 && [creationDate timeIntervalSinceDate:lastSearchDate] > 0)
                            {
                                [items addObject:asset];
                                [dates addObject:creationDate];
                            }
                        

                    }
                }];
                
                if ([items count] > 0)
                {
                    [self.delegate onFindRecentImages:items date:dates];
                }
                
                self.lastSearchDate = [NSDate date];
               
            }
        });
    }];
}

- (void)onActive:(NSNotification *)notification
{
    [self run];
}

#pragma mark - lastSearchDate
- (NSDate *)lastSearchDate
{
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:M80LASTSEARCHDATE];
    return date ?: [NSDate dateWithTimeIntervalSince1970:0];
}

- (void)setLastSearchDate:(NSDate *)lastSearchDate
{
    [[NSUserDefaults standardUserDefaults] setObject:lastSearchDate
                                              forKey:M80LASTSEARCHDATE];
}

-(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}
@end
