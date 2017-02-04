//
//  ViewController.m
//  PopUp Menu
//
//  Created by Tecksky Techonologies on 2/4/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "ViewController.h"
#import "KOPopupView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *camerabtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoimg;
@property (weak, nonatomic) IBOutlet UIButton *gallarybtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageuplod;
@property (weak, nonatomic) IBOutlet UIButton *canclebtn;
@property (nonatomic, strong) KOPopupView *popup;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _alertView.hidden = YES;
   
    _camerabtn.layer.cornerRadius = _camerabtn.frame.size.height /2;
    _gallarybtn.layer.cornerRadius = _gallarybtn.frame.size.height /2;
    _canclebtn.layer.cornerRadius = _canclebtn.frame.size.height /2;
    _logoimg.layer.cornerRadius = _logoimg.frame.size.height /2;
    _logoimg.layer.masksToBounds = YES;
    _logoimg.layer.borderWidth = 0;
    
     _alertView.layer.masksToBounds = NO;
    _alertView.layer.cornerRadius = 8; // if you like rounded corners
    _alertView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _alertView.layer.shadowOffset = CGSizeMake(2, 2);
    _alertView.layer.shadowRadius = 5;
    _alertView.layer.shadowOpacity = 0.8;
}


- (IBAction)showPressed:(id)sender{
      _alertView.hidden = NO;
    if(!self.popup)
        self.popup = [KOPopupView popupView];
    [self.popup.handleView addSubview:self.alertView];
    self.alertView.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
    [self.popup show];
    
}

- (IBAction)hidePressed:(id)sender{
    [self.popup hideAnimated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.popup willRotateToOrientation:toInterfaceOrientation withDuration:duration];
}
- (IBAction)camerabtn:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        
        [self presentModalViewController:picker animated:YES];
        
      [self.popup hideAnimated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"
                                                       message:@"Unable to find a camera on your device."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        
    }
}
- (IBAction)gallarybtn:(id)sender {
    
    NSLog(@"gallary");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    [self.popup hideAnimated:YES];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
  //  UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (chosenImage) {
        
       
        self.imageuplod.image = chosenImage;
        
        [picker dismissViewControllerAnimated:YES completion:NULL];
     
      
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



@end
