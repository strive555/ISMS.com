<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/16
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%session.invalidate();%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<style>
    body {
        background: rgb(57,61,73);
        background-image: url("static/imgs/2019.gif");
        background-size: 100% 100%;
    }
    .login-container {
        width: 380px;
        height: 280px;
        border: 1px solid #dddddd;
        margin: auto;
        margin-top: 200px;
        border-radius: 10px;
    }
    .login-title {
        text-align: center;
        height: 40px;
        line-height: 40px;
        color: white;
        font-size: 18px;
        border-bottom: 1px solid #dddddd;
    }
</style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <div class="login-title">
            基于积分制的公司管理系统
        </div>
        <div class="layui-inline" style="color: white;">
            <div style="margin-top: 40px;">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                    <input type="text" name="adminname" id="adminname" class="layui-input">
                </div>
            </div>

            <div style="margin-top: 25px;">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="adminpwd" id="adminpwd"  class="layui-input">
                </div>
            </div>
        </div>
        <div style="text-align: center;margin-top:20px;">
            <button id="login-btn" style="width: 70%;" type="button" class="layui-btn layui-btn-normal layui-btn-radius">登录</button>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['layer'], function(){

        $('#login-btn').click(function(){
            $.ajax({
                type: 'post',
                url: 'admin/dologin',
                data: {
                    adminname : $('#adminname').val(),
                    adminpwd : $('#adminpwd').val(),
                },
                success:function(data){
                    console.log(data);
                    if(data=="1000"){
                        layer.msg('<h3>登录成功</h3>',{
                            time:1000
                        },function () {
                            location.href="admin_home";
                        })
                    }else if(data=="500"){
                        layer.msg('<h3>登录失败<br>账号或密码错误</h3>',{
                            time:2000
                        })
                    }else{
                        layer.msg('<h3>登录失败<br>该账户没有权限访问</h3>',{
                            time:2000
                        })
                    }
                }
            });
        })
    });
</script>

</html>
