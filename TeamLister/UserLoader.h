#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WebServices;

@interface UserLoader : NSObject
- (id)initWithContext:(NSManagedObjectContext *)context
           webservice:(WebServices *)webservice;
- (void)load;

@end
