//
//  SingleChineseCharacterViewController.m
//  SingleChineseCharacter
//
//  Created by Chong Lian on 1/22/15.
//  Copyright (c) 2015 Chong Lian. All rights reserved.
//

#import "SingleChineseCharacterViewController.h"
#import "StrokePanelUIView.h"

@interface SingleChineseCharacterViewController ()
@property (weak, nonatomic) IBOutlet StrokePanelUIView *StrokePanelView;

@end

@implementation SingleChineseCharacterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchChanged:(UISwitch *)sender {
    BOOL isOn = sender.isOn;
    if (isOn) {
        NSLog(@"on");
    } else {
        NSLog(@"off");
    }
}

- (IBAction)showNextChar:(id)sender {
}

- (IBAction)showPreviousChar:(id)sender {
}

- (void)panelFlipUp:(UISwipeGestureRecognizer *)gtr {

}

- (void)panelFlipDown:(UISwipeGestureRecognizer *)gtr {
    
}

- (void)panelFlipLeft:(UISwipeGestureRecognizer *)gtr {
    
}

- (void)panelFlipRight:(UISwipeGestureRecognizer *)gtr {
    
}

@end
