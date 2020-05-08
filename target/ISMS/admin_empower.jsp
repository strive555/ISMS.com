<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/7
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>授权（登录|全部功能)</legend>
</fieldset>
<div id="test4" class="demo-transfer" style="position:absolute;left: 55%;top:22%"></div>
<div id="test5" class="demo-transfer" style="position:absolute;left: 10%;top:22%"></div>
</body>
<script>
    layui.use(['laydate','layer','transfer', 'util'], function() {
        var laydate = layui.laydate
            , layer = layui.layer
            , $ = layui.$
            , transfer = layui.transfer
            , util = layui.util;

        var data1 = [];
        var data2 = [];
        $.ajax({
            type: 'post',
            url: 'admin/FindAllAdminEmpower',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    data1.push(
                        {"value": data[i].id, "title": data[i].adminname}
                    )
                }
                for (var i = 0; i < data.length; i++) {
                    if (data[i].adminempower == 1) {
                        data2.push(
                            data[i].id
                        )
                    }
                }
                console.log(data2);
                //显示搜索框
                transfer.render({
                    elem: '#test4'
                    , data: data1
                    , title: ['全部选中', '全部选中']
                    , value: data2
                    , showSearch: true
                    , onchange: function (obj, index) {
                        var arr = ['左边', '右边'];
                        for (var i = 0; i < obj.length; i++) {
                            if (arr[index] == "左边") {
                                $.ajax({
                                    type: 'post',
                                    url: 'admin/UpdateAdminadminEmpower',
                                    data: {
                                        adminempower: 1,
                                        id: obj[i].value
                                    },
                                    success: function (res) {
                                        layer.msg('<img src="static/layui/images/face/11.gif">' + "授权成功");
                                    }
                                });
                            } else {
                                $.ajax({
                                    type: 'post',
                                    url: 'admin/UpdateAdminadminEmpower',
                                    data: {
                                        adminempower: 0,
                                        id: obj[i].value
                                    },
                                    success: function (res) {
                                        layer.msg('<img src="static/layui/images/face/11.gif">' + "撤销权限成功");
                                    }
                                })
                            }
                        }

                    }
                });
            }
        });
        var data3 = [];
        var data4 = [];
        $.ajax({
            type: 'post',
            url: 'admin/FindAllAdminEmpower',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    data3.push(
                        {"value": data[i].id, "title": data[i].adminname}
                    )
                }
                for (var i = 0; i < data.length; i++) {
                    if (data[i].empower == 1) {
                        data4.push(
                            data[i].id
                        )
                    }

                }
                console.log(data4);
                //显示搜索框
                transfer.render({
                    elem: '#test5'
                    , data: data3
                    , title: ['全部选中', '全部选中']
                    , value: data4
                    , showSearch: true
                    , onchange: function (obj, index) {
                        var arr = ['左边', '右边'];
                        for (var i = 0; i < obj.length; i++) {
                            if (arr[index] == "左边") {
                                $.ajax({
                                    type: 'post',
                                    url: 'admin/UpdateAdminEmpower',
                                    data: {
                                        empower: 1,
                                        id: obj[i].value
                                    },
                                    success: function (res) {
                                        layer.msg('<img src="static/layui/images/face/11.gif">' + "授权成功");
                                    }
                                });
                            } else {
                                $.ajax({
                                    type: 'post',
                                    url: 'admin/UpdateAdminEmpower',
                                    data: {
                                        empower: 0,
                                        id: obj[i].value
                                    },
                                    success: function (res) {
                                        layer.msg('<img src="static/layui/images/face/11.gif">' + "撤销权限成功");
                                    }
                                })
                            }
                        }
                    }
                });
            }
        });
    })
</script>
</html>
