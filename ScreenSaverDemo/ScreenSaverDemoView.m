//
//  ScreenSaverDemoView.m
//  ScreenSaverDemo
//
//  Created by xing on 2018/4/4.
//  Copyright © 2018年 xing. All rights reserved.
//

#import "ScreenSaverDemoView.h"

@interface ScreenSaverDemoView ()

@property (nonatomic, strong) NSImageView *fImageView;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation ScreenSaverDemoView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.xing.ScreenSaverDemo"];
        NSLog(@"bundle.bundlePath: %@",bundle.bundlePath);
        
        CGRect rect = self.bounds;
        CGFloat width = rect.size.height/2;
        CGRect fRect = CGRectMake((rect.size.width-width)/2, (rect.size.height-width)/2, width, width);
        
        NSString *fPath = [bundle pathForResource:@"timg" ofType:@"png"];
        NSImage *floatImage = [[NSImage alloc] initWithContentsOfFile:fPath];
        _fImageView = [[NSImageView alloc] initWithFrame:fRect];
        _fImageView.image = floatImage;
        [self addSubview:_fImageView];
        
        [_fImageView setWantsLayer:YES];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    CALayer *layer = _fImageView.layer;
    
    CATransform3D transfrom = CATransform3DIdentity;
    _angle = _angle - M_PI/200.0;
    if (_angle == -M_PI *2) {
        _angle = 0;
        NSLog(@"_angle reset");
    }
    CGPoint point = CGPointMake(0.5, 0.5);
    transfrom = CATransform3DRotate(transfrom, _angle , 0.0f, 0.0f, 1.0f);
    transfrom = CATransform3DConcat(transfrom, CATransform3DTranslate(CATransform3DIdentity, _fImageView.bounds.size.width/2, _fImageView.bounds.size.height/2, 0));
    layer.anchorPoint = point;
    layer.transform = transfrom;
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
