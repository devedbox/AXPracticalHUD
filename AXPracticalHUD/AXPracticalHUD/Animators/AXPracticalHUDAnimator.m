//
//  AXPracticalHUDAnimator.m
//  AXPracticalHUD
//
//  Created by devedbox on 2018/2/4.
//  Copyright © 2018年 AiXing. All rights reserved.
//

#import "AXPracticalHUDAnimator.h"
#import "AXPracticalHUD.h"

@interface AXPracticalHUD (Private_Hooks)
/// Get the content frame of the hud.
@property(readonly, nonatomic) CGRect contentFrame;
@end

@interface _AXPracticalHUDFadeAnimator: NSObject<AXPracticalHUDAnimator>
@end

@interface _AXPracticalHUDFlipUpAnimator: NSObject<AXPracticalHUDAnimator>
@end

@interface _AXPracticalHUDZoomAnimator: NSObject<AXPracticalHUDAnimator>
@end

id<AXPracticalHUDAnimator> AXPracticalHUDFadeAnimator() {
    return [_AXPracticalHUDFadeAnimator new];
}
id<AXPracticalHUDAnimator> AXPracticalHUDFlipUpAnimator() {
    return [_AXPracticalHUDFlipUpAnimator new];
}
id<AXPracticalHUDAnimator> AXPracticalHUDZoomAnimator() {
    return [_AXPracticalHUDZoomAnimator new];
}

#pragma mark - Fade.

@implementation _AXPracticalHUDFadeAnimator
- (NSTimeInterval)durationForTransition:(BOOL)isHidden {
    return isHidden ? 0.25 : 0.4;
}

- (void)hud:(AXPracticalHUD *)hud animate:(BOOL)animated isHidden:(BOOL)isHidden {
    if (animated) {
        [UIView animateWithDuration:0.25 delay:isHidden ? 0.0 : 0.15 options:7 animations:^{
            hud.alpha = isHidden ? 0.0 : 1.0;
        } completion:nil];
    } else {
        hud.alpha = isHidden ? 0.0 : 1.0;
    }
}
@end

#pragma mark - FlipUp.

@implementation _AXPracticalHUDFlipUpAnimator
- (NSTimeInterval)durationForTransition:(BOOL)isHidden {
    return isHidden ? 0.5 : 0.65;
}

- (void)hud:(AXPracticalHUD *)hud animate:(BOOL)animated isHidden:(BOOL)isHidden {
    if (animated) {
        if (isHidden) {
            CGRect rect = hud.contentFrame;
            CGFloat translation = (hud.position == AXPracticalHUDPositionBottom || hud.position == AXPracticalHUDPositionCenter) ? hud.bounds.size.height : -rect.size.height;
            rect.origin.y = translation;
            [UIView animateWithDuration:0.5
                                  delay:0.0
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:0.9
                                options:7
                             animations:^{
                hud.contentView.frame = rect;
                hud.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    hud.contentView.frame = hud.contentFrame;
                }
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                hud.alpha = 1.0;
            }];
            CGRect rect = hud.contentFrame;
            
            CGFloat translation = (hud.position == AXPracticalHUDPositionBottom || hud.position == AXPracticalHUDPositionCenter) ? hud.bounds.size.height : -rect.size.height;
            rect.origin.y = translation;
            hud.contentView.frame = rect;
            [UIView animateWithDuration:0.5
                                  delay:0.15
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:0.9
                                options:7
                             animations:^{
                hud.contentView.frame = hud.contentFrame;
            } completion:nil];
        }
    } else {
        hud.alpha = isHidden ? 0.0 : 1.0;
    }
}
@end

#pragma mark - Zoom.

@implementation _AXPracticalHUDZoomAnimator
- (NSTimeInterval)durationForTransition:(BOOL)isHidden {
    return 0.35;
}

- (void)hud:(AXPracticalHUD *)hud animate:(BOOL)animated isHidden:(BOOL)isHidden {
    if (animated) {
        if (isHidden) {
            [UIView animateWithDuration:0.25 animations:^{
                hud.alpha = 0.0;
            }];
            [UIView animateWithDuration:0.35
                                  delay:0.0
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:1.0
                                options:7
                             animations:^{
                                 hud.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                             } completion:^(BOOL finished) {
                                 if (finished) {
                                     hud.contentView.transform = CGAffineTransformIdentity;
                                 }
                             }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                hud.alpha = 1.0;
            }];
            hud.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            [UIView animateWithDuration:0.35
                                  delay:0.0
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:0.9
                                options:7
                             animations:^{
                                 hud.contentView.transform = CGAffineTransformIdentity;
                             } completion:nil];
        }
    } else {
        hud.alpha = isHidden ? 0.0 : 1.0;
    }
}
@end
