#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PersistentStack : NSObject

- (id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL;

@property (nonatomic,readonly) NSManagedObjectContext* managedObjectContext;

@end
