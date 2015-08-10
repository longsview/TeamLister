#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseModel : NSManagedObject

+ (id)entityName;
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext*)context;

@end