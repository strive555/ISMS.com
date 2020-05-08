<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<style>
    body{
        background-color:#f2f2f2;
    }
</style>
<body class="container">
<ul id="biuuu_city_list"></ul>
<div  id="demo20" style="display: none"></div>
<div style="color: #1E9FFF">已加载全部公告信息</div>
<script>
    layui.use(['laypage', 'layer'], function(){
        var laypage = layui.laypage
            ,layer = layui.layer;

        //测试数据


            $.ajax({
                    type:'post',
                    url:'ShowNotice',
                    data:{},
                    success:function (data1) {
                        var data = [];
                        for(var i=0;i<data1.length;i++){
                        $.ajax({
                        type:'post',
                        url:'admin/findFiles',
                        data:{
                            time:new Date(data1[i].time)
                        },
                        success:function (res) {
                            if(res==""){
                            }else{
                                var id=res[0].time;
                                for(var i=0;i<res.length;i++){
                                    var j=i+1;
                                    $('#'+id).append('<a  href="uploads/'+res[i].files+'"><font size="2">'+res[i].files+'</font></a> ');
                                }
                            }

                        }
                    });
                        var j=i+1;
                    data.push(
                        '<div class="card text-center"><span  style="position: relative;left:-48%">'+j+'</span>'+
                        '  <div class="card-header" ><h5 class="card-title">'+data1[i].theme+'</h5>\n'+
                        '    <p class="card-text">'+data1[i].content+'</p>\n' +
                        '  </div>\n' +
                        '  <div class="card-body" id='+data1[i].time+'>\n' +
                        '  </div>\n' +
                        '  <div class="card-footer text-muted">\n' +new Date(data1[i].time).toLocaleString()+
                        '    \n' +
                        '  </div>\n' +
                        '</div><br><br>');
                        }
        //调用分页
        laypage.render({
            elem: 'demo20'
            ,count: data.length
            ,jump: function(obj){
                //模拟渲染
                document.getElementById('biuuu_city_list').innerHTML = function(){
                    var arr = []
                        ,thisData = data.concat().splice(0, data.length);
                    layui.each(thisData, function(index, item){
                        arr.push('<li>'+ item +'</li>');
                    });
                    return arr.join('');
                }();
            }
        });
                    }
            });
    })
</script>

</body>
</html>
