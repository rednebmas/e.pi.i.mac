//
//  Window.h
//  FractalQuartz
//
//  Created by Sam Bender on 9/23/15.
//  Copyright © 2015 Sam Bender. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct WindowEdges
{
    double left;
    double right;
    double top;
    double bottom;
} WindowEdges;

typedef struct WindowSize
{
    short int width;
    short int height;
} WindowSize;

@interface Fractal : NSObject

@property int iterations;

- (id) initWithWindowEdges:(WindowEdges)_windowEdges outputResolution:(WindowSize)_resolution;
- (void) run;
- (RGBColor) rgbAtX:(int)x Y:(int)y;

@end
