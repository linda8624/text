//
//  shoppingDetailVC.m
//  Test_ghs
//
//  Created by readtv on 15/8/14.
//  Copyright (c) 2015年 ghs.net. All rights reserved.
//

#import "shoppingDetailVC.h"

#import "YSAddressView.h"
#define ShoppingSendLocation @"shoppingSendLocation"
#define ShopType @"json"
#define Shop  @"shop"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define AddressTableFrame CGRectMake(15, 0, ScreenWidth, ScreenHeight)

@interface shoppingDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    
    UIView * _lightView;
    UIView * _addressTable;
    
    UITableView * _table;
    UILabel * _tableSelectItemLabel;
    
    
    NSInteger _tableIndex;
    
    NSMutableArray * _arrCityArr;
    
    NSMutableArray * _provinceArr; //省
    NSMutableArray * _cityArr; //市
    NSMutableArray * _areaArr; //区
    
    NSMutableArray * _tableTempArr;
    
    NSString * _provinceId;
    NSString * _cityId;
    NSString * _areaId;
    
    NSString * _provinceStr;
    NSString * _cityStr;
    NSString * _areaStr;
    
}
@property (nonatomic, strong) YSAddressView *addressView;
@end

@implementation shoppingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _table.tableFooterView = [[UIView alloc] init];
    
    [self configUI];
    
    [self configTableCity];
    
    [self addRightBarBtn];
}

- (void)setModel:(BAMyAddressModel *)model{
    _model = model;
}
// 创建右边的按钮
- (void)addRightBarBtn{
    NSString *str = @"新增";
    if (self.isEdit) {
        str = @"编辑";
    }
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(addNewAddress)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
// 新增
- (void)addNewAddress{
    
    NSString *addressId = @"";
    if (self.isEdit) {
        addressId = self.model.addressId;
    }
    NSString *cityStr = [NSString stringWithFormat:@"%@%@",self.addressView.city.titleLabel.text,self.addressView.cityDetail.text];
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":@"201706070000000010000000003",
                                 @"addressId":addressId,
                                 @"contact":self.addressView.name.text,
                                 @"phone":self.addressView.phone.text,
                                 @"address":cityStr,
                                 @"isDefault":@"",
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_AddOrEditAddress];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
- (NSData *)backDataWithPath:(NSString *)path  type:(NSString *)type{
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:type]];
    NSLog(@"path%@ --- type%@", path, type);
    return data;
}

- (void)configTableCity {
    
    _lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _lightView.hidden = YES;
    _lightView.backgroundColor = [UIColor lightGrayColor];
    _lightView.alpha = 0.5f;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSuperView:)];
    [_lightView addGestureRecognizer:swipe];
    [self.view addSubview:_lightView];
    
    
    _addressTable = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth - 15, ScreenHeight)];
    [self.view addSubview:_addressTable];
    
    _tableIndex = 0;
    
    UIColor *color = [UIColor brownColor];
    
    _tableSelectItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 15, 50)];
    _tableSelectItemLabel.backgroundColor = color;
    _tableSelectItemLabel.textAlignment = NSTextAlignmentCenter;
    [_addressTable addSubview:_tableSelectItemLabel];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth - 15, ScreenHeight - 50) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    [_addressTable addSubview:_table];
    
    _arrCityArr = [[NSMutableArray alloc] init];
    NSData * data = [self backDataWithPath:Shop type:ShopType];
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    [_arrCityArr addObject:JsonObject];
    
    NSLog(@"_arrCityArr.count=%ld", _arrCityArr.count);
    
    _provinceArr = [[NSMutableArray alloc] initWithArray:_arrCityArr[0][0]];
    
    _cityArr = [[NSMutableArray alloc] initWithArray:_arrCityArr[0][1]];
    
    _areaArr = [[NSMutableArray alloc] initWithArray:_arrCityArr[0][2]];
    
    
    NSLog(@"_provinceArr[0] = %@",  _provinceArr[0]);
    
      NSLog(@"_cityArr[0] = %@",  _cityArr[0]);
    
    
      NSLog(@"_areaArr[0] = %@",  _areaArr[0]);
    NSLog(@"_areaArr.count=%ld",_areaArr.count);
    
    //真正在table上显示的是这个数据
    _tableTempArr = [[NSMutableArray alloc] initWithArray:_provinceArr];
    [_tableTempArr addObjectsFromArray:_provinceArr];
    
    [_table reloadData];

    
}

- (void)backSuperView:(UISwipeGestureRecognizer *)swip {
    [self hideAddressView];
   
}

