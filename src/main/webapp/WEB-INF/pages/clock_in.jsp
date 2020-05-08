<%@ page import="java.util.Date" %>
<%@ page import="cn.ISMS.domain.ClockIn" %>
<%@ page import="java.util.List" %>
<%List<ClockIn> clockincondition=(List<ClockIn>) session.getAttribute("clockincondition");%>
<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:40
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
<style>
    body{
        background-color: #3c3f41;
    }
    .div{
        margin: auto;
        text-align: center;
    }
    .layui-form-switch{
        width: 30%;
        height: 20%;
    }
    .layui-form-switch em{
        font-size: 60px;
        top:40%;
    }
    .layui-form-switch i{
        top:50%;
    }
</style>
<body onload="refreclockin()">
<br><br><br><br><br><br><div id="Time" class="div"></div><br><br>
    <form class="layui-form" >
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin: auto;text-align: center;">
                <%if(clockincondition.isEmpty()){%>
                     <input type="checkbox" name="close" lay-skin="switch" lay-filter="switchTest" lay-text="已打卡|未打卡">
                <%} else  if(session.getAttribute("userclockin")!=null){%>
                            <input type="checkbox" name="close" lay-skin="switch" lay-filter="switchTest" lay-text="已打卡|未打卡">
                        <%}else {%>
                            <input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="已打卡|未打卡">
                        <%}%>
            </div>
        </div>
    </form>
