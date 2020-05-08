<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/28
  Time: 19:03
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
<table class="layui-hide" id="test" style="height: 100px"></table>
<script type="text/html" id="img">
    <img src="uploads/{{d.cimage}}" style="height: 30px;width:30px;">
</script>

<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="state" value="{{d.state}}" title="完成" lay-filter="lockDemo" {{ d.state == "on" ? 'checked' : '' }}>
</script>
<script>
    layui.use(['table','util','form'], function(){
        var table = layui.table,
        util = layui.util
            ,form = layui.form;

        table.render({
            elem: '#test'
            ,url:'FindMyExchange'
            ,height:490
            ,cols: [[
                {field:'id', width:'10%', title: 'ID', sort: true}
                ,{field:'cname', width:'20%', title: '商品名'}
                ,{field:'cimage', width:'8%', title: '商品图片',templet:'#img'}
                ,{field:'cintegral', title: '商品积分',  width:'10%',sort: true}
                ,{field:'cintroduce', width:'27%', title: '商品详情'}
                ,{field:'time', width:'15%', title: '兑换时间',sort: true,templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{field:'state', title:'兑换情况', width:'10%', templet: '#checkboxTpl', unresize: true}
            ]]
            ,page: true
        });
        //监听锁定操作
        form.on('checkbox(lockDemo)', function(obj){
           layer.msg("操作失败：您没有权限操作");
        });
    });
</script>
</body>
</html>
