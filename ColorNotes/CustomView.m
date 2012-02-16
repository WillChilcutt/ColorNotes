//
//  CustomView.m
//  ColorNotes
//
//  Created by David Tarnoff on 2/11/12.
//  Copyright (c) 2012 Intermation. All rights reserved.
//

#import "CustomView.h"

#define LEFTPADDING 10
#define RIGHTPADDING 10
#define TOPPADDING 10
#define BOTTOMPADDING 0

@implementation CustomView

@synthesize red = _red;
@synthesize green = _green;
@synthesize blue = _blue;
@synthesize textContent = _textContent;

-(IBAction)processLongPress:(UILongPressGestureRecognizer *)sender
{
    [self.superview bringSubviewToFront:self];
    CGRect currentBounds = self.bounds;
    self.textContent = [[UITextView alloc] initWithFrame:currentBounds];
    [self.textContent setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
    
    [self addSubview:self.textContent];
    [self.textContent becomeFirstResponder];
    
}

-(IBAction)processPan:(UIPanGestureRecognizer *)sender
{   
    if (sender.state == UIGestureRecognizerStateBegan) 
    {
        self.alpha = 0.5;
        [self.superview bringSubviewToFront:self];
    }
    else if(sender.state == UIGestureRecognizerStateEnded)
    {
        self.alpha = 1.0;
        CGPoint viewCenter = self.center; 
        CGSize viewSize = self.frame.size;  // We're using frame here because we eventually hope to rotate this view meaning bounds wouldn't help us to know how wide the actual placement of the view is.
        BOOL viewAdjustedForFrame = NO;
        if (viewCenter.x < (0.5 * viewSize.width + LEFTPADDING)) 
        {
            viewCenter.x = 0.5 * viewSize.width + LEFTPADDING;
            viewAdjustedForFrame = YES;
        }
        else if (viewCenter.x > (self.superview.bounds.size.width - (0.5 * viewSize.width + RIGHTPADDING)))
        {
            viewCenter.x = (self.superview.bounds.size.width - (0.5 * viewSize.width + RIGHTPADDING));
            viewAdjustedForFrame = YES;
        }
        if (viewCenter.y < (0.5 * viewSize.height + TOPPADDING))
        {
            viewCenter.y = (0.5 * viewSize.height + TOPPADDING);
            viewAdjustedForFrame = YES;
        }
        else if (viewCenter.y > (self.superview.bounds.size.height - (0.5 * viewSize.height + BOTTOMPADDING)))
        {
            viewCenter.y = (self.superview.bounds.size.height - (0.5 * viewSize.height + BOTTOMPADDING));
            viewAdjustedForFrame = YES;
        }
        if (viewAdjustedForFrame) 
        {
            [self setCenter:viewCenter];
        }
    }
    else if(sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [sender translationInView:self.superview];
        CGPoint newCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
        [self setCenter:newCenter];
        [sender setTranslation:CGPointMake(0, 0) inView:self.superview];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self randomizeBackgroundColor];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(processPan:)];
        [self addGestureRecognizer:panRecognizer];
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(processLongPress:)];
        [self addGestureRecognizer:longPressRecognizer];
    }
    return self;
}

-(void)randomizeBackgroundColor
{
    self.red = (CGFloat)(arc4random() % 256)/255;
    self.green = (CGFloat)(arc4random() % 256)/255;
    self.blue = (CGFloat)(arc4random() % 256)/255;
    UIColor *newBackgroundColor = [[UIColor alloc] initWithRed:self.red green:self.green blue:self.blue alpha:1.0];
    self.backgroundColor = newBackgroundColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect
{
    NSLog(@"called");
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.5;
    [self.superview bringSubviewToFront:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0;
    CGPoint viewCenter = self.center; 
    CGSize viewSize = self.frame.size;  // We're using frame here because we eventually hope to rotate this view meaning bounds wouldn't help us to know how wide the actual placement of the view is.
    BOOL viewAdjustedForFrame = NO;
    if (viewCenter.x < (0.5 * viewSize.width + LEFTPADDING)) 
    {
        viewCenter.x = 0.5 * viewSize.width + LEFTPADDING;
        viewAdjustedForFrame = YES;
    }
    else if (viewCenter.x > (self.superview.bounds.size.width - (0.5 * viewSize.width + RIGHTPADDING)))
    {
        viewCenter.x = (self.superview.bounds.size.width - (0.5 * viewSize.width + RIGHTPADDING));
        viewAdjustedForFrame = YES;
    }
    if (viewCenter.y < (0.5 * viewSize.height + TOPPADDING))
    {
        viewCenter.y = (0.5 * viewSize.height + TOPPADDING);
        viewAdjustedForFrame = YES;
    }
    else if (viewCenter.y > (self.superview.bounds.size.height - (0.5 * viewSize.height + BOTTOMPADDING)))
    {
        viewCenter.y = (self.superview.bounds.size.height - (0.5 * viewSize.height + BOTTOMPADDING));
        viewAdjustedForFrame = YES;
    }
    if (viewAdjustedForFrame) 
    {
        [self setCenter:viewCenter];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchInfo = [touches anyObject];
    if(touchInfo.view == self)
    {
        CGPoint touchStart = [touchInfo previousLocationInView:self];
        CGPoint touchEnd = [touchInfo locationInView:self];
        CGFloat xDifference = touchEnd.x - touchStart.x;
        CGFloat yDifference = touchEnd.y - touchStart.y;
        CGPoint newCenter = CGPointMake(self.center.x + xDifference, self.center.y + yDifference);
        [self setCenter:newCenter];
    }
}

*/
@end
