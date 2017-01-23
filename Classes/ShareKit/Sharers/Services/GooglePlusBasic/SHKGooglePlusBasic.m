//
//
//

#import "SHKGooglePlusBasic.h"
#import "SharersCommonHeaders.h"
#import "SafariServices/SFSafariViewController.h"

@implementation SHKGooglePlusBasic

#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle {	return SHKLocalizedString(@"Google+"); }

+ (BOOL)canShareURL { return YES; }
+ (BOOL)canShareText { return YES; }
+ (BOOL)canShareImage { return NO; }
+ (BOOL)canShareFile:(SHKFile *)file { return NO; }
+ (BOOL)canShareOffline { return NO; }
+ (BOOL)canAutoShare { return NO; }
+ (BOOL)requiresAuthentication
{
	return NO;
}

#pragma mark -
#pragma mark Share API Methods

- (BOOL)send {

  self.quiet = YES; //if user cancels, on return blinks activity indicator. This disables it, as we share in safari and it is hidden anyway
  [self showGooglePlusShare:self.item.URL text:self.item.text];
  [self sendDidFinish];
  return TRUE;
}

- (void)showGooglePlusShare:(NSURL*)shareURL text:(NSString*)textStr {

  // Construct the Google+ share URL
  NSURLComponents* urlComponents = [[NSURLComponents alloc] initWithString:@"https://plus.google.com/share"];
  urlComponents.queryItems = @[
    [[NSURLQueryItem alloc] initWithName:@"url" value:[shareURL absoluteString]],
    [[NSURLQueryItem alloc] initWithName:@"text" value:textStr]
  ];
  NSURL* url = [urlComponents URL];

  if ([SFSafariViewController class]) {
    // Open the URL in SFSafariViewController (iOS 9+)
    SFSafariViewController* controller = [[SFSafariViewController alloc] initWithURL:url];
    controller.delegate = self;
    [[SHK currentHelper] showStandaloneViewController:controller];
  } else {
    // Open the URL in the device's browser
    [[UIApplication sharedApplication] openURL:url];
  }
}

@end
