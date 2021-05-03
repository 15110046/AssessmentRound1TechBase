# AssessmentRound1TechBase

## Coding Challenge - TechBase

## Cấu trúc Folder

- AssessmentRound1TechBase(Project) 
- SubModules(các module độc lập được tách biệt để sử dụng cho các project/target khác sau này)
    + TBVCommon     
    + TBVExtensions 
    + TBVNetWork
             
## Libs sử dụng

- 'Alamofire-SwiftyJSON', '3.0.0'
- 'Alamofire', '4.9.0'
- 'HNImageView', '0.3.3'
- 'FPSCounter', '~> 4.1' 
- 'SwiftLint'

## Thắc mắc

  - API chưa chuẩn format(thiếu message, status...)
  - API thiếu biến thông báo cho client biết khi nào dừng request fetching more data
  - API trả ra hình size quá lớn, việc download 1 tấm hình size 4000x4000 tốn rất nhiều băng thông. Và việc display những
tấm hình size cực lớn như này rất dễ bị tràn mem, dưới client(mobile) size hiển thị trên iPad 12.9 inch cũng chỉ display
được 1024x1366 nên lúc này phải resize tấm hình về kích thước nhỏ hơn nó rất nhiều, việc này sẽ làm CPU tăng cao. -> đề 
xuất API support trả ra hình có kích thước tương đối hơn


## Một số tính năng cải thiện trải nghiệm người dùng chưa làm
  - Preload URL hình 
    + Ưu điểm: có trải nghiệm App tốt hơn 
    + Nhược điểm: Tốn băng thông người dùng
    
  - Cache hình
    + Ưu điểm: giúp người dùng không tốn nhiều băng thông để load ảnh
    + Nhược điểm: Disk của device sẽ tăng đáng kể, nếu không clean hợp lý sẽ ảnh hưởng nhiều tới người dùng khi thiết bị 
    của họ có dung lượng chỉ vỏn vẹn 16GB
  
  Lý do: Không đủ thời gian
