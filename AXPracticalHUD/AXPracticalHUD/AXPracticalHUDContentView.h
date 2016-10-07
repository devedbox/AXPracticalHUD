//
//  AXPracticalHUDContentView.h
//  AXSwift2OC
//
//  Created by ai on 9/7/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AXPracticalHUDTranslucentStyle) {
    AXPracticalHUDTranslucentStyleLight,
    AXPracticalHUDTranslucentStyleDark
};

@interface AXPracticalHUDContentView : UIView
/// Color of the content view. Default is nil.
@property(strong, nonatomic) UIColor *color;
/// End color of the content view. Default is nil.
@property(strong, nonatomic) UIColor *endColor;
/// Translucent. Default is NO.
@property(assign, nonatomic) BOOL translucent;
/// Translucent style. Default is Dark.
@property(assign, nonatomic) AXPracticalHUDTranslucentStyle translucentStyle;
/// Opacity. Default is 0.8f.
@property(assign, nonatomic) CGFloat opacity;
@end
