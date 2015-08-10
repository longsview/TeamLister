#import <UIKit/UIKit.h>

@class FetchedResultsControllerDataSource;

@interface MasterViewController : UITableViewController <UIActionSheetDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UISearchController *searchController;

@end
