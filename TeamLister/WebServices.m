#import "WebServices.h"

#define SLACK_API_TOKEN @"xoxp-4698769766-4698769768-4898023905-7a1afa"

@implementation WebServices

-(void) getUsers:(UsersListResult)callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://slack.com/api/users.list" parameters:@{@"token": SLACK_API_TOKEN} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *users = responseObject[@"members"];
            callback(users, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
