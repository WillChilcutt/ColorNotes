//
//  colorNotesViewController.h
//  ColorNotes
//
//  Created by David Tarnoff on 2/11/12.
//  Copyright (c) 2012 Intermation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface colorNotesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *customViewContainer;

-(IBAction)processPinch:(UIPinchGestureRecognizer *)sender;
-(IBAction)processRotation:(UIRotationGestureRecognizer *)sender;
-(IBAction)processTap:(UITapGestureRecognizer *)sender;

@end
