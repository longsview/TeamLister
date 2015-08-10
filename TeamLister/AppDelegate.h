#import <UIKit/UIKit.h>

@class PersistentStack;
@class WebServices;
@class UserLoader;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) PersistentStack *persistentStack;
@property (nonatomic, strong) WebServices *webServices;
@end
