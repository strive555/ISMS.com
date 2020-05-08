package cn.ISMS.dao;

import cn.ISMS.domain.*;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Repository
public interface AdminDao {

    @Insert("insert into user(name,phone,pwd,province,city,area,identity,image,time) values(#{name},#{phone},#{pwd},#{province},#{city},#{area},#{identity},#{image},#{time})")
    public void saveUser(User user);

    @Delete("delete from user where id = #{id}")
    public void removeuser(int id);

    @Update("update user set empower = #{empower} where id = #{id}")
    public void updateempower(@Param("empower") int empower,@Param("id") int id);

    @Select("select * from shopping where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<Shopping> findshopping(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Delete("delete from shopping where id = #{id}")
    public void removeshopping(int id);

    @Update("update shopping set  name=#{name},integral=#{integral},introduce=#{introduce},image=#{image} where id=#{id}")
    public void updateshopping(Shopping shopping);

    @Update("update shopping set state=#{state} where id = #{id}")
    public void updatestate(@Param("state") String state,@Param("id") int id);

    @Select("select count(*) count from shopping where 1=1 ${where}")
    public String count(@Param("where") String where);




    @Insert("insert into user_integral(uid,uname,uintegral,allintegral,uphone,uimage) values(#{id},#{name},0,0,#{phone},#{image})")
    public void adduser_integral(User user);

    @Update("update user set name=#{name},pwd=#{pwd},image=#{image},phone=#{phone},image=#{image},identity=#{identity},province=#{province},city=#{city},area=#{area} where id=#{id}")
    public void updateUserData(User user);

    @Update("update user set name=#{name},pwd=#{pwd},image=#{image},image=#{image},identity=#{identity},province=#{province},city=#{city},area=#{area} where id=#{id}")
    public void updateUserdata(User user);

    @Select("select * from admin where adminname=#{adminname} and adminpwd=#{adminpwd}")
    public List<Admin> AdminLogin(@Param("adminname") String adminname,@Param("adminpwd") String adminpwd);

    @Select("select * from notice order by id desc limit #{num},#{limit}")
    public List<Notice> findallnotice(@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from notice where 1=1 ")
    public String noticecount();




    @Insert("insert into notice(theme,content,time) values(#{theme},#{content},#{time})")
    public void addnotice(Task task);

    @Insert("insert into newnotice(theme,content,time,user) values(#{theme},#{content},#{time},#{uid})")
    public void addnewnotice(Task task);

    @Insert("insert into task (theme,content,time,type) values(#{theme},#{content},#{time},#{type})")
    public void addtask(Task task);

    @Delete("delete from notice where id =#{id}")
    public void removenotice(int id);

    @Update("update notice set theme=#{theme},content=#{content} where id =#{id}")
    public void updatenotice(Notice notice);

    @Select("select * from task where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<Task> findtask(@Param("where") String where,@Param("num") int num,@Param("limit")int limit);

    @Select("select count(*) count from task where 1=1 ${where}")
    public String taskcount(@Param("where") String where);

    @Delete("delete from task where id =#{id}")
    public void removetask(int id);

    @Update("update task set theme=#{theme},content=#{content},type=#{type} where id =#{id}")
    public void updatetask(Task task);



    //work_shift
    @Insert("insert into work_shift(year,month,date,hours,minutes,seconds,state) values(#{year},#{month},#{date},#{hours},#{minutes},#{seconds},#{state})")
    public void addwordshift(WorkShift workShift);

    @Select("select * from work_shift where year=#{year} and month=#{month} and date=#{date} and state=#{state}")
    public List<WorkShift> findWorkShift(@Param("year") int year,@Param("month") int month,@Param("date") int date,@Param("state") String state);

    @Select("select * from work_shift where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<WorkShift> findAllWorkShift(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from work_shift where 1=1 ${where}")
    public String WorkShiftCount(@Param("where") String where);

    @Delete("delete from work_shift where id = #{id}")
    public void deleteWordShift(int id);

    @Update("update work_shift set year=#{year},month=#{month},date=#{date},hours=#{hours},minutes=#{minutes},seconds=#{seconds} where id = #{id}")
    public void updateWordShift(WorkShift workShift);






    //clock_in_integral
    @Insert("insert into clock_in_integral(year,month,date,integral,state) values(#{year},#{month},#{date},#{integral},#{state})")
    public void addclockinintegral(ClockInIntagral clockInIntagral);

    @Select("select * from clock_in_integral where year=#{year} and month=#{month} and date=#{date} and state=#{state}")
    public List<ClockInIntagral> findClockInIntegral(@Param("year") int year,@Param("month") int month,@Param("date") int date,@Param("state") String state);

    @Select("select * from clock_in_integral where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<ClockInIntagral> findAllClockInIntegral(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from clock_in_integral where 1=1 ${where}")
    public String ClockInIntegralCount(@Param("where") String where);

    @Delete("delete from clock_in_integral where id=#{id}")
    public void deleteClockInIntegral(int id);

    @Update("update clock_in_integral set year=#{year},month=#{month},date=#{date},integral=#{integral} where id=#{id}")
    public void updateClockInIntegral(ClockInIntagral clockInIntagral);




    //file
    @Insert("insert  into file(files,time) values(#{file},#{time})")
    public void refreshfile(@Param("file") String file,@Param("time") Date time);

    @Select("select * from file where time=#{time}")
    public List<File> files(Date time);


    //notice_integral
    @Insert("insert into notice_integral(integral,time) values(#{integral},#{time})")
    public void addNoticeIntegral(NoticeIntegral noticeIntegral);

    @Insert("insert into new_notice_integral(integral,time) values(#{integral},#{time})")
    public void addNewNoticeIntegral(NoticeIntegral noticeIntegral);

    @Delete("delete from new_notice_integral")
    public void deleteNewNoticeIntegral();

    @Select("select * from new_notice_integral")
    public List<NoticeIntegral> findNoticeIntegral();


    //admin_file
    @Select("select * from admin_file where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<AdminFiles> findAllFiles(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from admin_file where 1=1 ${where}")
    public String filesCount(@Param("where") String where);

    @Delete("delete from  admin_file where id = #{id}")
    public void deletefiles(int id);

    @Update("update admin_file set uname=#{uname},files=#{files} where id = #{id}")
    public void updatefiles(AdminFiles adminFiles);


    //admin
    @Update("update admin set adminpwd=#{adminpwd} where id=#{id}")
    public void updateadminpwd(Admin admin);

    @Select("select * from admin where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<Admin> findAllAdmin(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from admin where 1=1 ${where}")
    public String AdminCount(@Param("where") String where);

    @Select("select * from admin where adminname=#{adminname}")
    public List<Admin> findAdmin(String adminname);

    @Insert("insert into admin(adminname,adminpwd,time) values(#{adminname},#{adminpwd},#{time})")
    public void addAdmin(Admin admin);

    @Delete("delete from admin where id=#{id}")
    public void deleteAdmin(int id);

    @Update("update admin set adminname=#{adminname},adminpwd=#{adminpwd} where id =#{id}")
    public void updateAdmin(Admin admin);

    @Update("update admin set adminpwd=#{adminpwd} where id =#{id}")
    public void updateNonameAdmin(Admin admin);

    @Select("select * from admin")
    public List<Admin> AllAdmin();

    @Update("update admin set empower = #{empower} where id = #{id}")
    public void updateAdminEmpower(@Param("empower") int empower,@Param("id") int id);

    @Update("update admin set adminempower = #{adminempower} where id = #{id}")
    public void updateAdminadminEmpower(@Param("adminempower") int adminempower,@Param("id") int id);

    @Select("select * from admin where id=#{id}")
    public List<Admin> refreadmin(int id);

    @Select("select * from user where phone=#{phone}")
    public List<User> findphone(String phone);



    //admin_super
    @Select("select * from admin_super where adminname=#{adminname} and adminpwd=#{adminpwd}")
    public List<Admin> SuperAdmin(@Param("adminname") String adminname,@Param("adminpwd") String adminpwd);

    @Select("select * from admin_super")
    public List<Admin> findSuperAdmin();

    @Select("select * from admin_super where id=#{id}")
    public List<Admin> refreadmin_super(int id);



    //integral_rule
    @Insert("insert into integral_rule(content,time) values(#{content},#{time})")
    public void refreIntegralRule(Notice notice);

    @Delete("delete from integral_rule")
    public void deleteIntegralRule();

    @Select("select * from integral_rule")
    public List<Notice> findIntegralRule();



    //all_clock_in
    @Select("select * from all_clock_in where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<ClockIn> findAllClockIn(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from all_clock_in where 1=1 ${where}")
    public String ClockInCount(@Param("where") String where);

    @Delete("delete from all_clock_in where id =#{id}")
    public void deleteClockIn(int id);

    //clock_in
    @Select("select * from clock_in where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<ClockIn> findAllClockInToday(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from clock_in where 1=1 ${where}")
    public String ClockInTodaysCount(@Param("where") String where);

    @Delete("delete from clock_in where id =#{id}")
    public void deleteClockInToday(int id);



    //exchange
    @Select("select * from exchange where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<Exchange> findAllexchange(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from exchange where 1=1 ${where}")
    public String AllexchangeCount(@Param("where") String where);

    @Update("update exchange set state=#{state} where id = #{id}")
    public void updateexchange(@Param("state") String state,@Param("id") int id);




    //user_integral表
    @Select("select * from user_integral where 1=1 ${where} order by id desc limit #{num},#{limit}")
    public List<UserIntegral> findAllUserIntegral(@Param("where") String where,@Param("num") int num,@Param("limit") int limit);

    @Select("select count(*) count from user_integral where 1=1 ${where}")
    public String AllUserIntegralCount(@Param("where") String where);

   @Delete("delete from user_integral where id = #{id} ")
    public void deleteUserIntegral(int id);

   @Update("update user_integral set uintegral=#{uintegral},allintegral=#{allintegral} where id=#{id}")
   public void updateUserIntegral(UserIntegral userIntegral);


    //new_notice_integral

    @Select("select * from new_notice_integral")
    public List<IntegralAward> findnewNoticeIntegral();


    @Select("select * from notice_integral order by id desc")
    public List<IntegralAward> FindNoticeIntegral();



    //address
    @Select("select * from address")
    public List<Address> findAllAddress();
}

