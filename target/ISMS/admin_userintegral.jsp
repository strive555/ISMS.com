<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/28
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>

<body>
<div id="punish" style="display: none;width: 300px">
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label" style="width: 100px">正文内容</label>
        <div class="layui-input-block" >
            <textarea id="content"  style="width: 300px" placeholder="请输入内容" class="layui-textarea" lay-verify="required" lay-reqtext="积分规则说明是必填项，岂能为空？" ></textarea>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label" style="width: 100px">扣掉积分</label>
        <div class="layui-input-block" >
            <input id="integral"  class="layui-input" lay-verify="required" lay-reqtext="积分规则说明是必填项，岂能为空？">
        </div>
    </div>
</div>

<div class="demoTable">
    <div class="layui-inline">
        <input class="layui-input" id="findphone" autocomplete="off" placeholder="根据手机号">
    </div>
    <button class="layui-btn" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>
<table class="layui-hide" id="test" lay-filter="test"></table>
<form class="layui-form">
    <div id="editGoods" style="display: none;width: 350px;">
        <div class="layui-form-item">
            <label class="layui-form-label">总积分</label>
            <div class="layui-input-block" style="width:200px;margin-top: 20px;">
                <input type="text" id="user_integral"  required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商店可用积分</label>
            <div class="layui-input-block" style="width:200px">
                <input type="text" id="user_allintegral"  required lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
</form>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">

    </div>
</script>

<script type="text/html" id="userimg">
    <img src="uploads/{{d.uimage}}" style="height: 30px;width: 30px">
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon"></i></a>
</script>

<script>
    layui.use(['table','layer'], function(){
        var table = layui.table
            ,layer = layui.layer;

        table.render({
            elem: '#test'
            ,url:'admin/findAllUserIntegral'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height:545
            ,page: true
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:'6%', fixed: 'left', unresize: true, sort: true}
                ,{field:'uimage', title:'头像', width:'6%',templet:'#userimg'}
                ,{field:'uid', title:'用户ID', width:'10%', edit: 'text'}
                ,{field:'uname', title:'用户名', width:'10%', edit: 'text'}
                ,{field:'uphone', title:'手机号', width:'12%', edit: 'text'}
                ,{field:'uintegral', title:'总积分', width:'9%', edit: 'text',sort: true}
                ,{field:'allintegral', title:'商店可用积分', width:'10%',sort: true}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'33%'}
            ]]
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
            };
        });
        $('#find').click(function () {
            table.reload('test',{
                url:'admin/findAllUserIntegral'
                ,where:{
                    uphone:$('#findphone').val()
                }
            })
        })
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                    $.ajax({
                        type:'post',
                        url:'admin/deleteUserIntegral',
                        data:{
                            id:data.id
                        },
                        success:function (data) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                $('#user_integral').val(data.uintegral);
                $('#user_allintegral').val(data.allintegral);
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#editGoods'),
                    yes: function (index, layero) {
                            $.ajax({
                                type: 'post',
                                url: 'admin/updateUserIntegral',
                                data:{
                                    uintegral:$('#user_integral').val(),
                                    allintegral:$('#user_allintegral').val(),
                                    id:data.id
                                },
                                success:function(data){
                                        layer.msg('修改成功',{
                                            time:1500
                                        },function(){
                                            layer.closeAll();
                                        });
                                }
                            })
                    }
                });
            }
        });
    });
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
