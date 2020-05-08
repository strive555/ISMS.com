<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/7
  Time: 17:28
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
<body>
<div class="demoTable">
    <div class="layui-inline">
        <input class="layui-input"  id="admin_name" autocomplete="off" placeholder="根据用户名">
    </div>
    <button class="layui-btn" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>
<table class="layui-hide" id="super" lay-filter="test"></table>
<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    </div>
</script>
    <div id="admin" style="display: none;width: 300px;">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:100px">账号</label>
            <div class="layui-input-block" style="width:300px;margin-top: 20px;">
                <input type="text" id="adminname"  required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="width:100px">密码</label>
            <div class="layui-input-block" style="width:300px">
                <input type="text" id="adminpwd"  lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
<script type="text/html" id="barDemo">

    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="barDemo1">
    <a>超级管理员不可操作</a>
</script>
<script>
    layui.use(['table', 'util'], function () {
        var table = layui.table
            , util = layui.util;

        table.render({
            elem: '#test'
            , url: 'admin/findAllAdmin'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , title: '管理员数据表'
            , cols: [[
                {field: 'id', title: 'ID', width: '15%', fixed: 'left', unresize: true, sort: true}
                , {field: 'adminname', title: '用户名', width: '20%', edit: 'text'}
                , {field: 'adminpwd', title: '密码', width: '20%', edit: 'text'}
                , {
                    field: 'time', title: '注册时间', width: '30%', templet: function (d) {
                        return util.toDateString(d.time, "yyyy-MM-dd HH:mm:ss")
                    }
                }
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: '15%'}
            ]]
            , page: true
        });
        table.render({
            elem: '#super'
            , url: 'admin/findSuperAdmin'
            , cols: [[
                {field: 'id', title: '超级管理员', width: '15%', fixed: 'left', unresize: true}
                , {field: 'adminname', title: '用户名', width: '20%', edit: 'text'}
                , {field: 'adminpwd', title: '密码', width: '20%', edit: 'text'}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo1', width: '45%'}
            ]]
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    $('#adminname').val('');
                    $('#adminpwd').val('');
                    layer.open({
                        title: '新增',
                        type: 1,
                        btn: ['确定', '取消'],
                        content: $('#admin'),
                        area:['500px','300px'],
                        yes: function (index, layero) {
                            $.ajax({
                                type:'post',
                                url:'admin/AddAdmin',
                                data:{
                                    adminname:$('#adminname').val(),
                                    adminpwd:$('#adminpwd').val(),
                                    time:new Date()
                                },
                                success:function (data) {
                                    if(data=="1000"){
                                        layer.msg("注册成功",{
                                            time:1000
                                        },function () {
                                            layer.closeAll();
                                        });
                                    }else{
                                        layer.msg("注册失败：该账号已注册过");
                                    }
                                }

                            })
                        }

                    })
                    break;
            };
        });

        $('#find').click(function () {
            table.reload('test',{
                url:'admin/findAllAdmin'
                ,where:{
                    adminname:$('#admin_name').val()
                }
            })
        })
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            //console.log(obj)
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                    $.ajax({
                        type:'post',
                        url:'admin/DeleteAdmin',
                        data:{
                            id:data.id
                        },
                        success:function (data1) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if (obj.event === 'edit') {
                $('#adminname').val(data.adminname);
                $('#adminpwd').val(data.adminpwd);
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#admin'),
                    area:['500px','300px'],
                    yes: function (index, layero) {
                        if ($('#adminname').val()==data.adminname){
                            var admin="";
                        }else{
                            var admin=$('#adminname').val();
                        }
                        $.ajax({
                            type:'post',
                            url:'admin/UpdateAdmin',
                            data:{
                                adminname:admin,
                                adminpwd:$('#adminpwd').val(),
                                id:data.id
                            },
                            success:function (data2) {
                                if(data2=="1000"){
                                    layer.msg("编辑成功",{
                                        time:1000
                                    },function () {
                                        layer.closeAll();
                                    });
                                }else{
                                    layer.msg("编辑失败：该用户名已存在，请更换新的用户名");
                                }
                            }

                        })
                    }

                })
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
