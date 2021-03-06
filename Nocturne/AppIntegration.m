//
//  AppIntegration.m
//  Nocturne
//
//  Created by Thomas Whitmire on 9/11/16.
//

#import "AppIntegration.h"
#import "Social/Social.h"

@interface AppIntegration ()


@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
- (void) configureTweetTextView;
- (void) showAlertMessage:(NSString *) myMessage;


@end

@implementation AppIntegration


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlertMessage:(NSString *) myMessage{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"TwitterShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)shareTweet:(id)sender {
    
    if([self.tweetTextView isFirstResponder]){
        [self.tweetTextView resignFirstResponder];
    }
    
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"" message:@"Tweet" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:
                                  ^(UIAlertAction *action){
                                      if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                                          
                                          SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                          
                                          
                                          if([self.tweetTextView.text length] < 140) {
                                              [twitterVC setInitialText:self.tweetTextView.text];
                                          }
                                          else {
                                              NSString *shortText = [self.tweetTextView.text substringFromIndex:140];
                                              [twitterVC setInitialText:shortText];
                                          }
                                          
                                          [self presentViewController:twitterVC animated:YES completion:nil];
                                          
                                          //tweet
                                      }
                                      else{
                                          
                                          [self showAlertMessage:@"Please sign yo self in."];
                                          //exception
                                      }
                                  }];
    
    
    [actionController addAction:tweetAction];
    [actionController addAction:cancelAction];
    
    
    [self presentViewController:actionController animated:YES completion:nil];
}



- (void) configureTweetTextView{
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;

    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
}

@end

