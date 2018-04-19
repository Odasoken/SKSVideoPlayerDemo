//
//  UIView+SKSXibInstance.m
//  SKSVideoPlayerDemo
//
//  Created by juliano on 4/17/18.
//  Copyright © 2018 juliano. All rights reserved.
//

#import "UIView+SKSXibInstance.h"

@implementation UIView (SKSXibInstance)


+(instancetype)sks_loadUIViewXibInstance
{
    NSString *className = NSStringFromClass(self);
    NSBundle *bundle = [NSBundle bundleForClass:self];
    UINib *nib = [UINib nibWithNibName:className bundle:bundle];
    id obj = [nib instantiateWithOwner:self options:nil].firstObject;
    return  obj;
}

@end
