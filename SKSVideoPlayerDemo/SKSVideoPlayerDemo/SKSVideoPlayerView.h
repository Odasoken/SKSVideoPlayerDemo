//
//  SKSVideoPlayerView
//  
//
//  Created by juliano on 4/10/18.
//  Copyright © 2018 Juliano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKSVideoPlayerView : UIView

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, copy) void(^progressChangedOpration)(SKSVideoPlayerView* playerView,double progress, double duration);

+(instancetype)videoPlayerView;
-(void)play;
-(void)pause;

-(void)mute:(BOOL)isMuted;

@end
