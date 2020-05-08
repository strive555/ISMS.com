<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/8
  Time: 18:19
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
    <legend>角色授权（系统用户)</legend>
</fieldset>
<div id="test4" class="demo-transfer" style="position:relative;left: 10%;top:12%"></div>
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
            url: 'admin/FindAllUser',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    data1.push(
                        {"value": data[i].id, "title": data[i].name}
                    )
                }
                for (var i = 0; i < data.length; i++) {
                    if (data[i].empower == 1) {
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
                                    url: 'admin/UpdateEmpower',
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
                                    url: 'admin/UpdateEmpower',
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
    function Login() {
        var id='<%=session.getAttribute("adminid")%>';
        if(id=="null" || id==""){
            location.href="admin_login";
        }
    }
    setInterval("Login()",1000);
</script>

</body>
</html>
