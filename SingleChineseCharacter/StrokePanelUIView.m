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
@property (nonatomic) NSInteger strokeIndex;
@end


@implementation StrokePanelUIView

//const for generating UIBezierPath for strokes
#define MITERLIMIT      4
#define LINEWIDTH       10
#define SCALE_CONST     2.6
#define LINECAPSTYLE    kCGLineCapRound
#define LINEJOINSTYLE   kCGLineJoinRound


#pragma mark - property

- (void)setStrokesInPrimitive:(NSArray *)strokesInPrimitive {
    _strokesInPrimitive = strokesInPrimitive;
    self.strokesInUIBezierPath = [self transformStrokesToUIBezierPathFrom:strokesInPrimitive];
    //_strokesInPrimitive = nil; // if you are sensitive about memory
    self.strokeIndex = 0;
}

- (NSArray *)transformStrokesToUIBezierPathFrom:(NSArray *)strokesInPrimitive {
    /* when the ViewController set strokesInPrimitive (compressed representation of UIBezierPath of strokes)
     * the StrokePanel UI View automatically transform it to UIBezierPath
     * and store it private @property strokesInUIBezierPath
     * waiting for drawRect to call
     *
     *  compressed repr of strokes          | repr of NSArray of UIBezierPath
     *                                      |
     * strokesInPrimitive                   |   strokesInUIBezierPath
     * = @[ stroke1, stroke2,  ... ]        |   = @[UIBezierPath1, UIBezierPath2 ... ]
     *                                      |
     * stroke = @[ curve1, curve2 ... ]     |   UIBezierPath = @[moveToPoint/cubicCurve/quadCurve/linearCurve ]
     *                                      |
     * curve = @[point, ctrlPt1 ctrlPt2]    |   curve =  moveToPoint:
     *       | @[point, ctrlPt]             |           |addCurveToPoint:controlPoint1:controlPoint2
     *       | @[point]                     |           |addQuadCurveToPoint
     *                                      |           |addLineToPoint:
     * point = @[x, y];                     |
     *                                      |   point = CGMakePoint(x, y)
     */
    NSMutableArray *newStrokesInUIBezierPath = [[NSMutableArray alloc] init];
    
    // iterate all strokes
    for (NSArray *stroke in strokesInPrimitive) {
        
        // construct path for current stroke
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        // add starting point to uibezierpath
        [path moveToPoint: CGPointMake([stroke[0][0][0] floatValue] * SCALE_CONST,
                                       [stroke[0][0][1] floatValue] * SCALE_CONST)];
        
        // add other points to uibezierpath
        for (int i = 1; i < [stroke count]; i++) {
            
            NSArray *strk = stroke[i];
            int len = [strk count];
            
            if (len == 3) { // Cubic Bezier Path with 1 curve point + 2 control points
                [path addCurveToPoint: CGPointMake([strk[0][0] floatValue]*SCALE_CONST,
                                                   [strk[0][1] floatValue]*SCALE_CONST)
                        controlPoint1: CGPointMake([strk[1][0] floatValue]*SCALE_CONST,
                                                   [strk[1][1] floatValue]*SCALE_CONST)
                        controlPoint2: CGPointMake([strk[2][0] floatValue]*SCALE_CONST,
                                                   [strk[2][1] floatValue]*SCALE_CONST)];
            } else if (len == 1) { // Line
                [path addLineToPoint:CGPointMake([strk[0][0] floatValue]*SCALE_CONST,
                                                 [strk[0][1] floatValue]*SCALE_CONST)];
            } else if (len == 2) { // Quadratic curve with one control point
                [path addQuadCurveToPoint:CGPointMake([strk[0][0] floatValue]*SCALE_CONST,
                                                      [strk[0][1] floatValue]*SCALE_CONST)
                             controlPoint:CGPointMake([strk[1][0] floatValue]*SCALE_CONST,
                                                      [strk[1][1] floatValue]*SCALE_CONST)];
            }
            
        }
        // rest of configurations
        path.miterLimit = MITERLIMIT;
        path.lineCapStyle = LINECAPSTYLE;
        path.lineJoinStyle = LINEJOINSTYLE;
        path.lineWidth = LINEWIDTH;
        
        // color is set on the fly
        
        // add to new strokes in
        [newStrokesInUIBezierPath addObject:path];
        
    }
    return newStrokesInUIBezierPath;
}

- (void)setStrokeIndex:(NSInteger)strokeIndex {
    _strokeIndex = strokeIndex;
    [self setNeedsDisplay];
}

#pragma mark - initilization code

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    // initialize page number
    // might save and restore it using userdefault dictionary later
    // self.strokesInPrimitive = [self thirdChar];//will trigger transformStrokesToUIBezierPathFrom:
    
    UIPanGestureRecognizer *pangr =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];

    [self addGestureRecognizer:pangr];
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

- (void)panning:(UISwipeGestureRecognizer *)gesture {
    CGPoint loc = [gesture locationInView:self];
    if (gesture.state == UIGestureRecognizerStateChanged) {
        int onit = [self.strokesInUIBezierPath[self.strokeIndex] containsPoint:loc] ? 1 : 0;
        NSLog(@"yes or no %d", onit);
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"position %f %f", loc.x, loc.y);
        self.strokeIndex++;
        [self setNeedsDisplay];
    }
}



#pragma mark - draw methods

- (void)drawRect:(CGRect)rect {
    
    for (UIBezierPath *strokePath in self.strokesInUIBezierPath) {
        [[UIColor blackColor] setStroke];
        [strokePath stroke];
    }
    [[UIColor blackColor] setStroke];
    int idxForNextStroke = self.strokeIndex;
    for (int i = 0; i < [self.strokesInUIBezierPath count]; i++) {
        if (i == idxForNextStroke) {
            [[UIColor redColor] setStroke];
            [self.strokesInUIBezierPath[i] stroke];
            [[UIColor grayColor] setStroke];
        } else {
            [self.strokesInUIBezierPath[i] stroke];
        }
    }
    
    NSLog(@"draw");
}




@end
