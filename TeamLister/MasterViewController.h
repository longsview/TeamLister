#import <UIKit/UIKit.h>

@class FetchedResultsControllerDataSource;

@interface MasterViewController : UITableViewController <UIActionSheetDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
