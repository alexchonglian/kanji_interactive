//
//  StrokePanelUIView.m
//  SingleChineseCharacter
//
//  Created by Chong Lian on 1/22/15.
//  Copyright (c) 2015 Chong Lian. All rights reserved.
//

#import "StrokePanelUIView.h"

@interface StrokePanelUIView()
@property (strong, nonatomic) NSArray *strokesInUIBezierPath;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger strokeIndex;
@end




@implementation StrokePanelUIView

#pragma mark - initilization code

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    // initialize page number
    // might save and restore it using userdefault dictionary later
    self.pageNumber = 0;
    
    UISwipeGestureRecognizer *lsgr =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    lsgr.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    UISwipeGestureRecognizer *rsgr =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    rsgr.direction = UISwipeGestureRecognizerDirectionRight;
    

    [self addGestureRecognizer:lsgr];
    [self addGestureRecognizer:rsgr];
    NSLog(@"ok");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

#define MAXVAL 5
#define MINVAL 0

- (void)swipeLeft:(UISwipeGestureRecognizer *)gesture {
    self.pageNumber++;
    NSLog(@"left %d", self.pageNumber);
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gesture {
    self.pageNumber--;
    NSLog(@"right %d", self.pageNumber);
}

#pragma mark - properties
//@synthesize pageNumber = _pageNumber;

- (void)setPageNumber:(NSInteger)pageNumber {
    UIViewAnimationOptions flipDirection = (pageNumber > _pageNumber) ?
    UIViewAnimationOptionTransitionFlipFromRight :
    UIViewAnimationOptionTransitionFlipFromLeft;
    
    _pageNumber = pageNumber;
    
    //self.alpha = 0.0;
    [UIView transitionWithView:self
                      duration:0.3
                       options: flipDirection
                    animations:^{[self setNeedsDisplay];}
                    completion:^(BOOL finished) {}];
    /*
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setNeedsDisplay];
                         self.alpha = 1.0;
                     }];
    */
}



#pragma mark - draw methods

- (void)drawRect:(CGRect)rect {
    NSLog(@"ok");
    if (self.pageNumber == 1) {
        [self draw1];
    } else if (self.pageNumber == 2) {
        [self draw2];
    } else if (self.pageNumber == 3) {
        [self draw3];
    }
}


- (void)draw1 {
    UIColor* color0 = [UIColor blackColor];
    CGFloat c = 2.6;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(59*c, 10.85*c)];
    [bezierPath addCurveToPoint: CGPointMake(57.43*c, 13.93*c) controlPoint1: CGPointMake(58.88*c, 12.12*c) controlPoint2: CGPointMake(58.15*c, 13.21*c)];
    [bezierPath addCurveToPoint: CGPointMake(32.25*c, 30.75*c) controlPoint1: CGPointMake(51.16*c, 20.23*c) controlPoint2: CGPointMake(43.5*c, 25.37*c)];
    bezierPath.miterLimit = 4;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezierPath.lineWidth = 8;
    [bezierPath stroke];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(29.25*c, 31.36*c)];
    [bezier2Path addCurveToPoint: CGPointMake(31.45*c, 35.18*c) controlPoint1: CGPointMake(30.32*c, 32.43*c) controlPoint2: CGPointMake(31.2*c, 33.83*c)];
    [bezier2Path addCurveToPoint: CGPointMake(35.61*c, 61.24*c) controlPoint1: CGPointMake(32.99*c, 43.5*c) controlPoint2: CGPointMake(34.97*c, 56.35*c)];
    bezier2Path.miterLimit = 4;
    bezier2Path.lineCapStyle = kCGLineCapRound;
    bezier2Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier2Path.lineWidth = 8;
    [bezier2Path stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(35.78*c, 38.37*c)];
    [bezier3Path addCurveToPoint: CGPointMake(41.47*c, 38.24*c) controlPoint1: CGPointMake(37.87*c, 38.5*c) controlPoint2: CGPointMake(39.26*c, 38.51*c)];
    [bezier3Path addCurveToPoint: CGPointMake(74.66*c, 32.66*c) controlPoint1: CGPointMake(51.94*c, 36.95*c) controlPoint2: CGPointMake(64.74*c, 34.63*c)];
    [bezier3Path addCurveToPoint: CGPointMake(82.24*c, 32.18*c) controlPoint1: CGPointMake(77.31*c, 32.13*c) controlPoint2: CGPointMake(79.53*c, 31.83*c)];
    bezier3Path.miterLimit = 4;
    bezier3Path.lineCapStyle = kCGLineCapRound;
    bezier3Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier3Path.lineWidth = 8;
    [bezier3Path stroke];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(67.63*c, 38.35*c)];
    [bezier4Path addCurveToPoint: CGPointMake(68.43*c, 42.57*c) controlPoint1: CGPointMake(68.58*c, 39.3*c) controlPoint2: CGPointMake(68.7*c, 40.64*c)];
    [bezier4Path addCurveToPoint: CGPointMake(66.26*c, 58.25*c) controlPoint1: CGPointMake(67.62*c, 48.25*c) controlPoint2: CGPointMake(67.5*c, 50.12*c)];
    bezier4Path.miterLimit = 4;
    bezier4Path.lineCapStyle = kCGLineCapRound;
    bezier4Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier4Path.lineWidth = 8;
    [bezier4Path stroke];
    
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(13.5*c, 63.23*c)];
    [bezier5Path addCurveToPoint: CGPointMake(24.24*c, 63.66*c) controlPoint1: CGPointMake(16.91*c, 64.39*c) controlPoint2: CGPointMake(20.72*c, 64.06*c)];
    [bezier5Path addCurveToPoint: CGPointMake(81.99*c, 58*c) controlPoint1: CGPointMake(37.47*c, 62.14*c) controlPoint2: CGPointMake(63.5*c, 58.5*c)];
    [bezier5Path addCurveToPoint: CGPointMake(94*c, 58.74*c) controlPoint1: CGPointMake(86.03*c, 57.89*c) controlPoint2: CGPointMake(90.07*c, 57.94*c)];
    bezier5Path.miterLimit = 4;
    bezier5Path.lineCapStyle = kCGLineCapRound;
    bezier5Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier5Path.lineWidth = 8;
    [bezier5Path stroke];
    
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint: CGPointMake(52.94*c, 63.44*c)];
    [bezier6Path addCurveToPoint: CGPointMake(54.56*c, 67.89*c) controlPoint1: CGPointMake(54.12*c, 64.62*c) controlPoint2: CGPointMake(54.56*c, 66.25*c)];
    [bezier6Path addCurveToPoint: CGPointMake(54.6*c, 90.38*c) controlPoint1: CGPointMake(54.56*c, 72.62*c) controlPoint2: CGPointMake(54.6*c, 83.12*c)];
    bezier6Path.miterLimit = 4;
    bezier6Path.lineCapStyle = kCGLineCapRound;
    bezier6Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier6Path.lineWidth = 8;
    [bezier6Path stroke];
    
    
    //// Bezier 7 Drawing
    UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
    [bezier7Path moveToPoint: CGPointMake(25.9*c, 76.38*c)];
    [bezier7Path addCurveToPoint: CGPointMake(26.93*c, 79.46*c) controlPoint1: CGPointMake(26.76*c, 77.24*c) controlPoint2: CGPointMake(27*c, 78.5*c)];
    [bezier7Path addCurveToPoint: CGPointMake(25.97*c, 92.59*c) controlPoint1: CGPointMake(26.64*c, 83.51*c) controlPoint2: CGPointMake(26.54*c, 85.11*c)];
    [bezier7Path addCurveToPoint: CGPointMake(27.74*c, 95.35*c) controlPoint1: CGPointMake(25.75*c, 95.5*c) controlPoint2: CGPointMake(26.14*c, 95.64*c)];
    [bezier7Path addCurveToPoint: CGPointMake(82.04*c, 89.07*c) controlPoint1: CGPointMake(41.62*c, 92.87*c) controlPoint2: CGPointMake(66.37*c, 89.37*c)];
    bezier7Path.miterLimit = 4;
    bezier7Path.lineCapStyle = kCGLineCapRound;
    bezier7Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier7Path.lineWidth = 8;
    [bezier7Path stroke];
    
    
    //// Bezier 8 Drawing
    UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
    [bezier8Path moveToPoint: CGPointMake(84.59*c, 70.75*c)];
    [bezier8Path addCurveToPoint: CGPointMake(85.35*c, 74.34*c) controlPoint1: CGPointMake(85.67*c, 71.83*c) controlPoint2: CGPointMake(85.5*c, 73.37*c)];
    [bezier8Path addCurveToPoint: CGPointMake(83.27*c, 87.21*c) controlPoint1: CGPointMake(84.79*c, 78.09*c) controlPoint2: CGPointMake(84.19*c, 82.04*c)];
    [bezier8Path addCurveToPoint: CGPointMake(81.97*c, 94.73*c) controlPoint1: CGPointMake(82.87*c, 89.46*c) controlPoint2: CGPointMake(82.43*c, 91.94*c)];
    bezier8Path.miterLimit = 4;
    bezier8Path.lineCapStyle = kCGLineCapRound;
    bezier8Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier8Path.lineWidth = 8;
    [bezier8Path stroke];
    
    
    

}

