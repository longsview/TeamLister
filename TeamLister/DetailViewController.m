#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailViewController.h"
#import "User.h"
#import "UserDetailView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setUser:(User *)user {
    if (_user != user) {
        _user = user;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.user) {
        self.userDetailView.userRealName.text = self.user.realName;
        self.userDetailView.userSlackName.text = [NSString stringWithFormat:@"@%@", self.user.name];
        self.userDetailView.userTitle.text = self.user.title;
        
        self.userDetailView.backgroundView.backgroundColor = [UIColor colorWithRed:self.user.colorR.floatValue green:self.user.colorG.floatValue blue:self.user.colorB.floatValue alpha:0.2];
        
        [self.userDetailView.userImageView sd_setImageWithURL:[NSURL URLWithString:self.user.icon192]
                                  placeholderImage:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender {
    if (self.splitViewController.collapsed) {
        [self.splitViewController.viewControllers[0] popToRootViewControllerAnimated:true];
    }
}

@end
