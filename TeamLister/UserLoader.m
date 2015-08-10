#import "UserLoader.h"
#import "WebServices.h"
#import "User.h"

@interface UserLoader ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) WebServices *webService;
@end

@implementation UserLoader

- (id)initWithContext:(NSManagedObjectContext *)context webservice:(WebServices *)webService
{
    self = [super init];
    if (self) {
        self.context = context;
        self.webService = webService;
    }
    return self;
}

- (void)load
{
    [self.webService getUsers:^(NSArray *users, NSError *error)
     {
         [self.context performBlock:^
          {
              for(NSDictionary *userData in users) {
                  User *user = [User findOrCreatePodWithIdentifier:userData[@"id"] inContext:self.context];
                  [user loadFromDictionary:userData];
              }
              
              NSError *error;
              [self.context save:&error];
          }];
     }];
}
@end
