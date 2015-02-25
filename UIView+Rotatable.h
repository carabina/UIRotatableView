//
//  UIView+Rotatable.h
//
//  Created by Marat Al on 25.02.15.
//  Copyright (c) 2015 Favio Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Rotatable) <UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL rotatable;

@end


IB_DESIGNABLE
@interface UIRotatableView : UIView

@property (assign, nonatomic) IBInspectable BOOL rotatable;

@end