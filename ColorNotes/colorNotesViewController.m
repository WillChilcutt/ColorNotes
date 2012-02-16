//
//  colorNotesViewController.m
//  ColorNotes
//
//  Created by David Tarnoff on 2/11/12.
//  Copyright (c) 2012 Intermation. All rights reserved.
//

#import "colorNotesViewController.h"
#import "CustomView.h"

#define NEWFRAME_X_POS 10
#define NEWFRAME_Y_POS 10
#define NEWFRAME_WIDTH 140
#define NEWFRAME_HEIGHT 100

@implementation colorNotesViewController
@synthesize customViewContainer = _customViewContainer;

-(IBAction)processPinch:(UIPinchGestureRecognizer *)sender
{
   CustomView *topView = self.customViewContainer.subviews.lastObject;
    
    if ([topView isMemberOfClass:[CustomView class]]) 
    {
        topView.transform = CGAffineTransformScale(topView.transform, sender.scale, sender.scale);
        [sender setScale:1.0];
        [topView.textContent setNeedsDisplay];
    }
    
}

-(IBAction)processRotation:(UIRotationGestureRecognizer *)sender
{
    CustomView *topView = self.customViewContainer.subviews.lastObject;
    
    if ([topView isMemberOfClass:[CustomView class]]) 
    {
        topView.transform = CGAffineTransformRotate(topView.transform, sender.rotation);
        [sender setRotation:0.0];
        [topView.textContent setNeedsDisplay];
    }
}

-(IBAction)processTap:(UITapGestureRecognizer *)sender
{
    CustomView *topView = self.customViewContainer.subviews.lastObject;
    if ([topView isMemberOfClass:[CustomView class]]) 
    {
        if ([topView.textContent isFirstResponder]) 
        {
            [topView.textContent resignFirstResponder];
        }
    }
}

- (IBAction)newViewRequested:(id)sender 
{
    CGRect newViewRectangle = CGRectMake(NEWFRAME_X_POS, NEWFRAME_Y_POS, NEWFRAME_WIDTH, NEWFRAME_HEIGHT);
    CustomView *newView = [[CustomView alloc] initWithFrame:newViewRectangle];
    [self.customViewContainer addSubview:newView];
}

- (IBAction)newColorRequested:(id)sender 
{
    [self.customViewContainer.subviews.lastObject randomizeBackgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(processRotation:)];
    [self.view addGestureRecognizer:rotationRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(processPinch:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTap:)];
    [self.customViewContainer addGestureRecognizer:tapRecognizer];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCustomViewContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
