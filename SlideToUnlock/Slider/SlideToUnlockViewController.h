//
//  SlideToUnlockView.h
//  SlideToUnlock
//
//  Created by Local Dev User on 13/12/12.
//  Copyright (c) 2012 Speedwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideToUnlockDelegate <NSObject>

@required
- (void)slideToUnlockSuccss;
- (void)slideToUnlockCancel;

@end

@interface SlideToUnlockViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *feedbackImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sliderOverlayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *slideToThisImageView;
@property (weak, nonatomic) IBOutlet UIImageView *slideIndicatorImageView;
@property (assign, nonatomic) id<SlideToUnlockDelegate> delegate;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)sliderFinishedChanging:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;

@end
