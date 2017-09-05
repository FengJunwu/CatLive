//
//  ListenTimeSettingViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/22.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "ListenTimeSettingViewController.h"


@interface ListenTimeSetTableCell : UITableViewCell{

    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UIImageView *_choiceImage;
    
}
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation ListenTimeSetTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setType:(NSInteger)type {
    _type = type;
    switch (type) {
        case 0:{
            _titleLabel.text = @"该时段适用于";
            _choiceImage.hidden = YES;
        }
            break;
        case 1:{
            _titleLabel.text = @"周一至周五";
            _choiceImage.hidden = NO;
        }
            break;
        case 2:{
            _titleLabel.text = @"周六至周日";
            _choiceImage.hidden = NO;
        }
            break;
        case 3:{
            _titleLabel.text = @"每天";
            _choiceImage.hidden = NO;
        }
            break;
        case 4:{
            _titleLabel.text = @"任意时间";
            _choiceImage.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (_type != 0) {
        if (_currentIndex == _type) {
            _choiceImage.image = [UIImage imageNamed:@"choice"];
        } else {
            _choiceImage.image = [UIImage imageNamed:@"unChoice"];
        }
    }
}

@end


@interface ListenTimeSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource> {

    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_headerView;
    
    __weak IBOutlet UIPickerView *_fromPicker;
    
    __weak IBOutlet UIPickerView *_toPicker;
    
    NSInteger _currentSelect;
    NSArray *_dateArr;
}

@end

@implementation ListenTimeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"接听时间段";
    _currentSelect = 4;//默认为任意时间  或者登录信息里面有
    [self initRithtBar];
    _dateArr = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
}
- (void)initRithtBar {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 44);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonAction:(UIButton *)btn {

}


#pragma UIPickerViewDataSource 
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dateArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dateArr[row];
}




#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListenTimeSetTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListenTimeSetTableCell"];
    cell.type = indexPath.row;
    cell.currentIndex = _currentSelect;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        _currentSelect = indexPath.row;
        [_tableView reloadData];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


