//
//  JYMessageBar.h
//  JYV2
//
//  Created by ai on 15/5/25.
//  Copyright (c) 2015年 KEEPStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JYMessageBar;
/**
 @description The handler block when touched the view
 @param nickname a nickname of the user
 @param ID a ID, user id when the message is a IMPP message, push id when the message is a notification message
 */
typedef void(^JYMessageBarHandler)(JYMessageBar __weak *bar, NSString *nickname, NSNumber *ID);
/**
 @description The handler block when pan to the bottom of the view
 */
typedef void(^JYMessageBarPanToBottomHandler)();

@interface JYMessageBar : UIView
{
    NSNumber *_ID;
}
/**
 ID
 */
@property (strong, nonatomic) NSNumber *ID;
/**
 Avatar image view
 */
@property (strong, nonatomic) UIImageView *avatar;
/**
 Nickname
 */
@property (nonatomic) NSString *nickname;
/**
 Content
 */
@property (nonatomic) NSString *content;
/**
 Time description
 */
@property (nonatomic) NSString *time;
/**
 Touch enabled, Default : YES
 */
@property (assign, nonatomic) BOOL touchEnabled;
/**
 Handler block
 */
@property (copy, nonatomic) JYMessageBarHandler handler;
/**
 Pan handler block
 */
@property (copy, nonatomic) JYMessageBarPanToBottomHandler panToBottomHandler;
/**
 nickname label
 */
@property (strong, nonatomic) UILabel *nicknameLabel;
/**
 content label
 */
@property (strong, nonatomic) UILabel *contentLabel;
/**
 time label
 */
@property (strong, nonatomic) UILabel *timeLabel;
@end
