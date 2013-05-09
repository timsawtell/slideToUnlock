//
//  ViewController.m
//  SlideToUnlock
//
//  Created by Local Dev User on 13/12/12.
//  Copyright (c) 2012 Speedwell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) SlideToUnlockViewController *sliderViewController;
@end

@implementation ViewController

- (IBAction)showButtonAction:(id)sender
{
    self.sliderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"slideToUnlockVC"];
    self.sliderViewController.delegate = self;
    [self addChildViewController:self.sliderViewController];
    [self.sliderViewController didMoveToParentViewController:self];
    [self.view addSubview:self.sliderViewController.view];
    // center the view on screen
    self.sliderViewController.view.frame = CGRectMake(self.view.frame.size.width * 0.5 - self.sliderViewController.view.frame.size.width *0.5,
                                                 self.view.frame.size.height * 0.5 - self.sliderViewController.view.frame.size.height *0.5,
                                                 self.sliderViewController.view.frame.size.width,
                                                 self.sliderViewController.view.frame.size.height);
}

- (void)slideToUnlockCancel
{
    [self.sliderViewController.view removeFromSuperview];
    [self.sliderViewController removeFromParentViewController];
}

- (void)slideToUnlockSuccss
{
    [UIView animateWithDuration:2.0f animations:^{
        self.sliderViewController.view.alpha = 0;
    } completion:^(BOOL finished) {        
        [self.sliderViewController.view removeFromSuperview];
        [self.sliderViewController removeFromParentViewController];
    }];
    
}

@end
