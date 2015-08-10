//
//  UserDetailView.h
//  TeamLister
//
//  Created by Nicholas Long on 8/10/15.
//  Copyright (c) 2015 longsview. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailView : UIView
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userRealName;
@property (weak, nonatomic) IBOutlet UILabel *userSlackName;
@property (weak, nonatomic) IBOutlet UILabel *userTitle;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *contactView;

@end
