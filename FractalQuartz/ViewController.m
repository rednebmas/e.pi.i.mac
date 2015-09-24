//
//  ViewController.m
//  FractalQuartz
//
//  Created by Sam Bender on 7/22/15.
//  Copyright (c) 2015 Sam Bender. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create a raw buffer to hold pixel data which we will fill algorithmically
    NSInteger width = 100;
    NSInteger height = 100;
    NSInteger dataLength = width * height * 4;
    UInt8 *data = (UInt8*)malloc(dataLength * sizeof(UInt8));
    
    //Fill pixel buffer with color data
    for (int j=0; j<height; j++) {
        for (int i=0; i<width; i++) {
            
            //Here I'm just filling every pixel with red
            float red   = 1.0f;
            float green = 0.0f;
            float blue  = 0.0f;
            float alpha = 1.0f;
            
            int index = 4*(i+j*width);
            data[index]  =255*red;
            data[++index]=255*green;
            data[++index]=255*blue;
            data[++index]=255*alpha;
            
        }
    }
    
    // Create a CGImage with the pixel data
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef image = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                     
                                     provider, NULL, true, kCGRenderingIntentDefault);
    
    //Clean up
    CGColorSpaceRelease(colorspace);
    CGDataProviderRelease(provider);
    // Don't forget to free(data) when you are done with the CGImage
    
    NSImage *im = [[NSImage alloc] initWithCGImage:image size:(NSSize){ 100, 100}];
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(rotateColor) userInfo:nil repeats:YES];
    
    for (int j=0; j<height; j++) {
        for (int i=0; i<width; i++) {
            
            //Here I'm just filling every pixel with red
            float red   = 0.0f;
            float green = 1.0f;
            float blue  = 0.0f;
            float alpha = 1.0f;
            
            int index = 4*(i+j*width);
            data[index]  =255*red;
            data[++index]=255*green;
            data[++index]=255*blue;
            data[++index]=255*alpha;
            
        }
    }
    
    
    _imageView.image = im;
    
    
    return;

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
