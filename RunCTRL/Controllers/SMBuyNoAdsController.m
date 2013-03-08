//
// Created by dmitrykorotchenkov on 17.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <StoreKit/StoreKit.h>
#import "SMBuyNoAdsController.h"
#import "SMBuyNoAdsView.h"
#import "SMUtils.h"
#import "SMSharedClass.h"
#import "MKStoreManager.h"
#import "UIViewAdditions.h"

static NSString *const productID = @"com.eservicesbe.RunCTRL.noads2";

@interface SMBuyNoAdsController ()
@property(nonatomic, strong) NSArray *emailsList;

@end

@implementation SMBuyNoAdsController {

}

- (void)loadView {
    [super loadView];
    self.view = [[SMBuyNoAdsView alloc] initWithFrame:AppFrameWithoutToolBar() controller:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)buyNoAds {
    [[MKStoreManager sharedManager] buyFeature:@"com.eservicesbe.RunCTRL.noads2" onComplete:^(NSString* purchasedFeature, NSData*purchasedReceipt, NSArray* availableDownloads){
        [self byNoAdsComplete];
    }
    onCancelled:^{
        NSLog(@"canceled");
    }];
}


- (void)sendEmail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        NSMutableArray *emailsList = [NSMutableArray array];
        ABAddressBookRef addressBook;
        if (ABAddressBookGetAuthorizationStatus != NULL) {
            // iOS6
            addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    [self sendEmailsForAddressBook:addressBook mailController:mailController emailsList:emailsList];
                });
            }
            else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
                [self sendEmailsForAddressBook:addressBook mailController:mailController emailsList:emailsList];
            }

        } else {
            addressBook = ABAddressBookCreate();
            [self sendEmailsForAddressBook:addressBook mailController:mailController emailsList:emailsList];
        }
    }
}

- (void)sendEmailsForAddressBook:(ABAddressBookRef)addressBook mailController:(MFMailComposeViewController *)mailController emailsList:(NSMutableArray *)emailsList {
    NSArray *array = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (id record in array) {
        CFTypeRef emailProp = ABRecordCopyValue(( __bridge ABRecordRef) record, kABPersonEmailProperty);
        NSString *email = [((__bridge NSArray *) ABMultiValueCopyArrayOfAllValues(emailProp)) objectAtIndex:0];
        if (email && ![email isEqualToString:@""]) {
            [emailsList addObject:email];
        }
    }
    self.emailsList = [NSArray arrayWithArray:emailsList];
    [mailController setToRecipients:self.emailsList];
    [mailController setMessageBody:@"Hi,\n"
            "\n"
            "\n"
            "Check out my new app for running http://goo.gl/G5iIS" isHTML:NO];
    [mailController setSubject:@"Check out my new app for running"];
    CGRect frame = mailController.view.frame;
    frame = CGRectOffset(frame, 0, mailController.navigationBar.bottom);
    frame.size = CGSizeMake(frame.size.width, frame.size.height - mailController.navigationBar.bottom);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.userInteractionEnabled = YES;

    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    view2.backgroundColor = [UIColor greenColor];
    view2.alpha = 0.1;

    [view addSubview:view2];
    view.alpha =0.1;
    [mailController.view addSubview:view];
    [self.navigationController presentModalViewController:mailController animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultSent) {
        [self byNoAdsComplete];
    }
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)byNoAdsComplete {
    [SMSharedClass sharedClass].isRegistered = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


@end