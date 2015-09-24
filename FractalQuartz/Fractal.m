//
//  Window.m
//  FractalQuartz
//
//  Created by Sam Bender on 9/23/15.
//  Copyright © 2015 Sam Bender. All rights reserved.
//

#import "Fractal.h"

typedef struct DoublePoint
{
    double a;
    double b;
} DoublePoint;

@interface Fractal()
{
    DoublePoint *pointGrid;
    DoublePoint *z0;
    short int *iterationCount;
    WindowEdges windowEdges;
    WindowSize resolution;
}

@end

@implementation Fractal

- (id) initWithWindowEdges:(WindowEdges)_windowEdges outputResolution:(WindowSize)_resolution
{
    self = [super init];
    if (self)
    {
        [self setWindowEdges:_windowEdges outputResolution:_resolution];
        _iterations = 254;
    }
    return self;
}

- (void) setWindowEdges:(WindowEdges)_windowEdges outputResolution:(WindowSize)_resolution
{
    windowEdges = _windowEdges;
    resolution = _resolution;
    
    pointGrid = malloc(sizeof(DoublePoint) * resolution.width * resolution.height);
    z0 = malloc(sizeof(DoublePoint) * resolution.width * resolution.height);
    iterationCount = malloc(sizeof(short int) * resolution.width * resolution.height);
    
    double realIncrement = fabs(windowEdges.right - windowEdges.left) / resolution.width;
    double imaginaryIncrement = fabs(windowEdges.top - windowEdges.bottom) / resolution.height;
    
    double currentRealValue = windowEdges.left;
    double currentImaginaryValue = windowEdges.top;
    
    int pos = 0;
    
    for (int y = 0; y < resolution.height; y++)
    {
        for (int x = 0; x < resolution.width; x++)
        {
            DoublePoint point;
            point.a = currentRealValue;
            point.b = currentImaginaryValue;
            
            DoublePoint z0Point;
            z0Point.a = currentRealValue;
            z0Point.b = currentImaginaryValue;
            
            currentRealValue += realIncrement;
            
            pos = x + y * resolution.width;
            pointGrid[pos] = point;
            z0[pos] = z0Point;
            iterationCount[pos] = 0;
        }
        
        currentRealValue = windowEdges.left;
        currentImaginaryValue -= imaginaryIncrement;
    }
    
    NSAssert(pointGrid[resolution.width].a == windowEdges.left, @"");
    NSAssert(pointGrid[resolution.width-1].a < windowEdges.right + (1.1 * realIncrement)
             && pointGrid[resolution.width-1].a > windowEdges.right - (1.1* realIncrement),
             @"Should be: %f, is: %f", windowEdges.right, pointGrid[resolution.width-1].a);
    
    NSAssert(pointGrid[resolution.width-1].b == windowEdges.top, @"");
    NSAssert(pointGrid[resolution.height * (resolution.width - 1)].b < windowEdges.bottom + (1.1 * imaginaryIncrement)
             && pointGrid[resolution.height * (resolution.width - 1)].b > windowEdges.bottom - (1.1 * imaginaryIncrement),
             @"Should be: %f, is: %f", windowEdges.bottom, pointGrid[resolution.height * (resolution.width - 1)].b);
}



- (void) run
// appears to be displaying correctly
//{
//    double max = 4;
//    double min = 0;
//    
//    for (int y = 0; y < resolution.height; y++)
//    {
//        for (int x = 0; x < resolution.width; x++)
//        {
//            int pos = x + y * resolution.width;
//            DoublePoint currentPoint = pointGrid[pos];
//            DoublePoint newPt;
//            double newVal = sqrt(currentPoint.a * currentPoint.a + currentPoint.b * currentPoint.b);
//            
//            
//            iterationCount[pos] = 1 - newVal * (255 / max);
//        }
//    }
//}
{
    int pos;
    for (int i = 0; i < _iterations; i++)
    {
        for (int y = 0; y < resolution.height; y++)
        {
            for (int x = 0; x < resolution.width; x++)
            {
                pos = x + y * resolution.width;
                DoublePoint currentPoint = pointGrid[pos];
                
#warning Shouldn't this be plus/minus 2?
#warning In js created bool array to see if current point is aready outside
//                if (fabs(currentPoint.a) < 2 && fabs(currentPoint.b) < 2)
                if (currentPoint.a < 2 && currentPoint.b < 2)
                {
                    DoublePoint newPoint;
                    newPoint.a = (currentPoint.a * currentPoint.a)
                    - (currentPoint.b * currentPoint.b)
                    + z0[pos].a;
                    newPoint.b = 2 * currentPoint.b * currentPoint.a
                    + z0[pos].b;
                    
                    pointGrid[pos] = newPoint;
                    iterationCount[pos] += 1;
                    
                    NSAssert(iterationCount[pos] >= 0 && iterationCount[pos] < _iterations + 1, @"");
                }
            }
        }
    }
}

- (RGBColor) rgbAtX:(int)x Y:(int)y
{
    int pos = x + y * resolution.width;
    
    RGBColor color;
    // produces correct linear gradient
//    float v = (float)x / (float)resolution.width;
//    color.red = v * 255;
//    color.green = v * 255;
//    color.blue = v * 255;
    
    // iteration count values are between 0 and 255
    color.red = iterationCount[pos];
    color.green = iterationCount[pos];
    color.blue = iterationCount[pos];
    
    return color;
}

- (void) dealloc
{
    free(pointGrid);
    free(z0);
    free(iterationCount);
}

@end
