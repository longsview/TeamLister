#import "MasterViewController.h"
#import "FetchedResultsControllerDataSource.h"
#import "User.h"
#import "DetailViewController.h"
#import "UserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MasterViewController () <FetchedResultsControllerDataSourceDelegate>

@property (nonatomic, strong) FetchedResultsControllerDataSource *dataSource;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
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

- (void)deleteObject:(id)object
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //PodDetailViewController *detailViewController = segue.destinationViewController;
    //detailViewController.pod = self.dataSource.selectedItem;
}

@end
