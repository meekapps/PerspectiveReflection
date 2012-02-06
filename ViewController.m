//
//  ViewController.m
//  PerspectiveReflection
//
//  Created by Mike Keller on 1/23/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //The nib sets the size and position of the main image as well as the size and position of the reflection view
    //  The perspective view is set up at 1.5x the size of main image and positioned halfway down the main image height.
    
    //create the reflection
    reflectionView.image = [UIImage
                             imageWithCGImage:mainImageView.image.CGImage
                             scale:1.0f
                             orientation: UIImageOrientationDownMirrored];
    
    
    //create the perspective
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m24 = 1.0f/-mainImageView.frame.size.height;
    [[reflectionView layer] setTransform:rotationAndPerspectiveTransform];
    
    //gradient mask to fade out the reflection to the white background
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = reflectionView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
    gradient.startPoint = CGPointMake(0.5f, 0.0f);
    gradient.endPoint = CGPointMake(0.5f, 1.0f);
    reflectionView.layer.mask = gradient;
    
    //Shadow behind main image
    [[mainImageView layer] setShadowOffset:CGSizeMake(0, -3)];
    [[mainImageView layer] setShadowOpacity:0.3f];
    [[mainImageView layer] setShadowRadius:5.0f];

}

//Switch action toggles perspective
- (IBAction) togglePerspective:(id)sender {
    UISwitch *perspectiveSwitch = (UISwitch*)sender;
    BOOL perspective = perspectiveSwitch.on;
    
    if (perspective) {
        //change the rotation transform
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m24 = 1.0f/-mainImageView.frame.size.height;
        [[reflectionView layer] setTransform:rotationAndPerspectiveTransform];
        
        //and scale accordingly
        reflectionView.layer.transform = CATransform3DScale(reflectionView.layer.transform, 1.0f, 1.0f, 1);
    } else {    
        //change the rotation transform
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m24 = 0.0f/-mainImageView.frame.size.height;
        [[reflectionView layer] setTransform:rotationAndPerspectiveTransform];
        
        //and scale accordingly
        reflectionView.layer.transform = CATransform3DScale(reflectionView.layer.transform, 0.5, 0.5f, 1);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
