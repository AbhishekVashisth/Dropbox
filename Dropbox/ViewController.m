//
//  ViewController.m
//  Dropbox
//
//  Created by Abhishek on 03/02/15.
//
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    
    [self loginWithDropboxCredentials];
    // upload photo to dropbox
    [self uploadPhotoToDropbox];
    
}

- (IBAction)loginWithDropboxCredentials {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
    else{
      
    }
}

-(void)logout
{
    [[DBSession sharedSession] unlinkAll];
   UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked"
       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertview show];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uploadPhotoToDropbox
{
    // Write a file to the local documents directory
    NSString *filename = @"196.jpg";
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:filename];
    
     NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageNamed:filename])];
    
    [imageData writeToFile:localPath atomically:YES];
    
    // Upload file to Dropbox
    NSString *destDir = @"/";
    [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:localPath];
    
    
}
- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
    NSLog(@"File upload failed with error: %@", error);
}

@end
