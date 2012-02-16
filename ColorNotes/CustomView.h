//
//  CustomView.h
//  ColorNotes
//
//  Created by David Tarnoff on 2/11/12.
//  Copyright (c) 2012 Intermation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    UITextView *textContent;
}

@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat green;
@property (nonatomic) CGFloat blue;
@property (strong, nonatomic) UITextView *textContent;

-(void)randomizeBackgroundColor;

-(IBAction)processPan:(UIPanGestureRecognizer *)sender;
-(IBAction)processLongPress:(UILongPressGestureRecognizer *)sender;

@end
