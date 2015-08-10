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
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:71.0/255.0 green:65.0/255.0 blue:90.0/255.0 alpha:1.0];
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"realName" ascending:YES]];
    self.dataSource = [[FetchedResultsControllerDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
    self.dataSource.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.dataSource.reuseIdentifier = @"Cell";
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slack"]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
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

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    if(searchController == nil || [searchString isEqualToString:@""]) {
        // no search term
        [self.dataSource.fetchedResultsController.fetchRequest setPredicate:nil];
        self.dataSource.fetchedResultsController = self.dataSource.fetchedResultsController;
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@ OR realName contains[cd] %@ OR title contains[cd] %@", searchString, searchString, searchString];

    [self.dataSource.fetchedResultsController.fetchRequest setPredicate:predicate];
    
    // this causes a refetch
    //
    self.dataSource.fetchedResultsController = self.dataSource.fetchedResultsController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *viewController = (DetailViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
    viewController.user = self.dataSource.selectedItem;
}

@end
