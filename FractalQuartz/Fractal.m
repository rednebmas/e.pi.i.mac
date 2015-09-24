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
    
    int pos;
    
    for (int i = 0; i < resolution.height; i++) {
        for (int j = 0; j < resolution.width; j++)
        {
            DoublePoint point;
            point.a = currentRealValue;
            point.b = currentImaginaryValue;
            
            currentRealValue += realIncrement;
            
            pos = i * resolution.width + j;
            pointGrid[pos] = point;
            z0[pos] = point;
        }
        
        currentRealValue = windowEdges.left;
        currentImaginaryValue -= imaginaryIncrement;
    }
}

- (void) run
{
    int pos;
    for (int x = 0; x < _iterations; x++)
    {
        for (int i = 0; i < resolution.height; i++)
        {
            for (int j = 0; j < resolution.width; j++)
            {
                pos = i * resolution.width + j;
                DoublePoint currentPoint = pointGrid[pos];
                
#warning Shouldn't this be plus/minus 2?
#warning In js created bool array to see if current point is aready outside
//                if (fabs(currentPoint.a) < 2 && fabs(currentPoint.b) < 2)
                if (currentPoint.a < 2 && currentPoint.b < 2)
                {
                    currentPoint.a = (currentPoint.a * currentPoint.a)
                                     - (currentPoint.b * currentPoint.b)
                                     + z0[pos].a;
                    currentPoint.b = 2 * currentPoint.b * currentPoint.a
                                     + z0[pos].b;
                    
                    pointGrid[pos] = currentPoint;
                    iterationCount[pos] += 1;
                }
            }
        }
    }
}

- (RGBColor) rgbAtX:(int)x Y:(int)y
{
    int pos = x + y * resolution.width;
    
    RGBColor color;
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
