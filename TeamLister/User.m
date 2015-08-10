#import "User.h"
#import "UIColor+HexExtensions.h"

@implementation User

@dynamic userID;

@dynamic name;
@dynamic realName;
@dynamic firstName;
@dynamic lastName;
@dynamic colorR;
@dynamic colorG;
@dynamic colorB;

@dynamic title;

@dynamic skype;
@dynamic phone;
@dynamic email;

@dynamic icon24;
@dynamic icon32;
@dynamic icon48;
@dynamic icon72;
@dynamic icon192;

@dynamic userDeleted;

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.userID = dictionary[@"id"];
    
    self.name = dictionary[@"name"];
    self.realName = dictionary[@"real_name"];
    
    UIColor * color = [UIColor colorFromHexString:dictionary[@"color"]];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    self.colorR = [NSNumber numberWithFloat:components[0]];
    self.colorG = [NSNumber numberWithFloat:components[1]];
    self.colorB = [NSNumber numberWithFloat:components[2]];
    
    NSDictionary *profile = dictionary[@"profile"];
    if(profile != nil) {
        self.title = profile[@"title"];
        self.firstName = profile[@"first_name"];
        self.lastName = profile[@"last_name"];
        self.skype = profile[@"skype"];
        self.email = profile[@"email"];
        self.phone = profile[@"phone"];
        
        self.icon24 = profile[@"image_24"];
        self.icon32 = profile[@"image_32"];
        self.icon48 = profile[@"image_48"];
        self.icon72 = profile[@"image_72"];
        self.icon192 = profile[@"image_192"];
    }
    
    self.userDeleted = dictionary[@"deleted"];
}

+ (User *)findOrCreatePodWithIdentifier:(NSString *)userID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID = %@", userID];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    if (result.lastObject) {
        return result.lastObject;
    } else {
        User *user = [self insertNewObjectIntoContext:context];
        user.userID = userID;
        return user;
    }
}

@end
