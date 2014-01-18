//
//  UIButton+SnapAdditions.m
//  Snap
//
//  Created by Josh Kasuboski on 12/7/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import "UIButton+SnapAdditions.h"
#import "UIFont+SnapAdditions.h"

@implementation UIButton (SnapAdditions)

- (void)rw_applySnapStyle
{
	self.titleLabel.font = [UIFont rw_snapFontWithSize:20.0f];
    
	UIImage *buttonImage = [[UIImage imageNamed:@"Button"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
	[self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
	UIImage *pressedImage = [[UIImage imageNamed:@"ButtonPressed"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
	[self setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
}

@end