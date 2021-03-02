# currency_conventer

A new Flutter project.

## Getting Started

Cơ chế: 
1. Provider gọi api từ BusinessService -> safeCall ở BusinessService bắt lỗi Expired Token và call Refresh bằng refresh_token
2. Nếu refresh thành công sẽ được trả về refresh_token và access_token mới, lưu lại và gọi lại api đã bị thất bại một lân nữa với token mới.
3. Nếu refresh thất bại lần thứ 2(api refresh bị Expired Token, tức là cả 2 token đều expired) => dùng navigator key để văng app ra màn hình đăng nhập
