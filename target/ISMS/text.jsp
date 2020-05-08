<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/9
  Time: 15:41
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
        <input class="layui-input"  id="findname" autocomplete="off" placeholder="根据用户名">
    </div>
    <div class="layui-inline" style="width: 200px">
        <select class="layui-input" id="findidentity" >
            <option value="">根据职位</option>
            <option value="普通职员" >普通职员</option>
            <option value="开发组长" >开发组长</option>
            <option value="人事职员">人事职员</option>
            <option value="研发经理">研发经理</option>
        </select>
    </div>
    <div class="layui-inline">
        <input class="layui-input" id="findphone" autocomplete="off" placeholder="根据手机号">
    </div>
    <button class="layui-btn" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>
<table class="layui-hide" id="test" lay-filter="test"></table>
<form class="layui-form">
    <div id="editGoods" style="display: none;width: 350px;">
        <div class="layui-form-item">
            <label class="layui-form-label">头像</label>
            <div class="layui-input-inline">
                <input id="file" type="file" name="image" style="display:none;" onChange="replace_image(0)"/>
                <img id="image" name="image" onclick="click_image()" style="cursor:pointer;margin-left: 20px" src="" height="100px" width="100px"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block" style="width:200px;margin-top: 20px;">
                <input type="text" id="name" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-block" style="width:200px">
                <input type="text" id="phone"  lay-verify="required" placeholder="用于账号登录" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">职位</label>
            <div class="layui-input-block" style="width:200px">
                <select id="identity">
                    <option value="">请选择</option>
                    <option value="普通职员" >普通职员</option>
                    <option value="开发组长" >开发组长</option>
                    <option value="人事职员">人事职员</option>
                    <option value="研发经理">研发经理</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block" style="width:200px">
                <input type="text" id="pwd"   lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:110px">籍贯（省）</label>
            <div class="layui-input-inline" style="width:200px">
                <select id="province" lay-filter="province_type">
                    <option value="">请选择省</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:110px">市</label>
            <div class="layui-input-inline" style="width:200px">
                <select id="city" lay-filter="city_type">
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width:110px">县/区</label>
            <div class="layui-input-inline" style="width:200px">
                <select id="area">

                </select>
            </div>
        </div>
    </div>

    </div>
</form>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>

    </div>
</script>

<script type="text/html" id="userimg">
    <img src="uploads/{{d.image}}" style="height: 30px;width: 30px">
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon"></i></a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="punish">处理</a>
</script>

<body onload="address()">
<%--<select id="province" >--%>
<%--    <option value="">请选择省</option>--%>
<%--</select>--%>
<%--<select id="city">--%>
<%--</select>--%>
<%--<select id="area">--%>

<%--</select>--%>

<button onclick="path()" type="button">提交</button>

