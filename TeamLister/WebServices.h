#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^ UsersListResult)(NSArray *users, NSError *error);

@interface WebServices : NSObject

-(void) getUsers:(UsersListResult)callback;

@end