- (void)hideAddressView {
    [UIView animateWithDuration:0.3f animations:^{
        _addressTable.frame = CGRectMake(ScreenWidth, 0, ScreenWidth - 15, ScreenHeight);
        
    } completion:^(BOOL finished) {
       _lightView.hidden = YES;
    }];
}
- (void)showAddressView {
    
    _lightView.hidden = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
        _addressTable.frame = CGRectMake(15, 0, ScreenWidth - 15, ScreenHeight);
//        _lightView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _tableTempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndentifiter = nil;
    
    NSString * cityTempStr = nil;
    
    NSLog(@"\n\nindex=%ld\n",(long)indexPath.row);
    
    if(_tableIndex == 0) {
        cellIndentifiter = @"cell0";
        cityTempStr = _tableTempArr[indexPath.row][@"name"];
    }
    else if(_tableIndex == 1) {
        cellIndentifiter = @"cell1";
        cityTempStr = _tableTempArr[indexPath.row][@"name"];
    }
    else {
        cellIndentifiter = @"cell2";
        cityTempStr = _tableTempArr[indexPath.row][@"DisName"];
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifiter];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifiter];
    }
    
    NSLog(@"cityTempStr=%@", cityTempStr);
    
    cell.textLabel.text = cityTempStr;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  

    if(_tableIndex == 0) {
        
        _provinceId = _tableTempArr[indexPath.row][@"ProID"];
        _provinceStr = _tableTempArr[indexPath.row][@"name"];
       
         [_tableTempArr removeAllObjects];
        [_tableTempArr addObjectsFromArray:[self getArrWithSourceArr:_cityArr withConditionStr:@"ProID" result:_provinceId]];
        
        NSLog(@"%d", (int)_tableTempArr.count);
        if(_tableTempArr.count <=0 )
        {
            [_tableTempArr removeAllObjects];
            [_tableTempArr addObjectsFromArray:_provinceArr];

        }
        
         [_table reloadData];
        [_table setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _tableSelectItemLabel.text = _provinceStr;
        
    }
    else if(_tableIndex == 1) {
        _cityId = _tableTempArr[indexPath.row][@"CityID"];
        _cityStr = _tableTempArr[indexPath.row][@"name"];
        
         [_tableTempArr removeAllObjects];
        [_tableTempArr addObjectsFromArray:[self getArrWithSourceArr:_areaArr withConditionStr:@"CityID" result:_cityId]];
        
        
        if(_tableTempArr.count <=0 )
        {
            [_tableTempArr removeAllObjects];
            [_tableTempArr addObjectsFromArray:_provinceArr];
            
        }
        
         [_table reloadData];
        [_table setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _tableSelectItemLabel.text = [NSString stringWithFormat:@"%@ %@", _provinceStr, _cityStr];
    }
    else {
        _areaId = _tableTempArr[indexPath.row][@"Id"];
        _areaStr = _tableTempArr[indexPath.row][@"DisName"];
        NSLog(@"~~~~~可以了~~~~");
        NSLog(@"provinceStr=%@   cityStr=%@      provinceStr=%@", _provinceStr, _cityStr, _areaStr);
        _tableIndex = - 1;
        
        //self.view over data
        [self.addressView.city setTitle:[NSString stringWithFormat:@" %@ %@ %@", _provinceStr, _cityStr, _areaStr] forState:UIControlStateNormal];
        
        [self hideAddressView];
        [_tableTempArr removeAllObjects];
        [_tableTempArr addObjectsFromArray:_provinceArr];
        [_table reloadData];
        [_table setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _tableSelectItemLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _provinceStr, _cityStr, _areaStr];

    }
    
    _tableIndex ++;
    
    
    
}




#pragma mark - ~~~~~~~~~~~ 从数组中，查找对应的数据 ~~~~~~~~~~~~~~~
- (NSArray *)getArrWithSourceArr:(NSArray *)sourceArr withConditionStr:(NSString *)condition result:(NSString *)result {
    
            NSLog(@"condition=%@", condition);
            NSLog(@"result=%@", result);
    
    
    __block NSMutableArray * tempArr = [[NSMutableArray alloc] init];
    [sourceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"obj=%@", obj);
//        NSLog(@"obj[condition] = %@。。 name=%@", obj[condition], obj[@"name"]);
        NSLog(@"idx =%lu \n", (unsigned long)idx);
        NSString * tempStr = obj[condition];
        
        if([result integerValue] == [tempStr integerValue]) {
            [tempArr addObject:obj];
            NSLog(@"obj[condition] = %@。。 name=%@", obj[condition], obj[@"name"]);
        }
        
    }];
    
    NSLog(@"tempArr=%@", tempArr);
    return tempArr;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}



- (void)configUI {
    YSAddressView *addressView = [[YSAddressView alloc] init];
    addressView.frame = CGRectMake(0, 84, BA_SCREEN_WIDTH, BA_SCREEN_HEIGHT);
    [addressView.city addTarget:self action:@selector(showTableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addressView = addressView;
    
    self.addressView.name.text = self.model.contact;
    self.addressView.phone.text = self.model.phone;
    self.addressView.cityDetail.text = self.model.address;
    [self.view addSubview:addressView];
}
- (void)showTableButtonClick:(id)sender {
    
    NSLog(@"sss");
    [self showAddressView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