<script>
    layui.use(['table','layer','util','form'], function(){
        var table = layui.table
            ,layer = layui.layer
            ,util = layui.util
            ,form = layui.form;

        table.render({
            elem: '#test'
            ,url:'admin/finduser'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,height:545
            ,page: true
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:'6%', fixed: 'left', unresize: true, sort: true}
                ,{field:'image', title:'头像', width:'6%',templet:'#userimg'}
                ,{field:'name', title:'用户名', width:'8%', edit: 'text'}
                ,{field:'identity', title:'职位', width:'8%', edit: 'text'}
                ,{field:'phone', title:'手机号码', width:'10%', edit: 'text'}
                ,{field:'pwd', title:'密码', width:'8.5%'}
                ,{field:'province', title:'籍贯（省）', width:'8%'}
                ,{field:'city', title:'市', width:'8%'}
                ,{field:'area', title:'区', width:'8%'}
                ,{field:'time', title:'注册时间', width:'14%',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'12%'}
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
                case 'add':
                    $('#name').val('');
                    $('#phone').val('');
                    $('#pwd').val('');
                    $('#province').val('');
                    $('#identity').val('');
                    $('#city').val('');
                    $('#area').val('');
                    document.getElementById('image').src="static/imgs/upload_image.png";
                    renderForm();
                    layer.open({
                        title: '新增',
                        type: 1,
                        btn: ['确定', '取消'],
                        content: $('#editGoods'),
                        area:['600px','500px'],
                        yes: function (index, layero) {
                            if($('#name').val()=="" || $('#phone').val()=="" || $('#pwd').val()=="" || $('#province').val()=="" || $('#identity').val()=="" || $('#city').val()=="" || $('#area').val()==""){
                                layer.msg("请检查信息：信息未填写完整");
                            }else{
                                if($('#phone').val().NaN || $('#phone').val().length!=11){
                                    layer.msg("手机格式不正确，请重新输入");
                                }else{
                                    var image="http://localhost:8080/ISMS/static/imgs/upload_image.png";
                                    if(document.getElementById('image').src ==image){
                                        $.ajax({
                                            type: 'post',
                                            url: 'admin/adduser',
                                            data: {
                                                name:$('#name').val(),
                                                phone: $('#phone').val(),
                                                pwd:$('#pwd').val(),
                                                province:$('#province').val(),
                                                city:$('#city').val(),
                                                area:$('#area').val(),
                                                identity:$('#identity').val(),
                                                time:new Date(),
                                                image:'upload_image.png'
                                            },
                                            success:function(data){
                                                console.log(data);
                                                if(data=="1000"){
                                                    layer.msg('添加成功',{
                                                        time:1500
                                                    },function(){
                                                        layer.closeAll();
                                                    });
                                                    // location.href="goods.html"

                                                }else{
                                                    layer.msg('添加失败：该手机号已注册');
                                                }
                                            }
                                        })
                                    }else{
                                        var imge = document.getElementById('file').files[0];
                                        console.log(imge)
                                        var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
                                        if(reg.test(imge.name)){
                                            layer.msg("图片名不能含有含字哦，请修改图片名");
                                        }else{
                                            var formdata = new FormData();
                                            formdata.append("name", $('#name').val());
                                            formdata.append("phone", $('#phone').val());
                                            formdata.append("identity", $('#identity').val());
                                            formdata.append("province", $('#province').val());
                                            formdata.append("city", $('#city').val());
                                            formdata.append("area", $('#area').val());
                                            formdata.append("pwd", $('#pwd').val());
                                            formdata.append("image", document.getElementById('file').files[0]);
                                            $.ajax({
                                                type: 'post',
                                                url: 'admin/AddUser',
                                                data: formdata,
                                                processData: false,
                                                contentType: false,
                                                success: function (data) {
                                                    console.log(data);
                                                    if (data == "1000") {
                                                        layer.msg('注册成功', {
                                                            time: 1500
                                                        }, function () {
                                                            layer.closeAll();
                                                        });
                                                    }else{
                                                        layer.msg('注册失败:该手机号已注册过了');
                                                    }
                                                }
                                            })
                                        }
                                    }
                                }
                            }

                        }
                    });
                    break;
                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });
        $('#find').click(function () {
            table.reload('test',{
                url:'admin/finduser'
                ,where:{
                    name:$('#findname').val(),
                    identity:$('#findidentity').val(),
                    phone:$('#findphone').val()
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
                        url:'admin/removeuser',
                        data:{
                            id:data.id
                        },
                        success:function (data) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                $('#province').val(data.province);
                $('#city').val(data.city);
                $('#area').val(data.area);
                var id = $('#province option:selected').attr("id");
                console.log(id)
                $.ajax({
                    type: 'post',
                    url: 'admin/findAllAddress',
                    success: function (data2) {
                        var city = [];

                        for (var i = 0; i < data2.data.length; i++) {
                            if(data2.data[i].address == data.city){
                                city.push('<option  id="' + data2.data[i].code + '" selected="" value="' + data2.data[i].address + '">' + data2.data[i].address + '</option>')
                            }
                            if (data2.data[i].code.length == 4 && data2.data[i].code.slice(0, 2) == id && data2.data[i].address != data.city) {
                                city.push('<option  id="' + data2.data[i].code + '" value="' + data2.data[i].address + '">' + data2.data[i].address + '</option>')
                            }
                            document.getElementById('city').innerHTML = city;
                            renderForm();
                        }
                    }

                })

                var city_id = $('#city option:selected').attr("id");
                $.ajax({
                    type: 'post',
                    url: 'admin/findAllAddress',
                    success: function (data1) {
                        var area = [];
                        for (var i = 0; i < data1.data.length; i++) {

                            if(data1.data[i].address==data.area){
                                area.push('<option  id="' + data1.data[i].code + '" selected="" value="' + data1.data[i].address + '">' + data1.data[i].address + '</option>')
                            }
                            if (data1.data[i].code.length == 6 && data1.data[i].code.slice(0, 4) == city_id && data1.data[i].address!=data.area) {
                                area.push('<option  id="' + data1.data[i].code + '" value="' + data1.data[i].address + '">' + data1.data[i].address + '</option>')
                            }
                            document.getElementById('area').innerHTML = area;
                            renderForm();
                        }
                    }
                })

                document.getElementById('image').src="uploads/"+data.image;
                $('#name').val(data.name);
                $('#phone').val(data.phone);
                $('#pwd').val(data.pwd);
                $('#identity').val(data.identity);

                renderForm();
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#editGoods'),

                    yes: function (index, layero) {
                        if($('#name').val()=="" || $('#phone').val()=="" || $('#pwd').val()=="" || $('#province').val()=="" || $('#identity').val()=="" || $('#city').val()=="" || $('#area').val()==""){
                            layer.msg("请检查信息：信息未填写完整");
                        }else {
                            if ($('#phone').val().NaN || $('#phone').val().length != 11) {
                                layer.msg("手机格式不正确，请重新输入");
                            } else {
                                if ($('#phone').val() == data.phone) {
                                    var phone="001";
                                } else {
                                    var phone = $('#phone').val();
                                }
                                console.log(document.getElementById('image').src);
                                console.log(data.image)
                                var img = "http://localhost:8080/ISMS/uploads/";
                                var formdata = new FormData();
                                formdata.append("id", data.id);
                                formdata.append("name", $('#name').val());
                                formdata.append("phone", phone);
                                formdata.append("identity", $('#identity').val());
                                formdata.append("province", $('#province').val());
                                formdata.append("city", $('#city').val());
                                formdata.append("area", $('#area').val());
                                formdata.append("pwd", $('#pwd').val());
                                if (document.getElementById('image').src == img + data.image) {

                                    console.log(phone + "没图片")
                                    formdata.append("image", data.image);
                                    $.ajax({
                                        type: 'post',
                                        url: 'admin/updateuser',
                                        data: formdata,
                                        processData: false,
                                        contentType: false,
                                        success: function (data) {
                                            console.log(data);
                                            if (data == "1000") {
                                                layer.msg('修改成功', {
                                                    time: 1500
                                                }, function () {
                                                    layer.closeAll();
                                                });
                                            } else {
                                                layer.msg('修改失败：该手机号已存在');
                                            }
                                        }
                                    })
                                } else {
                                    var imge = document.getElementById('file').files[0];
                                    formdata.append("image", document.getElementById('file').files[0]);
                                    var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
                                    if(reg.test(imge.name)){
                                        layer.msg("图片名不能含有含字哦，请修改图片名");
                                    }else{
                                        $.ajax({
                                            type: 'post',
                                            url: 'admin/updateUserDate',
                                            data: formdata,
                                            processData: false,
                                            contentType: false,
                                            success: function (data) {
                                                console.log(data);
                                                if (data == "1000") {
                                                    layer.msg('修改成功', {
                                                        time: 1500
                                                    }, function () {
                                                        layer.closeAll();
                                                    });
                                                }else{
                                                    layer.msg("修改失败：该手机号已存在");
                                                }
                                            }
                                        })
                                    }
                                }

                            }
                        }
                    }
                });
            }else if (obj.event === 'punish'){
                $('#content').val('');
                $('#integral').val('');
                layer.open({
                    title: '用户处理',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#punish'),
                    area:['500px','300px'],
                    yes: function (index, layero) {
                        $.ajax({
                            type:'post',
                            url:'integralMath',
                            data:{
                                integral:"-"+$('#integral').val(),
                                id:data.id
                            },
                        })
                        $.ajax({
                            type:'post',
                            url:'addMyEvent',
                            data:{
                                uid:data.id,
                                event:$('#content').val(),
                                time:new Date(),
                                integral:"-"+$('#integral').val()
                            },
                            success:function (data) {
                                layer.msg("处理成功",{
                                    time:1000
                                },function () {
                                    layer.closeAll();
                                })
                            }
                        })
                    }
                });
            }
        });

       form.on('select(province_type)', function(data) {
          var id = $('#province option:selected').attr("id");
            // var id = $(this).find("option:selected").attr("id");
           console.log(id);
            $.ajax({
                type: 'post',
                url: 'admin/findAllAddress',
                success: function (data) {
                    var city = [];

                    for (var i = 0; i < data.data.length; i++) {

                        if (data.data[i].code.length == 4 && data.data[i].code.slice(0, 2) == id) {
                            city.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }
                        document.getElementById('city').innerHTML = city;
                        renderForm();
                    }
                }
            })
        });

        form.on('select(city_type)', function(data) {
            var id = $('#city option:selected').attr("id");
            $.ajax({
                type: 'post',
                url: 'admin/findAllAddress',
                success: function (data) {
                    var area = [];
                    for (var i = 0; i < data.data.length; i++) {

                        if (data.data[i].code.length == 6 && data.data[i].code.slice(0, 4) == id) {
                            area.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }
                        document.getElementById('area').innerHTML = area;
                        renderForm();
                    }
                }
            })
        });
    });

    function click_image(){
        $("#file").click();
    }
    function replace_image(){
        $("#inputImg").hide();
        // 获得图片对象
        var blob_image = $("#file")[0].files[0];
        var url = window.URL.createObjectURL(blob_image);
        console.log(url);
        // 替换image
        $("#image").attr("src",url);
        console.log($("#file").val());
    }

    function renderForm() {
        layui.use('form',function () {
            var form = layui.form;
            form.render();
        })
    };
    function address() {

            $.ajax({
                type: 'post',
                url: 'admin/findAllAddress',
                success: function (data) {
                    var province = [];
                    var city= [];
                    var area = [];
                    province.push('<option value="" selected="">请选择</option>');
                    for (var i = 0; i < data.data.length; i++) {
                        if (data.data[i].code.length == 2) {
                            province.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }

                        document.getElementById('province').innerHTML = province;


                        if (data.data[i].code.length == 4) {
                            city.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }
                        document.getElementById('city').innerHTML = city;


                        if (data.data[i].code.length == 6) {
                            area.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }
                        document.getElementById('area').innerHTML = area;
                        renderForm();
                    }
                }
            })
    }
    // $("#province").bind("change", function() {
    //     console.log("asd");
    //         var id = $(this).find("option:selected").attr("id");
    //         console.log(id);
    //         $.ajax({
    //             type: 'post',
    //             url: 'admin/findAllAddress',
    //             success: function (data) {
    //                 var city = [];
    //                 city.push('<option value="" selected="">请选择</option>');
    //                 for (var i = 0; i < data.data.length; i++) {
    //
    //                     if (data.data[i].code.length == 4 && data.data[i].code.slice(0, 2) == id) {
    //                         city.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
    //                     }
    //                     document.getElementById('city').innerHTML = city;
    //                     renderForm();
    //                 }
    //             }
    //         })
    // });
    //
    // $("#city").bind("change", function() {
    //         var id = $(this).find("option:selected").attr("id");
    //
    //         $.ajax({
    //             type: 'post',
    //             url: 'admin/findAllAddress',
    //             success: function (data) {
    //                 var area = [];
    //                 area.push('<option value="" selected="">请选择</option>');
    //                 for (var i = 0; i < data.data.length; i++) {
    //
    //                     if (data.data[i].code.length == 6 && data.data[i].code.slice(0, 4) == id) {
    //                         area.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
    //                     }
    //                     document.getElementById('area').innerHTML = area;
    //                     renderForm();
    //                 }
    //             }
    //         })
    // });
</script>
</body>
