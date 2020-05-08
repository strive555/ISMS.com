<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/18
  Time: 9:35
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
        <input class="layui-input"  id="id" autocomplete="off" placeholder="根据商品id">
    </div>
    <div class="layui-inline">
        <input class="layui-input" id="cname" autocomplete="off" placeholder="根据商品名">
    </div>
    <div class="layui-inline">
        <input class="layui-input" id="cintegral" autocomplete="off" placeholder="根据积分">
    </div>
    <button class="layui-btn" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>
<table class="layui-hide" id="test" lay-filter="test"></table>
<form id="f" method="post" enctype="multipart/form-data">
<div id="editGoods" style="display: none;width: 350px;">
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">商品名</label>
        <div class="layui-input-block" style="width:200px;margin-top: 20px;">
            <input type="text" id="name"  required lay-verify="required" placeholder="商品"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"style="width:100px">详情</label>
        <div class="layui-input-block" style="width:200px">
            <input type="text" id="introduce"  required lay-verify="required" placeholder="所有权归六合敬所有" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">所需积分</label>
        <div class="layui-input-block" style="width:200px">
            <input type="text" id="integral"  required lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"style="width:100px">图片</label>
        <div class="layui-input-inline">
            <input id="file" type="file" name="image" onchange="replace_image(0)"  style="display:none;">
            <img id="image" name="image"onclick="click_image()" style="cursor:pointer;height:88px;width:88px"src="static/imgs/upload_image.png">
            <div class="layui-form-mid layui-word-aux"  id="inputImg">点击上传图片</div>
        </div>
    </div>
</div>
</form>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    </div>
</script>
<script type="text/html" id="commodity">
   <img src="uploads/{{d.image}}" style="height: 30px;width: 30px">
</script>
<script type="text/html" id="tablestate">
<input type="checkbox" id="state" name="state" value="{{d.state}}" lay-skin="switch" lay-text="是|否" lay-filter="stateDemo" {{ d.state == "on" ? 'checked' : '' }}>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon"></i></a>
</script>

<script>
    layui.use(['table','form' ],function(){
        var table = layui.table,
        form = layui.form;

        table.render({
            elem: '#test'
            ,url:'admin/findallshopping'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height:545
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:'10%', fixed: 'left', unresize: true, sort: true}
                ,{field:'image', title:'图片', width:'6.5%',templet:'#commodity'}
                ,{field:'name', title:'商品名称', width:'20%', edit: 'text'}
                ,{field:'integral', title:'所需积分', width:'10%', edit: 'text'}
                ,{field:'introduce', title:'详情', width:'30%', edit: 'text',sort: true}
                ,{field:'state', title:'上架', width:'10%',templet:'#tablestate',unresize: true}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'10%'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'add':
                    $('#name').val('');
                    $('#integral').val('');
                    $('#introduce').val('');
                    document.getElementById('image').src="";
                    layer.open({
                        title: '新增',
                        type: 1,
                        btn: ['确定', '取消'],
                        content: $('#editGoods'),

                        yes: function (index, layero) {
                            var formdata = new FormData();
                            formdata.append("name",$('#name').val());
                            formdata.append("integral",$('#integral').val());
                            formdata.append("introduce",$('#introduce').val());
                            formdata.append("image",document.getElementById('file').files[0]);
                            $.ajax({
                                cache:false,
                                type: 'post',
                                url: 'admin/addshopping',
                                data:formdata,
                                processData:false,
                                contentType:false,
                                success:function(data){
                                    console.log(data);
                                    if(data=="1000"){
                                        layer.msg('添加成功',{
                                            time:1500
                                        },function(){
                                            layer.closeAll();
                                        });
                                        // location.href="goods.html"

                                    }

                                }
                            })
                        }
                    });
                    break;
            };
        });

        $('#find').click(function () {
            if ($('#id').val()==""){
                var id=0;
            }else{
                var id=$('#id').val();
            }

            table.reload('test',{
                url:'admin/findallshopping'
                ,where:{
                    id:id,
                    name:$('#cname').val(),
                    integral:$('#cintegral').val(),

                }
            })
        })
        //监听性别操作
        form.on('switch(stateDemo)',function(obj){
            var data = $(obj.elem);
            var id=data.parents('tr').first().find('td').eq(1).text();
            console.log(data);
            var state = this.value;
            console.log(state);
            if (state == "on") {
                state = "null";
            } else {
                state = "on";
            }
            ;
            $.ajax({
                type: 'post',
                url: 'admin/UpdateState',
                data: {
                    state: state,
                    id: id
                },
                success: function (data) {
                    if (state=="on"){
                        layer.msg("上架成功");
                        table.reload('test',{
                            url:'admin/findallshopping'
                            ,where:{
                            }
                        })
                    }else{
                        layer.msg("下架成功");
                        table.reload('test',{
                            url:'admin/findallshopping'
                            ,where:{
                            }
                        })
                    }

                }
            })

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
                        url:'admin/removeshopping',
                        data:{
                            id:data.id
                        },
                        success:function (data) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                $('#name').val(data.name);
                $('#integral').val(data.integral);
                $('#introduce').val(data.introduce);
                document.getElementById('image').src="uploads/"+data.image;
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#editGoods'),

                    yes: function (index, layero) {
                        var img="http://localhost:8080/ISMS/uploads/";
                        var formdata = new FormData();
                        formdata.append("name",$('#name').val());
                        formdata.append("integral",$('#integral').val());
                        formdata.append("introduce",$('#introduce').val());
                        formdata.append("id",data.id);
                        if(document.getElementById('image').src==img+data.image){
                            formdata.append("image",data.image);
                            $.ajax({
                                type: 'post',
                                url: 'admin/updateshopping',
                                data:formdata,
                                processData:false,
                                contentType:false,
                                success:function(data){
                                    console.log(data);
                                    if(data=="1000"){
                                        layer.msg('修改成功',{
                                            time:1500
                                        },function(){
                                            layer.closeAll();
                                        });
                                    }
                                }
                            })
                        }else{
                            formdata.append("image",document.getElementById('file').files[0]);
                            $.ajax({
                                type: 'post',
                                url: 'admin/updateshoppingimg',
                                data:formdata,
                                processData:false,
                                contentType:false,
                                success:function(data){
                                    console.log(data);
                                    if(data=="1000"){
                                        layer.msg('修改成功',{
                                            time:1500
                                        },function(){
                                            layer.closeAll();
                                        });
                                    }
                                }
                            })
                        }

                    }
                });
            }
        });
    });
    function click_image(){
        $("#file").click();
    }
    function replace_image(){
        $("#inputImg").hide();
        // 获得图片对象
        var image = $("#file")[0].files[0];
        var url = window.URL.createObjectURL(image);
        console.log(url);
        // 替换image
        $("#image").attr("src",url);
        console.log($("#file").val());
    }
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
