//
//  NSObject+thumbnailImage.m
//  uploadDemo
//
//  Created by 柏超曾 on 3/9/18.
//  Copyright © 2018 hellomiao. All rights reserved.
//

#import "NSObject+thumbnailImage.h"
#import <AVFoundation/AVFoundation.h>

@implementation NSObject (thumbnailImage)


+ (void)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time block:(void (^)(UIImage *))block{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        NSParameterAssert(asset);
        AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetImageGenerator.appliesPreferredTrackTransform = YES;
        assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
        CGImageRef thumbnailImageRef = NULL;
        CMTime ztime = CMTimeMakeWithSeconds(time, 600);
        NSError *thumbnailImageGenerationError = nil;
        thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:ztime actualTime:NULL error:&thumbnailImageGenerationError];
        if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
        UIImage *  thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            if (thumbnailImage != nil) {
                  block(thumbnailImage);
//            }
            
          
        });
  
    });
    
}

@end
