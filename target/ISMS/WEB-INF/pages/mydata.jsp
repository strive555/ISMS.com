<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/14
  Time: 18:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>

<body class="container" onload="address()">
<form class="layui-form" enctype="multipart/form-data">
    <div class="layui-form-item">
        <label class="layui-form-label">头像</label>
        <div class="layui-input-inline">
            <input id="file" type="file" name="image" style="display:none;" onChange="replace_image(0)"/>
            <img id="image" name="image" onclick="click_image()" style="cursor:pointer;margin-left: 20px" src="" height="100px" width="100px"/>
            <div class="layui-form-mid layui-word-aux" style="margin-left: 30px" id="inputImg">请上传头像</div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" id="name" lay-verify="required" lay-reqtext="用户名是必填项，岂能为空？" placeholder="请输入" autocomplete="off" class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="text" id="phone" lay-verify="required" lay-reqtext="手机号是必填项，岂能为空？" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">职位</label>
        <div class="layui-input-block">
            <input type="hidden" id="identity">
            <font size="5">${useridentity}</font>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">籍贯</label>
        <div class="layui-input-block">
            <div class="layui-input-inline">
                <select id="province" lay-filter="province_type">

                </select>
            </div>
            <div class="layui-input-inline">
                <select id="city" lay-filter="city_type">

                </select>
            </div>
            <div class="layui-input-inline">
                <select id="area">

                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <a type="button" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</a>
        </div>
    </div>
</form>


</body>
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        var id='<%=session.getAttribute("userid")%>';
        function refreshdata(){
            layui.use('form',function () {
                var form = layui.form;
                form.render();
            })
        };
        $.ajax({
            type:'post',
            url:'mydatarefresh',
            data:{
                id:id
            },
            success:function (res) {
                $('#province').val(res[0].province);
                $('#city').val(res[0].city);
                $('#area').val(res[0].area);
                var id = $('#province option:selected').attr("id");
                console.log(id);
                $.ajax({
                    type: 'post',
                    url: 'admin/findAllAddress',
                    success: function (data2) {
                        var city = [];

                        for (var i = 0; i < data2.data.length; i++) {
                            if(data2.data[i].address == res[0].city){
                                city.push('<option  id="' + data2.data[i].code + '" selected="" value="' + data2.data[i].address + '">' + data2.data[i].address + '</option>')
                            }
                            if (data2.data[i].code.length == 4 && data2.data[i].code.slice(0, 2) == id && data2.data[i].address != res[0].city) {
                                city.push('<option  id="' + data2.data[i].code + '" value="' + data2.data[i].address + '">' + data2.data[i].address + '</option>')
                            }
                            document.getElementById('city').innerHTML = city;
                            refreshdata();
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

                            if(data1.data[i].address==res[0].area){
                                area.push('<option  id="' + data1.data[i].code + '" selected="" value="' + data1.data[i].address + '">' + data1.data[i].address + '</option>')
                            }
                            if (data1.data[i].code.length == 6 && data1.data[i].code.slice(0, 4) == city_id && data1.data[i].address!=res[0].area) {
                                area.push('<option  id="' + data1.data[i].code + '" value="' + data1.data[i].address + '">' + data1.data[i].address + '</option>')
                            }
                            document.getElementById('area').innerHTML = area;
                            refreshdata();
                        }
                    }
                })
                $('#name').val(res[0].name);
                $('#phone').val(res[0].phone);
                $('#identity').val(res[0].identity);
                refreshdata();
                document.getElementById('image').src="uploads/"+res[0].image;
        //监听提交
        form.on('submit(demo1)', function(data){
            if($('#phone').val().NaN || $('#phone').val().length!=11){
                layer.msg("手机格式不正确，请重新输入");
            }else{
               if($('#phone').val()==res[0].phone){
                   var phone="001";
               }else{
                   var phone=$('#phone').val();
               }
            console.log(document.getElementById('image').src);
            var img="http://localhost:8080/ISMS/uploads/";
            var formdata = new FormData();
            formdata.append("id",res[0].id);
            formdata.append("name",$('#name').val());
            formdata.append("phone",phone);
            formdata.append("identity",$('#identity').val());
            formdata.append("province",$('#province').val());
            formdata.append("city",$('#city').val());
            formdata.append("area",$('#area').val());
            if(document.getElementById('image').src==img+res[0].image){
                formdata.append("image",res[0].image);
                console.log(formdata);
                $.ajax({
                    type: 'post',
                    url: 'UpdateMyData',
                    data:formdata,
                    processData:false,
                    contentType:false,
                    success:function(data){

                        if(data=="1000"){
                            layer.msg('修改成功');
                        }else{
                            layer.msg('修改失败：该手机号已存在');
                        }
                    }
                })

            }else {
                formdata.append("image", document.getElementById('file').files[0]);
                $.ajax({
                    type: 'post',
                    url: 'updatemydata',
                    data: formdata,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                            if(data=="1000"){
                                layer.msg('修改成功');
                            }else{
                                layer.msg('修改失败：该手机号已存在');
                            }
                    }
                })
            }
            }
        });
            }
        })

        form.on('select(province_type)', function(data) {
            var id = $('#province option:selected').attr("id");
            // var id = $(this).find("option:selected").attr("id");
            console.log(id);
            $.ajax({
                type: 'post',
                url: 'admin/findAllAddress',
                success: function (data) {
                    var city = [];
                    city.push('<option value="" selected="">请选择</option>');
                    for (var i = 0; i < data.data.length; i++) {

                        if (data.data[i].code.length == 4 && data.data[i].code.slice(0, 2) == id) {
                            city.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }
                        document.getElementById('city').innerHTML = city;
                        refreshdata();
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
                    area.push('<option value="" selected="">请选择</option>');
                    for (var i = 0; i < data.data.length; i++) {

                        if (data.data[i].code.length == 6 && data.data[i].code.slice(0, 4) == id) {
                            area.push('<option  id="' + data.data[i].code + '" value="' + data.data[i].address + '">' + data.data[i].address + '</option>')
                        }
                        document.getElementById('area').innerHTML = area;
                        refreshdata();
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
    function refreshdata(){
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
                    refreshdata();
                }
            }
        })
    }

</script>
</body>
</html>
