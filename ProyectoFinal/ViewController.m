//
//  ViewController.m
//  ProyectoFinal
//
//  Created by alumno on 10/04/15.
//  Copyright (c) 2015 ITESM. All rights reserved.
//

#import "ViewController.h"
#import "JugarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arregloDif = [[NSArray alloc] initWithObjects:@"1", @"2", @"3",nil];
     self.arregloCategoria = [[NSArray alloc] initWithObjects:@"Banderas", @"Colores", @"Anatomia",nil];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return [self.arregloCategoria count];
    else if (component == 1)
        return [self.arregloDif count];
    return 0;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    long reng1 = [self.picker selectedRowInComponent: 0];
    long reng2 = [self.picker selectedRowInComponent: 1];
    
    NSString *valor1 = [self.arregloCategoria objectAtIndex:reng1];
    NSString *valor2 = [self.arregloDif objectAtIndex:reng2];
    
    self.tfDif.text = [NSString stringWithFormat:@"%@",valor2];
    self.tfCat.text = [NSString stringWithFormat:@"%@",valor1];

    
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if( component == 0 )
        return [self.arregloCategoria objectAtIndex:row];
    else if (component == 1)
        return [self.arregloDif objectAtIndex:row];
    return nil;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if([[segue identifier] isEqualToString:@"idJugar"]){
         JugarViewController *jvc = [segue destinationViewController];
         long reng1 = [self.picker selectedRowInComponent: 0];
         long reng2 = [self.picker selectedRowInComponent: 1];
         
         NSString *valor1 = [self.arregloCategoria objectAtIndex:reng1];
         NSString *valor2 = [self.arregloDif objectAtIndex:reng2];
         jvc.stCategoria = valor1;
         jvc.stDificultad = valor2;
         
     }
 }


@end
