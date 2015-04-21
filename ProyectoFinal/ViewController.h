//
//  ViewController.h
//  ProyectoFinal
//
//  Created by alumno on 10/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinalViewController.h"



@interface ViewController : UIViewController
<UIPickerViewAccessibilityDelegate,UIPickerViewDataSource, EliminarVistas>


@property (strong, nonatomic) NSArray *arregloDif;
@property (strong, nonatomic) NSArray *arregloCategoria;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UITextField *tfCat;
@property (strong, nonatomic) IBOutlet UITextField *tfDif;


@end