</body>
<script>
  function ShowTime(){
      document.getElementById('Time').innerHTML='<font size="10" style="color:#f2f2f2;">'+new Date().toLocaleString()+'</font>';
  }
  setInterval("ShowTime()",1000);
  function refreclockin(){
      alert("sssdsadf");
      $.ajax({
          type:'post',
          url:'findclockin',
          data:{
              id:${userid}
          },
          success:function(data){
              if (data=="1000"){

              }else{

              }
          }

      })
  }

  layui.use(['form', 'layedit', 'laydate'], function(){
      var form = layui.form
          ,layer = layui.layer;

      //监听指定开关
      form.on('switch(switchTest)', function(data){
                  $.ajax({
                      type:'post',
                      url:'findclockin',
                      data:{
                          id:${userid}
                      },
                      success:function(data){
                          if (data=="1000"){
                              $.ajax({
                                  type:'post',
                                  url:'addclockin',
                                  data:{
                                      uid:'${userid}',
                                      time:new Date(),
                                      uname:'${username}',
                                      clockin:'签退'
                                  },
                                  success:function (data) {
                                      $.ajax({
                                          type:'post',
                                          url:'admin/findWorkShift',
                                          data:{
                                              year:new Date().getUTCFullYear(),
                                              month:new Date().getMonth()+1,
                                              date:new Date().getDate(),
                                              state:'PM'
                                          },
                                          success:function (res) {
                                              if (res.length==0){
                                                  console.log("空");
                                                  if (new Date().getHours()>=18){
                                                      console.log("加班");
                                                      OnTime();
                                                  }else{
                                                      console.log("早退");
                                                      Late();
                                                  }
                                              }else{
                                                  if (new Date().getHours()>res[0].hours){
                                                      console.log("加班1");
                                                      OnTime();
                                                  }else if(new Date().getHours()==res[0].hours){
                                                      if (new Date().getMinutes()>res[0].minutes){
                                                          console.log("加班2");
                                                          OnTime();
                                                      }else if(new Date().getMinutes()==res[0].minutes){
                                                          if(new Date().getSeconds()>=res[0].seconds){
                                                              console.log("加班3");
                                                              OnTime();
                                                          }else{
                                                              console.log("早退1");
                                                              Late();
                                                          }
                                                      }else{
                                                          console.log("早退2");
                                                          Late();
                                                      }
                                                  }else{
                                                      console.log("早退3");
                                                      Late();
                                                  }
                                                  console.log("不为空");
                                              }
                                          }
                                      })
                                      layer.msg("签退成功<br>"+new Date().toLocaleString());
                                  }
                              });
                          }else{
                              $.ajax({
                                  type:'post',
                                  url:'addclockin',
                                  data:{
                                      uid:'${userid}',
                                      time:new Date(),
                                      uname:'${username}',
                                      clockin:"签到"
                                  },
                                  success:function (data) {
                                      $.ajax({
                                          type:'post',
                                          url:'admin/findWorkShift',
                                          data:{
                                              year:new Date().getUTCFullYear(),
                                              month:new Date().getMonth()+1,
                                              date:new Date().getDate(),
                                              state:'AM'
                                          },
                                          success:function (res) {
                                              if (res.length==0){
                                                  console.log("空");
                                                  if (new Date().getHours()>8){
                                                      console.log("迟到1");
                                                      Late();
                                                  }else if(new Date().getHours()==8){
                                                      if (new Date().getMinutes()==0 && new Date().getSeconds()==0){
                                                          console.log("刚好");
                                                          OnTime();
                                                      }else {
                                                          console.log("迟到2");
                                                            Late();
                                                      }
                                                  }else{
                                                      console.log("不迟到");
                                                      OnTime();
                                                  }
                                              }else{
                                                  if (new Date().getHours()>res[0].hours){
                                                      console.log("迟到1");
                                                      Late();
                                                  }else if(new Date().getHours()==res[0].hours){
                                                      if (new Date().getMinutes()>res[0].minutes){
                                                          console.log("迟到2");
                                                          Late();
                                                      }else if(new Date().getMinutes()==res[0].minutes){
                                                          if(new Date().getSeconds()>=res[0].seconds){
                                                              console.log("迟到3");
                                                              Late();
                                                          }else{
                                                              console.log("不迟到1");
                                                              OnTime();
                                                          }
                                                      }else{
                                                          console.log("不迟到2");
                                                          OnTime();
                                                      }
                                                  }else{
                                                      console.log("不迟到3");
                                                      OnTime();
                                                  }
                                                  console.log("不为空");
                                              }
                                          }
                                      })
                                      layer.msg("签到成功<br>"+new Date().toLocaleString());
                                  }
                              });

                          }
                      }

                  })

      });

  });
  function refreclockin(){
      $.ajax({
          url:'findclockin',
          data:{
              id:${userid}
          },
          success:function (data) {
              console.log(data);
          }
      })
  }

  function OnTime() {
      $.ajax({
          type:'post',
          url:'admin/findClockInIntegral',
          data:{
              year:new Date().getUTCFullYear(),
              month:new Date().getMonth()+1,
              date:new Date().getDate(),
              state:'OnTime'
          },
          success:function (data) {
              if (data.length==0){
                  $.ajax({
                      type:'post',
                      url:'integralMath',
                      data:{
                          integral:1,
                          id:${userid}
                      },
                  });
                  IntegralEvent('+1');
              }else{
                  $.ajax({
                      type:'post',
                      url:'integralMath',
                      data:{
                          integral:data[0].integral,
                          id:${userid}
                      },
                      success:function (data) {
                          console.log("hahahah")
                      }
                  });
                  IntegralEvent('+'+data[0].integral);
              }
          }
      })
  }

  function Late() {
      $.ajax({
          type:'post',
          url:'admin/findClockInIntegral',
          data:{
              year:new Date().getUTCFullYear(),
              month:new Date().getMonth()+1,
              date:new Date().getDate(),
              state:'Late'
          },
          success:function (data) {
              if (data.length==0){
                  $.ajax({
                      type:'post',
                      url:'integralMath',
                      data:{
                          integral:-2,
                          id:${userid}
                      },
                  })
                  IntegralEvent(-2);
              }else{
                  $.ajax({
                      type:'post',
                      url:'integralMath',
                      data:{
                          integral:-data[0].integral,
                          id:${userid}
                      },
                  });
                  IntegralEvent(-data[0].integral);
              }
          }
      })
  }
  function IntegralEvent(num) {
      $.ajax({
          type:'post',
          url:'addMyEvent',
          data:{
              uid:${userid},
              event:'打卡',
              time:new Date(),
              integral:num
          },
          success:function (data) {
              console.log("积分事件");
          }
      })
  }

</script>
</html>
