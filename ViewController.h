//
//  ViewController.h
//  PerspectiveReflection
//
//  Created by Mike Keller on 1/23/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIImageView *mainImageView;
    IBOutlet UIImageView *reflectionView;

}

- (IBAction) togglePerspective:(id)sender;

@end
