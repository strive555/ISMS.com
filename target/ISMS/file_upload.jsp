<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/6
  Time: 23:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://www.layuicdn.com/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="https://www.layuicdn.com/layui/layui.js"></script>
</head>

<body class="container">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
    <legend>文件上传栏</legend>
</fieldset>
<div class="layui-upload">
    <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
    <button type="button" class="layui-btn" id="testListAction">开始上传</button>
    <div class="layui-upload-list">
        <table class="layui-table">
            <thead>
            <tr><th>文件名</th>
                <th>大小</th>
                <th>状态</th>
                <th>操作</th>
            </tr></thead>
            <tbody id="demoList"></tbody>
        </table>
    </div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
    <legend>文件记录栏</legend>
</fieldset>
<table class="layui-hide" id="test"></table>
<script type="text/html" id="files">
<a href="AdminUploads/{{d.files}}">{{d.files}}</a>
</script>
<script>
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;
        //多文件列表示例
        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: 'Fileupload' //改成您自己的上传接口
            ,accept: 'file'
            ,multiple: true
            ,auto: false
            ,bindAction: '#testListAction'
            ,choose: function(obj){
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1024).toFixed(1) +'kb</td>'
                        ,'<td>等待上传</td>'
                        ,'<td>'
                        ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                        ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                        ,'</td>'
                        ,'</tr>'].join(''));

                    //单个重传
                    tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delete files[index]; //删除对应的文件
                        tr.remove();
                        uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                    });

                    demoListView.append(tr);
                });
            }
            ,done: function(res, index, upload){
                if(res.code==0){ //上传成功
                    var tr = demoListView.find('tr#upload-'+ index)
                        ,tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                    tds.eq(3).html(''); //清空操作
                    return delete this.files[index]; //删除文件队列已经上传成功的文件
                }
                this.error(index, upload);
                console.log(res);
                console.log(index);
                console.log(upload);
            }
            ,error: function(index, upload){
                var tr = demoListView.find('tr#upload-'+ index)
                    ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
                console.log(index);
                console.log(upload);
            }
        });
    });

    layui.use(['table','util'], function(){
        var table = layui.table,
        util = layui.util;
        var uid='<%=session.getAttribute("userid")%>'
        table.render({
            elem: '#test'
            ,url:'findMyFiles?uid='+uid
            ,cols: [[
                {type:'checkbox'}
                ,{field:'id', width:'10%', title: 'ID', sort: true}
                ,{field:'files', width:'68%', title: '文件名称',templet:'#files'}
                ,{field:'time', width:'17.7%', title: '上传的时间',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
            ]]
            ,page: true
        });
    });
</script>
</body>
</html>
