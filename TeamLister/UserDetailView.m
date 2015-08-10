//
//  UserDetailView.m
//  TeamLister
//
//  Created by Nicholas Long on 8/10/15.
//  Copyright (c) 2015 longsview. All rights reserved.
//

#import "UserDetailView.h"

@implementation UserDetailView

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.userImageView.layer.borderWidth = 4.0;
    self.userImageView.layer.cornerRadius = 100.0;
    self.userImageView.layer.masksToBounds = TRUE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
