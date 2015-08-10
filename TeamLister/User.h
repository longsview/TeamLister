#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface User : BaseModel

@property (nonatomic, retain) NSString * userID;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * realName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * colorR;
@property (nonatomic, retain) NSNumber * colorG;
@property (nonatomic, retain) NSNumber * colorB;

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * skype;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;

@property (nonatomic, retain) NSString * icon24;
@property (nonatomic, retain) NSString * icon32;
@property (nonatomic, retain) NSString * icon48;
@property (nonatomic, retain) NSString * icon72;
@property (nonatomic, retain) NSString * icon192;

@property (nonatomic, retain) NSNumber * userDeleted;

- (void)loadFromDictionary:(NSDictionary *)dictionary;
+ (User *)findOrCreatePodWithIdentifier:(NSString *)userID inContext:(NSManagedObjectContext *)context;

@end
