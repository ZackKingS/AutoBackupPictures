//
//  NSObject+thumbnailImage.h
//  uploadDemo
//
//  Created by 柏超曾 on 3/9/18.
//  Copyright © 2018 hellomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (thumbnailImage)


+ (void ) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time  block:(void(^)(UIImage *))block;
@end
