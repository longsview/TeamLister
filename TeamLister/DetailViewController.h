#import <UIKit/UIKit.h>

@class User;
@class UserDetailView;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) IBOutlet UserDetailView *userDetailView;

@end

