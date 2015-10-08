//
//  ViewController.m
//  FractalQuartz
//
//  Created by Sam Bender on 7/22/15.
//  Copyright (c) 2015 Sam Bender. All rights reserved.
//

#import "ViewController.h"
#import "Fractal.h"

float lastValue = 0.0;

@implementation ViewController
UInt8 *data;
short int width = 800 * 2;
short int height = 800 * 2;
Fractal *fractal;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*** FRACTAL ***/
    WindowEdges windowEdges;
    windowEdges.left = -2.5;
    windowEdges.right = 1.5;
    windowEdges.top = 2.0;
    windowEdges.bottom = -2.1;
    
    WindowSize resolution;
    resolution.width = width;
    resolution.height = height;
    
    fractal = [[Fractal alloc] initWithWindowEdges:windowEdges outputResolution:resolution];
    [fractal run];
    /***************/
    
    NSInteger dataLength = width * height * 4;
    data = (UInt8*)malloc(dataLength * sizeof(UInt8));
    [self rotateColor];
}

- (void) rotateColor
{
    NSDate *methodStart = [NSDate date];
    
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            RGBColor color = [fractal rgbAtX:x Y:y];
            
            int index = 4*(x+y*width);
            
            data[index]   = color.red;
            data[++index] = color.green;
            data[++index] = color.blue;
            data[++index] = 255;
        }
    }
    
    // Create a CGImage with the pixel data
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, data, width * height * 4, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef image = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                     
                                     provider, NULL, true, kCGRenderingIntentDefault);
    
    //Clean up
    CGColorSpaceRelease(colorspace);
    CGDataProviderRelease(provider);
    // Don't forget to free(data) when you are done with the CGImage
    
    NSImage *im = [[NSImage alloc] initWithCGImage:image size:(NSSize){ width, height}];
    
    _imageView.image = im;

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
