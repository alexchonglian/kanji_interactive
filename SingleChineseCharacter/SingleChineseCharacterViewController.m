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
@property (nonatomic) int lenChars;
@property (nonatomic) int indexOfChar;
@end

@implementation SingleChineseCharacterViewController


#pragma mark - property

@synthesize chars = _chars;
@synthesize indexOfChar = _indexOfChar;

- (NSArray *)chars {
    if (!_chars) {
        _chars = @[
                   @[@[@[@[@18.38,@18.25]],@[@[@27.75,@26.09],@[@21.69,@19.63],@[@26.92,@23.94]]],@[@[@[@12.12,@39.25]],@[@[@22.24,@48.25],@[@15.69,@40.84],@[@21.35,@45.78]]],@[@[@[@12.75,@88.84]],@[@[@16.33,@87.83],@[@14.11,@89.49],@[@15.51,@89.22]],@[@[@25.13,@69.75],@[@19.35,@82.66],@[@22.38,@76.34]]],@[@[@[@58.75,@12.75]],@[@[@60.05,@16.12],@[@59.63,@13.63],@[@60.05,@15.13]],@[@[@59.95,@23.17],@[@60.05,@19.18],@[@59.95,@20.5]]],@[@[@[@35.94,@26.03]],@[@[@43.26,@26.06],@[@38.52,@26.22],@[@40.66,@26.36]],@[@[@82,@22.02],@[@52.53,@25],@[@71.91,@22.61]],@[@[@88.56,@22.38],@[@84.16,@21.89],@[@86.49,@21.6]]],@[@[@[@55.69,@28.5]],@[@[@55.39,@31.4],@[@56,@29.38],@[@55.97,@30.56]],@[@[@44.76,@45.5],@[@52.63,@35.38],@[@49.51,@39.75]],@[@[@46.51,@48.5],@[@41.93,@48.93],@[@43,@49.4]],@[@[@78.26,@41.25],@[@56.76,@45.88],@[@66.76,@43.75]]],@[@[@[@70.16,@32.1]],@[@[@82.96,@47.72],@[@74.68,@34.86],@[@81.83,@43.43]]],@[@[@[@44.76,@56.89]],@[@[@45.68,@60.08],@[@45.56,@57.69],@[@45.75,@58.84]],@[@[@31.81,@92.97],@[@44.75,@76.37],@[@42.12,@85.62]]],@[@[@[@57.77,@53.87]],@[@[@59.28,@57.89],@[@58.7,@54.8],@[@59.28,@56.13]],@[@[@59.27,@85.39],@[@59.28,@68.69],@[@59.28,@78.73]],@[@[@59.27,@91.01],@[@59.27,@87.71],@[@59.27,@89.62]]],@[@[@[@72.85,@50.62]],@[@[@74.47,@54.8],@[@73.87,@51.64],@[@74.47,@53.25]],@[@[@74.44,@78.5],@[@74.47,@62.99],@[@74.44,@72.94]],@[@[@84.11,@90.03],@[@74.44,@88.5],@[@75.25,@90.03]],@[@[@96,@81.4],@[@94.62,@90.03],@[@96,@88.75]]]],
                   @[@[@[@[@51.36,@12.25]],@[@[@58.75,@28.12],@[@58.84,@17.36],@[@58.75,@24]]],@[@[@[@18.75,@35.36]],@[@[@28.98,@35.64],@[@21.99,@36.32],@[@25.66,@36.01]],@[@[@84.88,@30.9],@[@44.88,@33.88],@[@70.7,@31.59]],@[@[@95.76,@31.66],@[@88.26,@30.73],@[@92.76,@30.63]]],@[@[@[@45.17,@37.53]],@[@[@46.36,@42.17],@[@46.25,@38.61],@[@46.36,@40.16]],@[@[@26.31,@97],@[@46.36,@60.55],@[@42.5,@86]]],@[@[@[@64.52,@35.33]],@[@[@66.28,@40.35],@[@65.5,@36.25],@[@66.28,@37.32]],@[@[@66.27,@89.47],@[@66.28,@58],@[@66.27,@84.51]],@[@[@59.06,@89.97],@[@66.27,@99.86],@[@60.56,@91.22]]],@[@[@[@30.01,@52.89]],@[@[@29.54,@56.71],@[@30.1,@54.17],@[@30.1,@55.5]],@[@[@14.8,@78.22],@[@26.74,@62.82],@[@21.69,@71.07]]],@[@[@[@78.77,@54.33]],@[@[@92.56,@75.46],@[@83.64,@58.06],@[@91.35,@69.66]]]],
                   @[@[@[@[@59,@10.85]],@[@[@57.43,@13.93],@[@58.88,@12.12],@[@58.15,@13.21]],@[@[@32.25,@30.75],@[@51.16,@20.23],@[@43.5,@25.37]]],@[@[@[@29.25,@31.36]],@[@[@31.45,@35.18],@[@30.32,@32.43],@[@31.2,@33.83]],@[@[@35.61,@61.24],@[@32.99,@43.5],@[@34.97,@56.35]]],@[@[@[@35.78,@38.37]],@[@[@41.47,@38.24],@[@37.87,@38.5],@[@39.26,@38.51]],@[@[@74.66,@32.66],@[@51.94,@36.95],@[@64.74,@34.63]],@[@[@82.24,@32.18],@[@77.31,@32.13],@[@79.53,@31.83]]],@[@[@[@67.63,@38.35]],@[@[@68.43,@42.57],@[@68.58,@39.3],@[@68.7,@40.64]],@[@[@66.26,@58.25],@[@67.62,@48.25],@[@67.5,@50.12]]],@[@[@[@13.5,@63.23]],@[@[@24.24,@63.66],@[@16.91,@64.39],@[@20.72,@64.06]],@[@[@81.99,@58],@[@37.47,@62.14],@[@63.5,@58.5]],@[@[@94,@58.74],@[@86.03,@57.89],@[@90.07,@57.94]]],@[@[@[@52.94,@63.44]],@[@[@54.56,@67.89],@[@54.12,@64.62],@[@54.56,@66.25]],@[@[@54.6,@90.38],@[@54.56,@72.62],@[@54.6,@83.12]]],@[@[@[@25.9,@76.38]],@[@[@26.93,@79.46],@[@26.76,@77.24],@[@27,@78.5]],@[@[@25.97,@92.59],@[@26.64,@83.51],@[@26.54,@85.11]],@[@[@27.74,@95.35],@[@25.75,@95.5],@[@26.14,@95.64]],@[@[@82.04,@89.07],@[@41.62,@92.87],@[@66.37,@89.37]]],@[@[@[@84.59,@70.75]],@[@[@85.35,@74.34],@[@85.67,@71.83],@[@85.5,@73.37]],@[@[@83.27,@87.21],@[@84.79,@78.09],@[@84.19,@82.04]],@[@[@81.97,@94.73],@[@82.87,@89.46],@[@82.43,@91.94]]]],
                   @[@[@[@[@41.88,@14.38]],@[@[@43.38,@19.5],@[@42.88,@15.76],@[@43.38,@17.63]],@[@[@14.88,@88.25],@[@42.38,@59.63],@[@34.26,@77]]],@[@[@[@13.5,@45.75]],@[@[@22.08,@45.09],@[@16.38,@46.6],@[@19.28,@45.8]],@[@[@63,@35.25],@[@30.55,@42.95],@[@61.96,@35.3]],@[@[@67.25,@40],@[@65.5,@35.13],@[@67.75,@35.75]],@[@[@60.25,@72.5],@[@66.75,@44.25],@[@61.75,@60.75]],@[@[@78.46,@91.87],@[@58.02,@89.96],@[@62.25,@91.87]],@[@[@97.73,@81.75],@[@92.25,@91.87],@[@97.47,@90.8]]]],
                   @[@[@[@[@13.25,@22.5]],@[@[@20.99,@23.25],@[@14.19,@22.73],@[@18.43,@23.46]],@[@[@87.37,@18.5],@[@38.86,@21.75],@[@67.53,@18.5]],@[@[@95.25,@19.75],@[@90.29,@18.5],@[@93.79,@19.25]]],@[@[@[@52.97,@23.25]],@[@[@54.53,@28.55],@[@53.9,@24.32],@[@54.53,@26]],@[@[@54.26,@85.75],@[@54.53,@37.2],@[@54.33,@67.97]],@[@[@54.24,@94],@[@54.24,@89.61],@[@54.24,@91.64]]],@[@[@[@67.83,@40.17]],@[@[@82,@55.12],@[@72.75,@42.5],@[@79.88,@50.62]]]],
                   @[@[@[@[@52.31,@15.88]],@[@[@54.32,@21],@[@53.46,@17.03],@[@54.32,@19]],@[@[@54.07,@85.63],@[@54.32,@21.82],@[@54.1,@84.62]]],@[@[@[@58,@44.75]],@[@[@75.75,@41.75],@[@65,@44.13],@[@72.25,@42.25]],@[@[@80.5,@41.75],@[@77.13,@41.55],@[@79.25,@41.37]]],@[@[@[@13.38,@88.28]],@[@[@24.51,@88.62],@[@16.98,@89.43],@[@20.83,@88.9]],@[@[@84.75,@85.7],@[@40.74,@87.39],@[@65.67,@85.96]],@[@[@95.75,@86.52],@[@88.4,@85.65],@[@92.22,@85.38]]]]
                   ];
    }
    return _chars;
}

