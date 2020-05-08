<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/7
  Time: 14:47
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
        <input class="layui-input"  id="uid" autocomplete="off" placeholder="根据用户id">
    </div>
    <div class="layui-inline">
        <input  class="layui-input"  id="filename" autocomplete="off" placeholder="根据文件名">
    </div>
    <button class="layui-btn" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>
<table class="layui-hide" id="test" lay-filter="test"></table>
<form>
    <div id="Allfile" style="display: none;width: 400px;">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:100px">用户名</label>
            <div class="layui-input-block" style="width:400px;margin-top: 20px;">
                <input type="text" id="uname"  required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="width:100px">文件名</label>
            <div class="layui-input-block" style="width:400px">
                <input type="text" id="file"  lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
</form>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="files">
    <a href="AdminUploads/{{d.files}}">{{d.files}}</a>
</script>
<script>
    layui.use(['table','util','layer'], function(){
        var table = layui.table
            ,util = layui.util
            ,layer = layui.layer;

        table.render({
            elem: '#test'
            ,url:'admin/findAllFiles'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height:545
            ,cols: [[
                {field:'id', title:'数量', width:'8%', fixed: 'left', unresize: true, sort: true}
                ,{field:'uid', title:'用户ID', width:'10%', edit: 'text', sort: true}
                ,{field:'uname', title:'用户名', width:'15%', edit: 'text'}
                ,{field:'files', title:'文件', width:'40%',templet:'#files'}
                ,{field:'time', title:'提交时间', width:'17%',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'10%'}
            ]]
            ,page: true
        });


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
                        url:'admin/deleteFiles',
                        data:{
                            id:data.id
                        },
                        success:function (data) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                $('#uname').val(data.uname);
                $('#file').val(data.files);
                layer.open({
                    title:'文件编辑',
                    type:1,
                    btn:['确定','取消'],
                    content:$('#Allfile'),
                    area:['600px','320px'],
                    yes:function (index, layero) {
                        $.ajax({
                            type:'post',
                            url:'admin/updateFiles',
                            data:{
                                uname:$('#uname').val(),
                                files:$('#file').val(),
                                id:data.id
                            },
                            success:function (data) {
                                layer.msg("编辑成功",{
                                    time:1000
                                },function () {
                                    layer.closeAll();
                                });
                            }
                        })
                    }
                })
            }
        });
        $('#find').click(function () {
            if ($('#uid').val()==""){
                var uid=0;
            }else{
                var uid=$('#uid').val();
            }

            table.reload('test',{
                url:'admin/findAllFiles'
                ,where:{
                    files:$('#filename').val(),
                    uid:uid,
                }
            })
        })
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
