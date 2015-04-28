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
    NSString *pathList = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    self.arregloPList = [[NSArray alloc] initWithContentsOfFile:pathList];
    

    self.arregloDif = [[NSArray alloc] initWithObjects:@"1", @"2", @"3",nil];
    self.arregloCategoria = self.arregloPList[0];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;

    [self cambiaValorPicker];
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
    [self cambiaValorPicker];
}

-(void) cambiaValorPicker{
    long reng1 = [self.picker selectedRowInComponent: 0];
    long reng2 = [self.picker selectedRowInComponent: 1];
    
    NSDictionary *t = [self.arregloCategoria objectAtIndex:reng1];
    NSString *valor1 = [t objectForKey:@"nombreCat"];
    NSString *valor2 = [self.arregloDif objectAtIndex:reng2];
    
    self.tfDif.text = [NSString stringWithFormat:@"%@",valor2];
    self.tfCat.text = [NSString stringWithFormat:@"%@",valor1];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if( component == 0 ){
        NSDictionary *t = [self.arregloCategoria objectAtIndex:row];
        return [t objectForKey:@"nombreCat"];
    }
    else if (component == 1)
        return [self.arregloDif objectAtIndex:row];
    return nil;
}


 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([[segue identifier] isEqualToString:@"idJugar"]){
         JugarViewController *jvc = [segue destinationViewController];
         long reng1 = [self.picker selectedRowInComponent: 0];
         long reng2 = [self.picker selectedRowInComponent: 1];
         NSDictionary *t = [self.arregloCategoria objectAtIndex:reng1];
         
         
         NSString *valor1 = [t objectForKey:@"nombreCat"];
         NSString *valor2 = [self.arregloDif objectAtIndex:reng2];
         jvc.stCategoria = valor1;
         jvc.stDificultad = valor2;
         
         // Sólo funciona con 2nda categoría
         jvc.diccionarioPalabras = [[self.arregloPList objectAtIndex:1] mutableCopy];
         jvc.vc = self;
         jvc.idCategoria = [[t objectForKey:@"idCat"] integerValue];
     }
     
 }

-(void) quitarVistas{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(IBAction) unwind	:(UIStoryboardSegue *)segue{
    
}

@end
