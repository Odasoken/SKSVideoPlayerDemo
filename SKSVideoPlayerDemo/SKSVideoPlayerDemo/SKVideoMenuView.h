//
//  SKVideoRecordMenuView.h
//  
//
//  Created by juliano on 4/10/18.
//  Copyright © 2018 Juliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKVideoMenuView : UIView

@property (nonatomic, assign) NSInteger currentInterval;
@property (nonatomic, assign) NSInteger duaration;
@property (nonatomic, copy) void(^playOperationBlock) (BOOL isSelected);
@property (nonatomic, copy) void(^voiceOperationBlock) (BOOL isSelected);

+(instancetype)videoMenuView;
-(void)startAutoPlay;
-(void)restorePlayStatus;

@end
