#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class User;
@class UserDetailView;

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) IBOutlet UserDetailView *userDetailView;

@end

