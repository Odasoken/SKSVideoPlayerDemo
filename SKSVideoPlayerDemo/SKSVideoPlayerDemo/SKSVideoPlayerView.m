//
//  SKSVideoPlayerView.m
//  
//
//  Created by juliano on 4/10/18.
//  Copyright © 2018 Juliano. All rights reserved.
//

#import "SKSVideoPlayerView.h"
#import "UIView+SKSXibInstance.h"
#import <AVFoundation/AVFoundation.h>

@interface SKSVideoPlayerView()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *item;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) NSTimer *monitorTimer;

@end

@implementation SKSVideoPlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(instancetype)videoPlayerView
{
    return [self sks_loadUIViewXibInstance];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self bringSubviewToFront:self.activityView];
}

-(void)dealloc
{
    [self beginMonitor:false];
     [self.item removeObserver:self forKeyPath:@"status"];
}




-(void)setVideoUrl:(NSString *)videoUrl{
    
    if ([videoUrl isEqualToString:_videoUrl] && self.progress < 1.0 && self.player)
    {
        return;
    }
    
    _videoUrl = videoUrl;
    if (self.player)
    {
        [self.player pause];
        self.player = nil;
        [self.playerLayer removeFromSuperlayer];
        [self.item removeObserver:self forKeyPath:@"status"];
        self.playerLayer = nil;
    }
    
    AVPlayer *player = [[AVPlayer alloc] init];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoUrl]];
    self.item = item;
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [player replaceCurrentItemWithPlayerItem:item];
    [self.contentView.layer addSublayer:playerLayer];
    self.player = player;
    self.playerLayer = playerLayer;
   
    
    playerLayer.frame = self.contentView.bounds;
}

-(void)beginMonitor:(BOOL)shouldBegin
{
    if (shouldBegin)
    {
        [_monitorTimer invalidate];
        _monitorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeElapse) userInfo:nil repeats:YES];
    }else
    {
        [_monitorTimer invalidate];
        _monitorTimer = nil;
    }
}

-(void)timeElapse
{
    CGFloat currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    CGFloat duration = CMTimeGetSeconds(self.player.currentItem.duration);
    CGFloat progress = currentTime / CMTimeGetSeconds(self.player.currentItem.duration);
    self.progress = progress;
    if (self.progressChangedOpration)
    {
        self.progressChangedOpration(self, progress, duration);
    }
//    if (currentTime > 0 && progress >= 1.0)
//    {
//        if (self.finishPlayOpration)
//        {
//            [self beginMonitor:false];
//            self.finishPlayOpration(self);
//        }
//    }
}
//
//-(void)suspandNotification
//{
//    
//}
-(void)play
{
    self.activityView.hidden = false;
    [self.activityView startAnimating];
    [self.player play];
    
    [self beginMonitor:true];
}
-(void)pause
{
    [self.player pause];
    [self beginMonitor:false];
}


-(void)mute:(BOOL)isMuted
{
    [[self player] setMuted:isMuted];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.playerLayer.frame = self.contentView.bounds;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"])
    {
         if ([playerItem status] == AVPlayerItemStatusReadyToPlay)
         {
             [self.activityView stopAnimating];
             CGRect rect = self.playerLayer.videoRect;
//             NSLog(@"self.playerLayer.videoRect:%@",NSStringFromCGRect(rect));
         }else  if ([playerItem status] == AVPlayerItemStatusFailed)
         {
             [self.activityView stopAnimating];
//             NSLog(@"self.playerLayer.videoRect:%@",NSStringFromCGRect(rect));
         }
    }
}

@end
