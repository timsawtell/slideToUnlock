//
//  SlideToUnlockView.m
//  SlideToUnlock
//
//  Created by Local Dev User on 13/12/12.
//  Copyright (c) 2012 Speedwell. All rights reserved.
//

#import "SlideToUnlockViewController.h"

@interface SlideToUnlockViewController()
@property (nonatomic, assign) BOOL hasReachedEnd;

- (void)animateIndicator;
@end

CG_INLINE CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180.0f;
}

@implementation SlideToUnlockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider.value = 0;
    self.cancelButton.layer.cornerRadius = 10.0f;
    self.sliderOverlayImageView.layer.cornerRadius = 10.0f;
    self.slider.continuous = YES;
    UIImage *stetchLeftTrack= [[UIImage imageNamed:@"empty"] stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
    UIImage *stetchRightTrack= [[UIImage imageNamed:@"empty"] stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
    UIImage *thumbImage = [UIImage imageNamed:@"sliderImage"];
    // this code to set the slider ball image
    [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];
    [self.slider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    
    [self animateIndicator];
}

- (void)animateIndicator
{
    CGRect indFrame = self.slideIndicatorImageView.frame;
    CGRect origFrame = indFrame;
    [UIView animateWithDuration:3.0f animations:^{
        self.slideIndicatorImageView.frame = CGRectMake(indFrame.origin.x + self.sliderOverlayImageView.frame.size.width - indFrame.size.width,
                                                        indFrame.origin.y, indFrame.size.width, indFrame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.slideIndicatorImageView.frame = origFrame;
            [self animateIndicator];
        }
    }];
}

// for the incremental update
- (IBAction)sliderChanged:(id)sender
{
    UISlider *aSlider = (UISlider *)sender;
    if (aSlider.value >= 1 && !self.hasReachedEnd) {
        [self sliderFinishedChanging:sender];
    }
    CATransform3D rotationTransform = CATransform3DIdentity;
    [self.feedbackImageView.layer removeAllAnimations];
    rotationTransform = CATransform3DRotate(rotationTransform, DegreesToRadians(aSlider.value * 180), 0.0, 0.0, 1);
    self.feedbackImageView.layer.transform = rotationTransform;
    
}

// for either reaching 1.0 or releasing the slider
- (IBAction)sliderFinishedChanging:(id)sender
{
    UISlider *aSlider = (UISlider *)sender;
    CGFloat maxDuration = 0.35f;
    
    if (aSlider.value < 1.0f) {
        CGFloat scaledDuration = aSlider.value * maxDuration;
        
        [UIView animateWithDuration:scaledDuration animations:^{
            aSlider.value = 0.0f;
            CATransform3D rotationTransform = CATransform3DIdentity;
            [self.feedbackImageView.layer removeAllAnimations];
            rotationTransform = CATransform3DRotate(rotationTransform, 0, 0.0, 0.0, 1);
            self.feedbackImageView.layer.transform = rotationTransform;
        }];
        
    } else {
        self.hasReachedEnd = YES;
        aSlider.userInteractionEnabled = NO;
        self.slideToThisImageView.hidden = YES;
        [self.delegate slideToUnlockSuccss];
    }
}

- (IBAction)cancelButtonAction:(id)sender
{
    [self.delegate slideToUnlockCancel];
}

@end
