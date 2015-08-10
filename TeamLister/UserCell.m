#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
    self.userImageView.layer.cornerRadius = 30;
    self.userImageView.layer.borderWidth = 2.0;
    self.userImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.userImageView.layer.masksToBounds = TRUE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
