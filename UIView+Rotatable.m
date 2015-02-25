//
//  UIView+Rotatable.m
//
//  Created by Marat Al on 25.02.15.
//  Copyright (c) 2015 Favio Mobile. All rights reserved.
//

#import "UIView+Rotatable.h"
#import <objc/runtime.h>

@interface UIView ()

@property CGFloat angle;
@property CGPoint prevPoint;
@property CGAffineTransform startTransform;
@property UIPanGestureRecognizer* gesture;

@end


@implementation UIView (Rotatable)

- (void) setAngle:(CGFloat)angle {
    
    objc_setAssociatedObject(self, @selector(setAngle:), [NSNumber numberWithFloat:angle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat) angle {
    
    return [objc_getAssociatedObject(self, @selector(setAngle:)) floatValue];
}

- (void) setPrevPoint:(CGPoint)prevPoint {
    
    objc_setAssociatedObject(self, @selector(setPrevPoint:), [NSValue valueWithCGPoint:prevPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint) prevPoint {
    
    return [(NSValue*)objc_getAssociatedObject(self, @selector(setPrevPoint:)) CGPointValue];
}

- (void) setStartTransform:(CGAffineTransform)startTransform {
    
    objc_setAssociatedObject(self, @selector(setStartTransform:), [NSValue valueWithCGAffineTransform:startTransform], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGAffineTransform) startTransform {
    
    return [(NSValue*)objc_getAssociatedObject(self, @selector(setStartTransform:)) CGAffineTransformValue];
}

- (void) setGesture:(UIPanGestureRecognizer *)gesture {
    
    objc_setAssociatedObject(self, @selector(setGesture:), gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer*) gesture {
    
    return objc_getAssociatedObject(self, @selector(setGesture:));
}

- (void) rotateItem:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint currPoint = [recognizer locationInView:recognizer.view.superview];
    
    CGPoint center = recognizer.view.center;
    
    CGPoint prevPoint = self.prevPoint;
    
    CGFloat angle = atan2f(currPoint.y - center.y, currPoint.x - center.x) - atan2f(prevPoint.y - center.y, prevPoint.x - center.x);
    
    self.prevPoint = [recognizer locationInView:self.superview];
    
    self.angle += angle;
    
    self.transform = CGAffineTransformRotate(self.startTransform, self.angle);
}

- (BOOL) gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    
    self.startTransform = self.transform;
    
    return YES;
}


- (void) setRotatable:(BOOL)rotatable {
    
    if (self.gesture == nil)
    {
        UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateItem:)];
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
        self.gesture = panGesture;
    }
    
    self.gesture.enabled = rotatable;
}

- (BOOL) rotatable {
    
    return self.gesture.enabled;
}

@end


@implementation UIRotatableView

- (BOOL) rotatable {
    
    return super.rotatable;
}

- (void) setRotatable:(BOOL)rotatable {
    
    super.rotatable = rotatable;
}

@end