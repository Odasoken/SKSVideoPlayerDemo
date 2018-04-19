//
// UIView+SKSExtension.h
//
//
//  Created by juliano on 18/1/18.
//  Copyright © 2018年 juliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SKSExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign,readonly) CGFloat minX;
@property (nonatomic, assign,readonly) CGFloat minY;
@property (nonatomic, assign,readonly) CGFloat maxX;
@property (nonatomic, assign,readonly) CGFloat maxY;


@end
