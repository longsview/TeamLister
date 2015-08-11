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
        
        NSString *deviceType = [UIDevice currentDevice].model;
 
        self.userDetailView.phoneButton.enabled = [deviceType isEqualToString:@"iPhone"] && self.user.phone.length > 0;
        self.userDetailView.emailButton.enabled = [MFMailComposeViewController canSendMail] && self.user.email.length > 0;
        self.userDetailView.smsButton.enabled = [MFMessageComposeViewController canSendText] && self.user.phone.length > 0;
        self.userDetailView.skypeButton.enabled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]] && self.user.skype.length > 0;
        
        self.userDetailView.backgroundView.backgroundColor = [UIColor colorWithRed:self.user.colorR.floatValue green:self.user.colorG.floatValue blue:self.user.colorB.floatValue alpha:0.2];
        
        [self.userDetailView.userImageView sd_setImageWithURL:[NSURL URLWithString:self.user.icon192]
                                  placeholderImage:nil];
        
        self.userDetailView.contactView.hidden = FALSE;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide the back button on iPad since we always show
    // the master view popover
    //
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.userDetailView.backButton.hidden = TRUE;
    }
    
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

- (IBAction)phonePressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.user.phone]]];
}

- (IBAction)emailPressed:(id)sender {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;

    NSArray *toRecipients = [NSArray arrayWithObjects:self.user.email,
                             nil];
    [picker setToRecipients:toRecipients];
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)smsPressed:(id)sender {
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
    NSArray *recipients = [NSArray arrayWithObjects:self.user.phone,
                             nil];
    picker.recipients = recipients;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)skypePressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"skype:%@?call", self.user.skype]]];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
