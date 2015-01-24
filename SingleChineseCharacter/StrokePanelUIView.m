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

#pragma mark - initilization code

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    // initialize page number
    // might save and restore it using userdefault dictionary later
    self.pageNumber = 0;
    self.strokesInPrimitive = [self thirdChar];//will trigger transformStrokesToUIBezierPathFrom:
    
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
    //self.pageNumber++;
    NSLog(@"left %d", self.pageNumber);
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gesture {
    //self.pageNumber--;
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
    
    for (UIBezierPath *strokePath in self.strokesInUIBezierPath) {
        [[UIColor blackColor] setStroke];
        [strokePath stroke];
    }
    
    NSLog(@"draw");
}




- (NSArray *)thirdChar{
    return
    @[
      @[
          @[@[@53.36,@12.25]],
          @[@[@56.75,@32.12],@[@56.84,@21.36],@[@56.75,@28]]
          ],
      @[
          @[@[@18.75,@35.36]],
          @[@[@28.98,@35.64],@[@21.99,@36.32],@[@25.66,@36.01]],
          @[@[@84.88,@30.9],@[@44.88,@33.88],@[@70.7,@31.59]],
          @[@[@95.76,@31.66],@[@88.26,@30.73],@[@92.76,@30.63]]
          ],
      @[
          @[@[@45.17,@37.53]],
          @[@[@46.36,@42.17],@[@46.25,@38.61],@[@46.36,@40.16]],
          @[@[@26.31,@97],@[@46.36,@60.55],@[@42.5,@86]]
          ],
      @[
          @[@[@64.52,@35.33]],
          @[@[@66.28,@40.35],@[@65.5,@36.25],@[@66.28,@37.32]],
          @[@[@66.27,@89.47],@[@66.28,@58],@[@66.27,@84.51]],
          @[@[@59.06,@89.97],@[@66.27,@99.86],@[@60.56,@91.22]]
          ],
      @[
          @[@[@30.01,@52.89]],
          @[@[@29.54,@56.71],@[@30.1,@54.17],@[@30.1,@55.5]],
          @[@[@14.8,@78.22],@[@26.74,@62.82],@[@21.69,@71.07]]
          ],
      @[
          @[@[@78.77,@54.33]],
          @[@[@92.56,@75.46],@[@83.64,@58.06],@[@91.35,@69.66]]
       ]
      ];
}

- (NSArray *)secondChar{
    return
    @[//first stroke
      @[
          @[  @[@41.88, @14.38]],
          @[  @[@43.38, @19.5],   @[@42.88, @15.76],  @[@43.38, @17.63]],
          @[  @[@14.88, @88.25],  @[@42.38, @59.63],  @[@34.26, @77]]
          ],
      //second stroke
      @[
          @[  @[@13.5, @45.75]],
          @[  @[@22.08, @45.09],   @[@16.38, @46.6],  @[@19.28, @45.8]],
          @[  @[@63, @35.25],  @[@30.55, @42.95],  @[@61.96, @35.3]],
          @[  @[@67.25, @40],  @[@65.5, @35.13],  @[@67.75, @35.75]],
          @[  @[@60.25, @72.5],  @[@66.75, @44.25],  @[@61.75, @60.75]],
          @[  @[@78.46, @91.87],  @[@58.02, @89.96],  @[@62.25, @91.87]],
          @[  @[@97.73, @81.75],  @[@92.25, @91.87 ],  @[@97.47, @90.8]]
          ]
      ];
}

- (NSArray *)firstChar{
    return
    @[
      
      @[
          @[@[@59,@10.85]],
          @[@[@57.43,@13.93],@[@58.88,@12.12],@[@58.15,@13.21]],
          @[@[@32.25,@30.75],@[@51.16,@20.23],@[@43.5,@25.37]]
          ],
      
      @[
          @[@[@29.25, @31.36]],
          @[@[@31.45, @35.18 ], @[@30.32, @32.43 ], @[@31.2, @33.83]],
          @[@[@35.61, @61.24], @[@32.99, @43.5], @[@34.97, @56.35]]
          ],
      
      @[
          @[@[@35.78,@38.37]],
          @[@[@41.47,@38.24],@[@37.87,@38.5],@[@39.26,@38.51]],
          @[@[@74.66,@32.66],@[@51.94,@36.95],@[@64.74,@34.63]],
          @[@[@82.24,@32.18],@[@77.31,@32.13],@[@79.53,@31.83]]
          ],
      
      @[
          @[@[@67.63,@38.35]],
          @[@[@68.43,@42.57],@[@68.58,@39.3],@[@68.7,@40.64]],
          @[@[@66.26,@58.25],@[@67.62,@48.25],@[@67.5,@50.12]]
          ],
      
      @[
          @[@[@13.5,@63.23]],
          @[@[@24.24,@63.66],@[@16.91,@64.39],@[@20.72,@64.06]],
          @[@[@81.99,@58],@[@37.47,@62.14],@[@63.5,@58.5]],
          @[@[@94,@58.74],@[@86.03,@57.89],@[@90.07,@57.94]]
          ],
      
      @[
          @[@[@52.94,@63.44]],
          @[@[@54.56,@67.89],@[@54.12,@64.62],@[@54.56,@66.25]],
          @[@[@54.6,@90.38],@[@54.56,@72.62],@[@54.6,@83.12]]
          ],
      
      @[
          @[@[@25.9,@76.38]],
          @[@[@26.93,@79.46],@[@26.76,@77.24],@[@27,@78.5]],
          @[@[@25.97,@92.59],@[@26.64,@83.51],@[@26.54,@85.11]],
          @[@[@27.74,@95.35],@[@25.75,@95.5],@[@26.14,@95.64]],
          @[@[@82.04,@89.07],@[@41.62,@92.87],@[@66.37,@89.37]]
          ],
      
      @[
          @[@[@84.59,@70.75]],
          @[@[@85.35,@74.34],@[@85.67,@71.83],@[@85.5,@73.37]],
          @[@[@83.27,@87.21],@[@84.79,@78.09],@[@84.19,@82.04]],
          @[@[@81.97,@94.73],@[@82.87,@89.46],@[@82.43,@91.94]]
          ]
      ];
}



@end