- (void)setChars:(NSArray *)chars {
    // also update length of chars
    // might be a problem if dataset if huge
    // we might use data source instead of keeping all the data in ViewController
    _chars = chars;
}

- (int)indexOfChar {
    if (!_indexOfChar) _indexOfChar = 0;
    return _indexOfChar;
}

- (void)setIndexOfChar:(int)indexOfChar {
    if (indexOfChar >= 0 && indexOfChar < self.lenChars) {
        _indexOfChar = indexOfChar;
    }
}

- (int)lenChars {

    if (!_lenChars) {
        _lenChars = [self.chars count];
    }
    //NSLog(@"callled %d", _lenChars);
    return _lenChars;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.StrokePanelView.strokesInPrimitive = self.chars[self.indexOfChar];
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
    int idx = self.indexOfChar;
    self.indexOfChar++;
    if (idx < self.lenChars-1) {
        NSLog(@"self.indexOfChar: %d",self.indexOfChar);
        [UIView transitionWithView:self.StrokePanelView
                          duration:0.3
                           options: UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            self.StrokePanelView.strokesInPrimitive = self.chars[self.indexOfChar];
                            [self.StrokePanelView setNeedsDisplay];}
                        completion:^(BOOL finished) {}];
    }
}

- (IBAction)showPreviousChar:(id)sender {
    int idx = self.indexOfChar;
    self.indexOfChar--;
    if (idx > 0) {
        NSLog(@"self.indexOfChar: %d",self.indexOfChar);
        [UIView transitionWithView:self.StrokePanelView
                          duration:0.3
                           options: UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            self.StrokePanelView.strokesInPrimitive = self.chars[self.indexOfChar];
                            [self.StrokePanelView setNeedsDisplay];}
                        completion:^(BOOL finished) {}];
    }
}



@end