- (void)draw2 {
    UIColor* color0 = [UIColor blackColor];
    CGFloat c = 2.6;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(41.88*c, 14.38*c)];
    [bezierPath addCurveToPoint: CGPointMake(43.38*c, 19.5*c) controlPoint1: CGPointMake(42.88*c, 15.76*c) controlPoint2: CGPointMake(43.38*c, 17.63*c)];
    [bezierPath addCurveToPoint: CGPointMake(14.88*c, 88.25*c) controlPoint1: CGPointMake(43.38*c, 59.63*c) controlPoint2: CGPointMake(34.26*c, 77*c)];
    bezierPath.miterLimit = 4;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezierPath.lineWidth = 8;
    [bezierPath stroke];
    
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(13.5*c, 45.75*c)];
    [bezier2Path addCurveToPoint: CGPointMake(22.08*c, 45.09*c) controlPoint1: CGPointMake(16.38*c, 46.6*c) controlPoint2: CGPointMake(19.28*c, 45.8*c)];
    [bezier2Path addCurveToPoint: CGPointMake(63*c, 35.25*c) controlPoint1: CGPointMake(30.55*c, 42.95*c) controlPoint2: CGPointMake(61.96*c, 35.3*c)];
    [bezier2Path addCurveToPoint: CGPointMake(67.25*c, 40*c) controlPoint1: CGPointMake(65.5*c, 35.13*c) controlPoint2: CGPointMake(67.75*c, 35.75*c)];
    [bezier2Path addCurveToPoint: CGPointMake(60.25*c, 72.5*c) controlPoint1: CGPointMake(66.75*c, 44.25*c) controlPoint2: CGPointMake(61.75*c, 60.75*c)];
    [bezier2Path addCurveToPoint: CGPointMake(78.46*c, 91.87*c) controlPoint1: CGPointMake(58.02*c, 89.96*c) controlPoint2: CGPointMake(62.25*c, 91.87*c)];
    [bezier2Path addCurveToPoint: CGPointMake(97.73*c, 81.75*c) controlPoint1: CGPointMake(92.25*c, 91.87*c) controlPoint2: CGPointMake(97.47*c, 90.8*c)];
    bezier2Path.miterLimit = 4;
    bezier2Path.lineCapStyle = kCGLineCapRound;
    bezier2Path.lineJoinStyle = kCGLineJoinRound;
    [color0 setStroke];
    bezier2Path.lineWidth = 8;
    [bezier2Path stroke];
}

