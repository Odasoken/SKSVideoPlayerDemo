//
//  SKSConstant.h
//  SKSVideoPlayerDemo
//
//  Created by juliano on 4/17/18.
//  Copyright © 2018 juliano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
@interface SKSConstant : NSObject

@end

CG_INLINE  NSString *SKSTimeStringWithTimeInterval(NSInteger interval)
{
    NSInteger min = (interval % (60 * 60)) / 60;
    NSInteger sec = (interval % (60 * 60)) % 60;
    return [NSString stringWithFormat:@"%ld:%02ld",(long)min,(long)sec];
}
