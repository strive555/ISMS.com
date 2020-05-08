<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/26
  Time: 22:10
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
<form class="layui-form">
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">消息主题</label>
        <div class="layui-input-block">
            <input type="text" id="theme" lay-verify="required" lay-reqtext="消息主题是必填项，岂能为空？" autocomplete="off" placeholder="请输入标题" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">消息类型</label>
        <div class="layui-input-block" >
            <input type="radio" name="type" value="公告" title="公告"checked=""lay-filter="radio1" >
            <input type="radio" name="type" value="紧急任务" title="紧急任务"lay-filter="radio1" >
            <input type="radio" name="type" value="日常任务" title="日常任务"lay-filter="radio1"
            >
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label" style="width: 100px">正文内容</label>
        <div class="layui-input-block">
            <textarea id="content" placeholder="请输入内容" class="layui-textarea" lay-verify="required" lay-reqtext="消息主题是必填项，岂能为空？"></textarea>
        </div>
    </div>
    <div class="layui-input-block">
    <div class="layui-upload">
        <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
        <button type="button" class="layui-btn layui-btn-normal" id="testListAction" style="display: none"></button>
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
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <a type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</a>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>



<script>
    layui.use(['form', 'layedit', 'laydate','upload'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,$ = layui.jquery
            ,upload = layui.upload;

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 5){
                    return '标题至少得5个字符啊';
                }
            }
            ,pass: [
                /^[\S]{6,12}$/
                ,'密码必须6到12位，且不能出现空格'
            ]
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });


        //监听提交
        form.on('submit(demo1)', function(data) {
            var type=document.getElementsByName("type");
            for(var i=0;i<type.length;i++){
                if(type[i].checked){
                    var type=type[i].value;
                }
            }
            $('#testListAction').click();
           $.ajax({
               type:'post',
               url:'admin/addnotice',
               data:{
                   type:type,
                   theme:$('#theme').val(),
                   content:$('#content').val(),
                   time:new Date()
               },
               success:function(data){
                   layer.msg("发布成功");
               }
           })
        });


        //表单取值
        layui.$('#LAY-component-form-getval').on('click', function(){
            var data = form.val('example');
            alert(JSON.stringify(data));
        });

        //多文件列表示例
        var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
            elem: '#testList'
            ,url: 'admin/uploadDocs' //改成您自己的上传接口
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
