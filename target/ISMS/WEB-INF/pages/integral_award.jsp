<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:41
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
<body class="container">
<table class="layui-hide" id="demo"></table>

<script>
    layui.use(['table','util'], function(){
        var table = layui.table
            ,util = layui.util;

        //展示已知数据
        table.render({
            elem: '#demo'
            ,url:'findMyEvent'
            , cols: [[ //标题栏
                {field: 'id', title: '数量', width: '10%', sort: true}
                , {field: 'event', title: '事件', width:'55%'}
                , {field: 'integral', title: '积分情况', width: '15%', sort: true}
                , {field: 'time', title: '时间', width: '20%',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
            ]]
        })
    });
</script>
</body>
</html>
