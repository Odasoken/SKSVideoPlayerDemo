//
//  SKVideoMenuView.m
//  
//
//  Created by juliano on 4/10/18.
//  Copyright © 2018 Juliano. All rights reserved.
//

#import "SKVideoMenuView.h"
#import "UIView+SKSXibInstance.h"
#import "UIView+SKSExtension.h"
#import "SKSConstant.h"
@interface SKVideoMenuView()

@property (weak, nonatomic) IBOutlet UILabel *currentIntervalLabel;
@property (weak, nonatomic) IBOutlet UILabel *duarationLabel;
@property (weak, nonatomic) IBOutlet UIView *progressBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressViewWidthConstraint;
@property (nonatomic, assign) CGFloat currentProgress;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;


@end

@implementation SKVideoMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - Life CC

+(instancetype)videoMenuView
{
    return [self sks_loadUIViewXibInstance];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.progressBackgroundView.layer.cornerRadius = 5.0;
    self.progressBackgroundView.layer.masksToBounds = true;
    
    
    self.progressView.layer.cornerRadius = 5.0;
    self.progressView.layer.masksToBounds = true;
    
    self.currentProgress = 0.0;
}

#pragma mark - Data

-(void)setDuaration:(NSInteger)duaration
{
    _duaration = duaration;
    NSString *timeStr = SKSTimeStringWithTimeInterval(duaration);
    self.duarationLabel.text = timeStr;
}

-(void)setCurrentInterval:(NSInteger)currentInterval
{
    _currentInterval = currentInterval;
    NSString *timeStr = SKSTimeStringWithTimeInterval(currentInterval);
    self.currentIntervalLabel.text = timeStr;
    if (self.duaration == 0)
    {
        self.currentProgress = 0;
    }else
    {
       self.currentProgress = currentInterval  * 0.1 * 10 / self.duaration;
    }
}


-(void)setCurrentProgress:(CGFloat)currentProgress
{
    _currentProgress = currentProgress;
   
    self.progressViewWidthConstraint.constant = self.progressBackgroundView.width * currentProgress;
    if (currentProgress >= 1.0)
    {
        
    }
   
}

-(void)startAutoPlay
{
    [self play:self.playBtn];
}


-(void)restorePlayStatus
{
    self.playBtn.selected = false;
    self.voiceBtn.selected = false;
}



- (IBAction)play:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.playBtn.selected = btn.selected;
    if (self.playOperationBlock)
    {
        self.playOperationBlock(btn.selected);
    }
}

- (IBAction)voiceOn:(UIButton *)btn
{
    
    btn.selected = !btn.selected;
    self.voiceBtn.selected = btn.selected;
    if (self.voiceOperationBlock)
    {
        self.voiceOperationBlock(btn.selected);
    }
}
@end
