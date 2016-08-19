function shareFun() {
    var _title = 1;
    var _content = 2;
    var _shareUrl = 'http://www.baidu.com';
    var options = ('title:' + _title + ',content:' + _content + ',shareUrl:' + _shareUrl).toString();
    performSelector(options);
}