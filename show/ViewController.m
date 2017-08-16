//
//  ViewController.m
//  show
//
//  Created by 李振彪 on 2017/8/15.
//  Copyright © 2017年 李振彪. All rights reserved.
//

#import "ViewController.h"
#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)
@interface ViewController ()<UIAlertViewDelegate>
{
    UIWebView *web;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    web.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:web];
    [self saveURL:@"https://www.baidu.com"];
    [self quest];
    
    UIView *sta = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    sta.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:sta aboveSubview:web];

    
    UIButton *btn1 = [self btn:kScreen_Height-100 tag:0 text:@"刷新"];
    UIButton *btn2 = [self btn:kScreen_Height-150 tag:1 text:@"地址"];

    
}

-(UIButton *)btn:(CGFloat)y tag:(NSInteger)tag text:(NSString *)text{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(kScreen_Width-50, y, 45, 40)];
    [btn setTitle:text forState:0];
    [btn.layer setBorderColor:[UIColor redColor].CGColor];
    [btn.layer setBorderWidth:1];
    [btn setTitleColor:[UIColor redColor] forState:0];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:btn aboveSubview:web];
    return btn;
}
- (void)btnAction:(UIButton *)sender{
  
    if (sender.tag == 0) {
        [self quest];
    }else{
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"更换地址" message:@"完整地址包含【http://】或者【https://】，否则无法访问" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        al.alertViewStyle = UIAlertViewStylePlainTextInput;
        [al show];
        
    }
}

-(void)saveURL:(NSString *)str{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:str forKey:@"url"];
    [user synchronize];

}

- (void)quest{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str = [user valueForKey:@"url"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:str]];
    [web loadRequest:request];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        NSLog(@"aisdfasog_%@",nameField.text);
        [self saveURL:nameField.text];
        [self quest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
