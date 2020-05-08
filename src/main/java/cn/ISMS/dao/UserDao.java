package cn.ISMS.dao;

import cn.ISMS.domain.*;
import cn.ISMS.domain.Task;
import cn.ISMS.domain.User;
import cn.ISMS.domain.UserIntegral;
import org.apache.ibatis.annotations.*;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository//相当于把它也交给AOP去管理
public interface UserDao {

    //user表
    @Select("select * from user where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<User> findAll(@Param("where") String where,@Param("num")int num,@Param("limit")int limit);

    @Select("select count(*) count from user where 1=1 ${where}")
    public String count(@Param("where") String where);

    @Select("select * from user")
    public List<User> findAlluser();

    @Insert("insert into user(name,phone) values(#{name},#{phone})")
    public void saveUser(User user);

    @Select("select * from user where phone=#{phone} and pwd=#{pwd}")
    public List<User> Login(@Param("phone") String phone, @Param("pwd") String pwd);

    @Update("update user set pwd=#{pwd} where name=#{name}")
    public void updatepwd(@Param("pwd") String pwd,@Param("name") String name);

    @Update("update user set name=#{name},image=#{image},phone=#{phone},image=#{image},identity=#{identity},province=#{province},city=#{city},area=#{area} where id=#{id}")
    public void updatemydata(User user);

    @Select("select * from user where id=#{id}")
    public List<User> mydata(int id);

    @Update("update user set name=#{name},image=#{image},image=#{image},identity=#{identity},province=#{province},city=#{city},area=#{area} where id=#{id}")
    public void updateUserdata(User user);




    //user_integral表
    @Select("select * from user_integral order by uintegral desc")
    public List<UserIntegral> findIntegral();

    @Select("select * from user_integral where uid=#{id}")
    public List<UserIntegral> findMyIntegral(int id);

    @Update("update user_integral,user set user_integral.uname=user.name,user_integral.uimage=user.image where user_integral.uid=user.id;")
    public void table();

    @Update("update user_integral set allintegral=allintegral+${integral},uintegral=uintegral+${integral} where uid=#{id}")
    public void integralmath(@Param("integral") int integral,@Param("id") int id);

    @Select("select * from user_integral where uphone = #{phone}")
    public List<UserIntegral> findMyData(String phone);

    @Update("update user_integral set allintegral=allintegral-${cintegral} where uid=#{uid}")
    public void exchangeintegral(@Param("cintegral") int cintegral,@Param("uid") int uid);




   //clock_in表
   @Insert("insert into clock_in(uid,uname,clockin,time) values(#{uid},#{uname},#{clockin},#{time});")
   public void addclockin(ClockIn clockin);

   @Delete("delete from clock_in;")
   public void deleteclockin();

   @Select("select * from clock_in where uid = #{id}")
   public List<ClockIn> findclockin(int id);




   //all_clock_in表
    @Insert("insert into all_clock_in(uid,uname,clockin,time) values(#{uid},#{uname},#{clockin},#{time});")
    public void tableclockin(ClockIn clockin);



    //task
    @Update("update task set uid=#{uid} where id=#{id}")
    public void usertask(Task task);

    @Update("update task set finishtime=#{finishtime} where id=#{id}")
    public void taskfinishtime(Task task);

    @Update("update task set state=#{state} where id=#{id}")
    public void updatetaskstate(Task task);

    @Update("update task set finishtime=null where id=#{id}")
    public void updatetaskfinish(Task task);


    //exchange
    @Insert("insert into exchange(uid,cname,cimage,cintegral,cintroduce,time) values(#{uid},#{cname},#{cimage},#{cintegral},#{cintroduce},#{time})")
    public void addexchange(Exchange exchange);

    @Select("select * from exchange where uid =#{id} order by id desc limit #{num},#{limit}")
    public List<Exchange> findmyexchange(@Param("id") int id,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from exchange")
    public String Count();


    //admin_file
    @Insert("insert into admin_file(uid,uname,files,time) values(#{uid},#{uname},#{files},#{time})")
    public void FileUploads(AdminFiles adminFiles);

    @Select("select * from admin_file where uid=#{uid} order by id desc limit #{num},#{limit}")
    public List<AdminFiles> findMyFiles(@Param("uid") int uid,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from admin_file")
    public String FileCount();


    //integral_award

    @Insert("insert into integral_award(uid,event,time,integral) values(#{uid},#{event},#{time},#{integral})")
    public void addMyEvent(IntegralAward integralAward);

    @Select("select * from integral_award where uid = #{uid} order by id desc")
    public List<IntegralAward> findMyIntegralEvent(int uid);
}
