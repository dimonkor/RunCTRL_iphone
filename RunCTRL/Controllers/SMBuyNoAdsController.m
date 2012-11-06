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

static NSString *const productID = @"com.eservicesbe.RunCTRL.noads2";

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

-(void)buyNoAds{
    [self byNoAdsComplete];
//    SKProductsRequest *request =
//            [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:productID]];
//    request.delegate = self;
//    [request start];
}

//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
//    NSArray *products = response.products;
//    if (productID && products.count>0){
//        if ([productID isEqualToString:[products objectAtIndex:0]]){
//        }
//    }
//}


-(void)sendEmail{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        NSMutableArray *emailsList = [NSMutableArray array];
        ABAddressBookRef addressBook = ABAddressBookCreate();
        NSArray * array = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
        for (id record in array){
            CFTypeRef emailProp = ABRecordCopyValue(( __bridge ABRecordRef)record, kABPersonEmailProperty);
            NSString *email = [((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailProp)) objectAtIndex:0 ];
            if (email && ![email isEqualToString:@""]){
                [emailsList addObject:email];
            }
        }
        [mailController setToRecipients:emailsList];
        [mailController setMessageBody:@"test message" isHTML:NO];
        [mailController setSubject:@"test subject"];
        [self.navigationController presentModalViewController:mailController animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    if (result == MFMailComposeResultSent){
        [self byNoAdsComplete];
    }
}

-(void)byNoAdsComplete{
    [SMSharedClass sharedClass].isRegistered = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


@end