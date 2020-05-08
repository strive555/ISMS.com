package cn.ISMS.service;

import cn.ISMS.domain.*;

import java.util.Date;
import java.util.List;

public interface AdminService {

    public void saveUser(User user);

    public void removeuser(int id);

    public void updateempower(int empower,int id);

    public void updateUserData(User user);

    public void updateUserdata(User user);




    public List<Shopping> findshopping(String where,int num,int limit);

    public void removeshopping(int id);

    public void updateshopping(Shopping shopping);

    public void updatestate(String state,int id);

    public String count(String where);


    public void adduser_integral(User user);




    public List<Admin> AdminLogin(String adminname, String adminpwd);
    public List<Admin> SuperAdmin(String adminname,String adminpwd);
    public List<Admin> findSuperAdmin();



    public List<Notice> findallnotice(int num,int limit);

    public String noticecount();

    public void addnotice(Task task);

    public void addnewnotice(Task task);

    public void addtask(Task task);

    public void removenotice(int id);

    public void updatenotice(Notice notice);

    public List<Task> findtask(String where,int num,int limit);

    public String taskcount(String where);

    public void removetask(int id);

    public void updatetask(Task task);






    public void addwordshift(WorkShift workShift);

    public List<WorkShift> findWorkShift(int year,int month,int date,String state);

    public List<WorkShift> findAllWorkShift(String where,int num,int limit);

    public String WorkShiftCount(String where);

    public void deleteWordShift(int id);

    public void updateWordShift(WorkShift workShift);





    public void addclockinintegral(ClockInIntagral clockInIntagral);

    public List<ClockInIntagral> findClockInIntegral(int year,int month,int date,String state);

    public List<ClockInIntagral> findAllClockInIntegral(String where,int num,int limit);

    public String ClockInIntegralCount(String where);

    public void deleteClockInIntegral(int id);

    public void updateClockInIntegral(ClockInIntagral clockInIntagral);





    public void refreshfile(String file,Date time);

    public List<File> files(Date time);


    public void addNoticeIntegral(NoticeIntegral noticeIntegral);

    public void addNewNoticeIntegral(NoticeIntegral noticeIntegral);

    public void deleteNewNoticeIntegral();

    public List<NoticeIntegral> findNoticeIntegral();



    public List<AdminFiles> findAllFiles(String where,int num,int limit);

    public String filesCount(String where);

    public void deletefiles(int id);

    public void updatefiles(AdminFiles adminFiles);



    public List<Admin> AllAdmin();

    public void updateadminpwd(Admin admin);

    public List<Admin> findAllAdmin(String where,int num,int limit);

    public String AdminCount(String where);

    public List<Admin> findAdmin(String adminname);

    public void addAdmin(Admin admin);

    public void deleteAdmin(int id);

    public void updateAdmin(Admin admin);

    public void updateNonameAdmin(Admin admin);

    public void updateAdminEmpower(int empower,int id);
    public void updateAdminadminEmpower(int adminempower,int id);

    public List<Admin> refreadmin(int id);

    public List<Admin> refreadmin_super(int id);


    public List<User> findphone(String phone);






    public void refreIntegralRule(Notice notice);

    public void deleteIntegralRule();

    public List<Notice> findIntegralRule();



    public List<ClockIn> findAllClockIn(String where,int num,int limit);

    public String ClockInCount(String where);

    public void deleteClockIn(int id);





    public List<ClockIn> findAllClockInToday(String where,int num,int limit);

    public String ClockInTodaysCount(String where);

    public void deleteClockInToday(int id);





    public List<Exchange> findAllexchange(String where,int num,int limit);

    public String AllexchangeCount(String where);

    public void updateexchange(String state,int id);


    public List<UserIntegral> findAllUserIntegral(String where,int num,int limit);

    public String AllUserIntegralCount(String where);

    public void deleteUserIntegral(int id);

    public void updateUserIntegral(UserIntegral userIntegral);



    public List<IntegralAward> findnewNoticeIntegral();

    public List<IntegralAward> FindNoticeIntegral();




    public List<Address> findAllAddress();
}
