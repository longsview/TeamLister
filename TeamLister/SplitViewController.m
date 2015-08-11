#import "SplitViewController.h"

@implementation SplitViewController

-(BOOL)shouldAutorotate {
    // disable rotation on iPhone
    //
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return TRUE;
    }
    return FALSE;
}

@end
