//
//  JYMessageBar.m
//  JYV2
//
//  Created by ai on 15/5/25.
//  Copyright (c) 2015年 KEEPStudio. All rights reserved.
//

#import "JYMessageBar.h"

@interface JYMessageBar () <UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *_tapGesture;
    UIPanGestureRecognizer *_panGesture;
}
@end

@implementation JYMessageBar
#pragma mark - Initializer
- (instancetype)init {
    if (self = [super init]) {
        [self initialier];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialier];
    }
    return self;
}

- (void)initialier {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = YES;
    _touchEnabled = YES;
    
    [self addSubview:self.avatar];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleTap:)];
    _tapGesture.delegate = self;
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handlePan:)];
    _panGesture.delegate = self;
    [self addGestureRecognizer:_tapGesture];
    [self addGestureRecognizer:_panGesture];
}

#pragma mark - Override
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect_nick = _nicknameLabel.frame;
    CGRect rect_content = _contentLabel.frame;
    CGRect rect_time = _timeLabel.frame;
    
    rect_nick.size.width = (self.bounds.size.width - 40) * 0.67;
    rect_content.origin.y = CGRectGetMaxY(rect_nick) + 10;
    rect_content.size.width = self.bounds.size.width - rect_nick.origin.x - 10;
    rect_content.size.height = self.bounds.size.height - 30;
    rect_time.origin.x = self.bounds.size.width - (rect_time.size.width)-8;
    
    _nicknameLabel.frame = rect_nick;
    _contentLabel.frame = rect_content;
    _timeLabel.frame = rect_time;
    _contentLabel.frame = rect_content;
}

#pragma mark - Getters
- (UIImageView *)avatar {
    if (_avatar) return _avatar;
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 30, 30)];
    _avatar.layer.cornerRadius = 15;
    _avatar.layer.masksToBounds = YES;
    _avatar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    return _avatar;
}

- (UILabel *)nicknameLabel {
    if (_nicknameLabel) return _nicknameLabel;
    _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatar.frame) + 10, 0, 0, 0)];
    _nicknameLabel.textColor = [UIColor whiteColor];
    _nicknameLabel.backgroundColor = [UIColor clearColor];
    _nicknameLabel.font = [UIFont boldSystemFontOfSize:14];
    _nicknameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    return _nicknameLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel) return _contentLabel;
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nicknameLabel.frame.origin.x, CGRectGetMaxY(self.nicknameLabel.frame) + 10, 0, 0)];
    _contentLabel.font = [UIFont boldSystemFontOfSize:12];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel) return _timeLabel;
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel.font = [UIFont boldSystemFontOfSize:10];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    return _timeLabel;
}

- (NSString *)nickname {
    return _nicknameLabel.text;
}

- (NSString *)content {
    return _contentLabel.text;
}

- (NSString *)time {
    return _timeLabel.text;
}

#pragma mark - Setters
- (void)setNickname:(NSString *)nickname {
    _nicknameLabel.text = nickname;
    [_nicknameLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)setContent:(NSString *)content {
    _contentLabel.text = content;
    [self setNeedsLayout];
}

- (void)setTime:(NSString *)time {
    _timeLabel.text = time;
    [_timeLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)setTouchEnabled:(BOOL)touchEnabled {
    _touchEnabled = touchEnabled;
    if (_touchEnabled) {
        [self addGestureRecognizer:_tapGesture];
    } else {
        [self removeGestureRecognizer:_tapGesture];
    }
}

#pragma mark - Actions
- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (self.handler) {
        __weak typeof(self) weakSelf = self;
        self.handler (weakSelf, self.nickname, _ID);
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateRecognized) {
        if (self.panToBottomHandler) {
            self.panToBottomHandler ();
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}
@end
