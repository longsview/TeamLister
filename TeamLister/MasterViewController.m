#import "MasterViewController.h"
#import "FetchedResultsControllerDataSource.h"
#import "User.h"
#import "DetailViewController.h"

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
}

- (void)configureCell:(UITableViewCell *)cell withObject:(User*)object
{
    cell.textLabel.text = object.name;
    cell.backgroundColor = [UIColor colorWithRed:object.colorR.floatValue green:object.colorG.floatValue blue:object.colorB.floatValue alpha:1.0];
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