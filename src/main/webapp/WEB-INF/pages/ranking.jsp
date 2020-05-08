<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<style>
    body{
        background-image: url("static/imgs/upload_image.png");
       background-size: 100% 100%;
    }
</style>
<body class="container" style="width:40%;text-align: center" onload="refresh()"><br>
<div><h5>排行榜</h5></div><br>
<div class="p-3 mb-2 bg-danger text-dark" style="height:8%; ">
    <span style="position:absolute;left:37%;">排名</span>
    <span style="position:absolute;left:42%;">用户</span>
    <span style="position:absolute;left:50%;">用户名</span>
    <span style="position:absolute;left:63%;">积分</span>
</div>
<div id="biuuu_city_list"></div>
</div>
<div id="demo20"></div>

</body>
<script>
    function refresh() {
        $.ajax({
            url: 'findintegral',
            success: function (data) {
                console.log(data);
                layui.use(['laypage', 'layer'], function () {
                    var laypage = layui.laypage
                        , layer = layui.layer;

                    //测试数据
                    var adddata = [];

                    for (var i = 0; i < data.length; i++) {
                        var j;
                        switch(i){
                            case 0 : j ="p-3 mb-2 bg-primary text-white";break;
                            case 1 : j ="p-3 mb-2 bg-warning text-white";break;
                            case 2 : j ="p-3 mb-2 bg-success text-white";break;
                            default : j="p-3 mb-2 bg-secondary text-white";break;
                        }
                        var k=i+1;
                        adddata.push(
                            '<div class="'+j+'" style="height:10%; " ><span style="position:absolute;left:37%;">'+k+'</span>'+
                            '<span style="position:absolute;left:42%;"><img src="uploads/'+data[i].uimage+'" style="height: 35px;width: 35px"> </span>' +
                            '<span style="position:absolute;left:50%;">'+data[i].uname+'</span>' +
                            '<span style="position:absolute;left:63%;">'+data[i].uintegral+'</span></div>'
                        );
                    }
                    //调用分页
                    laypage.render({
                        elem: 'demo20'
                        ,limit:6
                        ,count: data.length
                        ,jump: function (obj) {
                            //模拟渲染
                            document.getElementById('biuuu_city_list').innerHTML = function () {
                                var arr = []
                                    , thisData = adddata.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
                                layui.each(thisData, function (index, item) {
                                    arr.push(item );
                                });
                                return arr.join('');
                            }();
                        }
                    });
                })
            }
        })
    }
</script>
</html>
