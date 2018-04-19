//
//  ViewController.m
//  SKSVideoPlayerDemo
//
//  Created by juliano on 4/17/18.
//  Copyright © 2018 juliano. All rights reserved.
//

#import "ViewController.h"
#import "SKSVideoPlayerView.h"
#import "SKVideoMenuView.h"
#import "SKSConstant.h"

@interface ViewController ()

@property (nonatomic, weak) SKSVideoPlayerView *videoPlayerView;
@property (nonatomic, weak) SKVideoMenuView *videoMenuView;
@property (weak, nonatomic) IBOutlet UIView *videoBackgroundView;
@property (nonatomic, assign) BOOL videoProgressViewHidden;
@property (nonatomic, copy) NSString *currentVideoUrl;


@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.currentVideoUrl =  @"http://120.25.226.186:32812/resources/videos/minion_01.mp4";
    [self setupUI];
    self.videoProgressViewHidden = false;
    
    
}

-(void)viewDidAppear:(BOOL)animated

{
    [super viewDidAppear:animated];
    self.videoPlayerView.frame =  self.videoBackgroundView.bounds;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
-(void)setVideoProgressViewHidden:(BOOL)videoProgressViewHidden
{
    _videoProgressViewHidden  = videoProgressViewHidden;
    
    CGFloat hight = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat menuViewY = videoProgressViewHidden ? hight + 100 :  hight - 50;
    [UIView animateWithDuration:0.5 animations:^{
        self.videoMenuView.frame = CGRectMake(0, menuViewY, width, 50);
    } completion:^(BOOL finished) {
        if (videoProgressViewHidden == false)
        {
            [self performSelector:@selector(hideProgressView) withObject:nil afterDelay:5.0];
        }else
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideProgressView) object:nil];
        }
    }];
}


#pragma mark - UI

-(void)setupUI
{
    CGFloat width = MAX(ScreenWidth, ScreenHeight);
    CGFloat hight = MIN(ScreenWidth, ScreenHeight);
    SKSVideoPlayerView *videoPlayerView = [SKSVideoPlayerView videoPlayerView];
     __weak typeof(self) weakSelf = self;
    [self.videoBackgroundView addSubview:videoPlayerView];
    videoPlayerView.videoUrl = self.currentVideoUrl;
    videoPlayerView.progressChangedOpration = ^(SKSVideoPlayerView *playerView, double progress, double duration) {
        weakSelf.videoMenuView.duaration = duration;
        weakSelf.videoMenuView.currentInterval = duration * progress;
        if (progress >= 1.0)
        {
            [weakSelf.videoMenuView restorePlayStatus];
        }
    };
    self.videoPlayerView = videoPlayerView;
    
    
    
    SKVideoMenuView *videoMenuView = [SKVideoMenuView videoMenuView];[self.view addSubview:videoMenuView];
    videoMenuView.alpha = 0.8;
    videoMenuView.frame = CGRectMake(0, hight + 100, width, 50);
    videoMenuView.playOperationBlock = ^(BOOL isSelected) {
        [weakSelf startPlayingVideo:isSelected];
    };
    videoMenuView.voiceOperationBlock = ^(BOOL isSelected) {
         [weakSelf muteVideo:isSelected];
    };
    self.videoMenuView =  videoMenuView;
    
}
#pragma mark - Action

- (IBAction)tapOnMainView:(UITapGestureRecognizer *)sender {
    
    self.videoProgressViewHidden =  !self.videoProgressViewHidden;
}

-(void)hideProgressView
{
    self.videoProgressViewHidden = true;
}

-(void)startPlayingVideo:(BOOL)shouldPlay
{
    if (shouldPlay)
    {
        self.videoPlayerView.videoUrl = self.currentVideoUrl;
        [self.videoPlayerView play];
    }else
    {
         [self.videoPlayerView pause];
    }
}


-(void)muteVideo:(BOOL)isMuted
{
    [self.videoPlayerView mute:isMuted];
    
}
#pragma mark - System orientation

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
