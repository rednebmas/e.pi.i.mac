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
short int width = 400;
short int height = 400;
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
//    [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(rotateColor) userInfo:nil repeats:YES];
}

- (void) rotateColor
{
    NSDate *methodStart = [NSDate date];
    
    //Create a raw buffer to hold pixel data which we will fill algorithmically
    

    
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
    
    
       //Fill pixel buffer with color data
    for (int i=0; i<height; i++) {
        for (int j=0; j<width; j++) {
            RGBColor color = [fractal rgbAtX:j Y:i];
            
            int index = 4*(j+i*width);
            data[index]   = color.red;
            data[++index] = color.green;
            data[++index] = color.blue;
            data[++index] = 255;
        }
    } 
    
    
    
    _imageView.image = im;
    
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