- (void)draw3 {
    UIColor* color = [UIColor blackColor];
    CGFloat c = 2.6;
    

    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(53.36*c, 12.25*c)];
    [bezierPath addCurveToPoint: CGPointMake(54.84*c, 16.91*c) controlPoint1: CGPointMake(54.74*c, 13.63*c) controlPoint2: CGPointMake(54.84*c, 15*c)];
    [bezierPath addCurveToPoint: CGPointMake(54.75*c, 32.12*c) controlPoint1: CGPointMake(54.84*c, 21.36*c) controlPoint2: CGPointMake(54.75*c, 28*c)];
    bezierPath.miterLimit = 4;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    bezierPath.lineWidth = 8;
    [bezierPath stroke];
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(18.75*c, 35.36*c)];
    [bezier2Path addCurveToPoint: CGPointMake(28.98*c, 35.64*c) controlPoint1: CGPointMake(21.99*c, 36.32*c) controlPoint2: CGPointMake(25.66*c, 36.01*c)];
    [bezier2Path addCurveToPoint: CGPointMake(84.88*c, 30.9*c) controlPoint1: CGPointMake(44.88*c, 33.88*c) controlPoint2: CGPointMake(70.7*c, 31.59*c)];
    [bezier2Path addCurveToPoint: CGPointMake(95.76*c, 31.66*c) controlPoint1: CGPointMake(88.26*c, 30.73*c) controlPoint2: CGPointMake(92.76*c, 30.63*c)];
    bezier2Path.miterLimit = 4;
    bezier2Path.lineCapStyle = kCGLineCapRound;
    bezier2Path.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    bezier2Path.lineWidth = 8;
    [bezier2Path stroke];
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(45.17*c, 37.53*c)];
    [bezier3Path addCurveToPoint: CGPointMake(46.36*c, 42.17*c) controlPoint1: CGPointMake(46.25*c, 38.61*c) controlPoint2: CGPointMake(46.36*c, 40.16*c)];
    [bezier3Path addCurveToPoint: CGPointMake(26.31*c, 97*c) controlPoint1: CGPointMake(46.36*c, 60.55*c) controlPoint2: CGPointMake(42.5*c, 86*c)];
    bezier3Path.miterLimit = 4;
    bezier3Path.lineCapStyle = kCGLineCapRound;
    bezier3Path.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    bezier3Path.lineWidth = 8;
    [bezier3Path stroke];
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(64.52*c, 35.33*c)];
    [bezier4Path addCurveToPoint: CGPointMake(66.28*c, 40.35*c) controlPoint1: CGPointMake(65.5*c, 36.25*c) controlPoint2: CGPointMake(66.28*c, 37.32*c)];
    [bezier4Path addCurveToPoint: CGPointMake(66.27*c, 89.47*c) controlPoint1: CGPointMake(66.28*c, 58*c) controlPoint2: CGPointMake(66.27*c, 84.51*c)];
    [bezier4Path addCurveToPoint: CGPointMake(59.06*c, 89.97*c) controlPoint1: CGPointMake(66.27*c, 99.86*c) controlPoint2: CGPointMake(60.56*c, 91.22*c)];
    bezier4Path.miterLimit = 4;
    bezier4Path.lineCapStyle = kCGLineCapRound;
    bezier4Path.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    bezier4Path.lineWidth = 8;
    [bezier4Path stroke];
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(30.01*c, 52.89*c)];
    [bezier5Path addCurveToPoint: CGPointMake(29.54*c, 56.71*c) controlPoint1: CGPointMake(30.1*c, 54.17*c) controlPoint2: CGPointMake(30.1*c, 55.5*c)];
    [bezier5Path addCurveToPoint: CGPointMake(14.8*c, 78.22*c) controlPoint1: CGPointMake(26.74*c, 62.82*c) controlPoint2: CGPointMake(21.69*c, 71.07*c)];
    bezier5Path.miterLimit = 4;
    bezier5Path.lineCapStyle = kCGLineCapRound;
    bezier5Path.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    bezier5Path.lineWidth = 8;
    [bezier5Path stroke];
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint: CGPointMake(78.77*c, 54.33*c)];
    [bezier6Path addCurveToPoint: CGPointMake(92.56*c, 75.46*c) controlPoint1: CGPointMake(83.64*c, 58.06*c) controlPoint2: CGPointMake(91.35*c, 69.66*c)];
    bezier6Path.miterLimit = 4;
    bezier6Path.lineCapStyle = kCGLineCapRound;
    bezier6Path.lineJoinStyle = kCGLineJoinRound;
    [color setStroke];
    bezier6Path.lineWidth = 8;
    [bezier6Path stroke];
    
}


@end
