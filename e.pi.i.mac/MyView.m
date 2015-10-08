//
//  MyView.m
//  FractalQuartz
//
//  Created by Sam Bender on 7/22/15.
//  Copyright (c) 2015 Sam Bender. All rights reserved.
//

#import "MyView.h"

@implementation MyView

#define WIDTH 400
#define HEIGHT 400
#define SIZE (WIDTH*HEIGHT)
#define BYTES_PER_PIXEL 2
#define BITS_PER_COMPONENT 5
#define BITS_PER_PIXEL 16

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void) drawRect:(NSRect)dirtyRect
{
    
    /*
    // Get current context
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    // Colorspace RGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Pixel Matrix allocation
    unsigned short *pixels = calloc(SIZE, sizeof(unsigned short));
    
    // Random pixels will give you a non-organized RAINBOW
    for (int i = 0; i < WIDTH; i++) {
        for (int j = 0; j < HEIGHT; j++) {
            pixels[i+ j*HEIGHT] = arc4random() % USHRT_MAX;
        }
    }
    
    // Provider
    CGDataProviderRef provider = CGDataProviderCreateWithData(nil, pixels, SIZE, nil);
    
    // CGImage
    CGImageRef image = CGImageCreate(WIDTH,
                                     HEIGHT,
                                     BITS_PER_COMPONENT,
                                     BITS_PER_PIXEL,
                                     BYTES_PER_PIXEL*WIDTH,
                                     colorSpace,
                                     kCGImageAlphaNoneSkipFirst,
                                     // xRRRRRGGGGGBBBBB - 16-bits, first bit is ignored!
                                     provider,
                                     nil, //No decode
                                     NO,  //No interpolation
                                     kCGRenderingIntentDefault); // Default rendering
    
    // Draw
    CGContextDrawImage(context, self.bounds, image);
    
    // Once everything is written on screen we can release everything
    CGImageRelease(image);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
    */
}

@end


/*
@implementation MyView


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);
    
    NSDate *methodStart = [NSDate date];
    for (int i = 0; i < 1000*1000; i++) {
        CGContextFillRect (myContext, CGRectMake (0, 0, 200, 100 ));
    }
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);
    
    CGContextSetRGBFillColor (myContext, 0, 0, 1, .5);
    CGContextFillRect (myContext, CGRectMake (0, 0, 100, 200));
}

@end

*/