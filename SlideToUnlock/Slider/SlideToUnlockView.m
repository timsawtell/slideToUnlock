//
//  SlideToUnlockView.m
//  SlideToUnlock
//
//  Created by Local Dev User on 20/12/12.
//  Copyright (c) 2012 Speedwell. All rights reserved.
//

#import "SlideToUnlockView.h"

@implementation SlideToUnlockView

NSString * const fontName = @"Gill Sans";
const CGFloat fontSize = 38.0f;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    
    CGSize size = self.sliderOverlayImageView.frame.size;
    UIImage *sourceImage = self.sliderOverlayImageView.image;
    NSString *textString = @"S L I D E";
    const char *text = [textString cStringUsingEncoding:NSUTF8StringEncoding];
    CGSize sizeOfText = [textString sizeWithFont:font constrainedToSize:CGSizeMake(HUGE_VALF, self.sliderOverlayImageView.frame.size.height * 0.75) lineBreakMode:NSLineBreakByWordWrapping];
    NSUInteger len = [textString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *data = [NSMutableData dataWithLength:size.width*size.height*1];
    CGContextRef context = CGBitmapContextCreate([data mutableBytes], size.width, size.height, 8, size.width, NULL, kCGImageAlphaOnly);
    
    CGContextSelectFont(context, [fontName cStringUsingEncoding:NSUTF8StringEncoding], fontSize, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextFillRect(context, self.sliderOverlayImageView.bounds);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat desiredXOffset = (self.sliderOverlayImageView.frame.size.width * 0.5) - (sizeOfText.width * 0.5);
    CGFloat desiredYOffset = fontSize * 0.5;
    CGContextShowTextAtPoint(context, desiredXOffset, desiredYOffset, text, len);
    
    CGImageRef textImage = CGBitmapContextCreateImage(context);
    CGImageRef newImage = CGImageCreateWithMask(sourceImage.CGImage, textImage);
    
    UIImage *finalImage = [UIImage imageWithCGImage:newImage];
    
    CGContextRelease(context);
    CFRelease(newImage);
    CFRelease(textImage);
    
    self.sliderOverlayImageView.image = finalImage;
}


@end
