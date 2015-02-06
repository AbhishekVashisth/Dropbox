//
//  AppDelegate.h
//  Dropbox
//
//  Created by Abhishek on 03/02/15.
//
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,DBSessionDelegate, DBNetworkRequestDelegate>
{
    NSString *relinkUserId;
}
@property (strong, nonatomic) UIWindow *window;

@end
