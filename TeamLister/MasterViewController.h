#import <UIKit/UIKit.h>

@class FetchedResultsControllerDataSource;

@interface MasterViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
