#import <SDWebImage/UIImageView+WebCache.h>
#import "MasterViewController.h"
#import "FetchedResultsControllerDataSource.h"
#import "User.h"
#import "DetailViewController.h"
#import "UserCell.h"

@interface MasterViewController () <FetchedResultsControllerDataSourceDelegate>

@property (nonatomic, strong) FetchedResultsControllerDataSource *dataSource;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"realName" ascending:YES]];
    self.dataSource = [[FetchedResultsControllerDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
    self.dataSource.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.dataSource.reuseIdentifier = @"Cell";
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slack"]];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(User*)object
{
    UserCell *userCell = (UserCell*)cell;
    
    userCell.userRealName.text = object.realName;
    userCell.userSlackName.text = [NSString stringWithFormat:@"@%@", object.name];
    userCell.userTitle.text = object.title;
    
    userCell.backgroundColor = [UIColor colorWithRed:object.colorR.floatValue green:object.colorG.floatValue blue:object.colorB.floatValue alpha:0.25];
    
    [userCell.userImageView sd_setImageWithURL:[NSURL URLWithString:object.icon192]
                      placeholderImage:nil];
}

- (IBAction)sortPressed:(id)sender {
    // add an action sheet with the different types of sorting supported
    //
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"SORT BY", @"Sort") delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Full Name", @"Slack Name", @"First Name", @"Last Name", @"Title", nil];
    [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // cancel clicked
    //
    if(buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    // create a new fetch request based on the sort type selected
    //
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    switch (buttonIndex) {
        case 0:
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"realName" ascending:YES]];
            break;
        case 1:
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
            break;
        case 2:
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]];
            break;
        case 3:
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]];
            break;
        case 4:
            request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
            break;
    }
    
    // create a new fetched results controller and set it on the table view
    //
    self.dataSource.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *viewController = (DetailViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
    viewController.user = self.dataSource.selectedItem;
}

@end
