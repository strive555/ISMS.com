package cn.ISMS.service.Impl;

import cn.ISMS.dao.AdminDao;
import cn.ISMS.domain.*;
import cn.ISMS.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao adminDao;

    @Override
    public void saveUser(User user) {
        adminDao.saveUser(user);
    }

    @Override
    public void removeuser(int id) {
        adminDao.removeuser(id);
    }

    @Override
    public void updateempower(int empower, int id) {
        adminDao.updateempower(empower, id);
    }

    @Override
    public void updateUserData(User user) {
        adminDao.updateUserData(user);
    }

    @Override
    public void updateUserdata(User user) {
        adminDao.updateUserdata(user);
    }

    @Override
    public List<Shopping> findshopping(String where,int num, int limit) {
        return adminDao.findshopping(where,num,limit);
    }

    @Override
    public void removeshopping(int id) {
        adminDao.removeshopping(id);
    }

    @Override
    public void updateshopping(Shopping shopping) {
        adminDao.updateshopping(shopping);
    }

    @Override
    public void updatestate(String state, int id) {
        adminDao.updatestate(state, id);
    }

    @Override
    public String count(String where) {
        return adminDao.count(where);
    }

    @Override
    public void adduser_integral(User user) {
        adminDao.adduser_integral(user);
    }

    @Override
    public List<Admin> AdminLogin(String adminname, String adminpwd) {
        return adminDao.AdminLogin(adminname, adminpwd);
    }

    @Override
    public List<Admin> SuperAdmin(String adminname, String adminpwd) {
        return adminDao.SuperAdmin(adminname, adminpwd);
    }

    @Override
    public List<Admin> findSuperAdmin() {
        return adminDao.findSuperAdmin();
    }

    @Override
    public List<Notice> findallnotice(int num,int limit) {
        return adminDao.findallnotice(num, limit);
    }

    @Override
    public String noticecount() {
        return adminDao.noticecount();
    }

    @Override
    public void addnotice(Task task) {
        adminDao.addnotice(task);
    }

    @Override
    public void addnewnotice(Task task) {
        adminDao.addnewnotice(task);
    }

    @Override
    public void addtask(Task task) {
        adminDao.addtask(task);
    }

    @Override
    public void removenotice(int id) {
        adminDao.removenotice(id);
    }

    @Override
    public void updatenotice(Notice notice) {
        adminDao.updatenotice(notice);
    }

    @Override
    public List<Task> findtask(String where,int num,int limit) {
        return adminDao.findtask(where,num,limit);
    }

    @Override
    public String taskcount(String where) {
        return adminDao.taskcount(where);
    }

    @Override
    public void removetask(int id) {
        adminDao.removetask(id);
    }

    @Override
    public void updatetask(Task task) {
        adminDao.updatetask(task);
    }

    @Override
    public void addwordshift(WorkShift workShift) {
        adminDao.addwordshift(workShift);
    }

    @Override
    public List<WorkShift> findWorkShift(int year, int month, int date,String state) {
        return adminDao.findWorkShift(year, month, date, state);
    }

    @Override
    public List<WorkShift> findAllWorkShift(String where, int num, int limit) {
        return adminDao.findAllWorkShift(where, num, limit);
    }

    @Override
    public String WorkShiftCount(String where) {
        return adminDao.WorkShiftCount(where);
    }

    @Override
    public void deleteWordShift(int id) {
        adminDao.deleteWordShift(id);
    }

    @Override
    public void updateWordShift(WorkShift workShift) {
        adminDao.updateWordShift(workShift);
    }

    @Override
    public void addclockinintegral(ClockInIntagral clockInIntagral) {
        adminDao.addclockinintegral(clockInIntagral);
    }

    @Override
    public List<ClockInIntagral> findClockInIntegral(int year, int month, int date, String state) {
        return adminDao.findClockInIntegral(year, month, date, state);
    }

    @Override
    public List<ClockInIntagral> findAllClockInIntegral(String where, int num, int limit) {
        return adminDao.findAllClockInIntegral(where, num, limit);
    }

    @Override
    public String ClockInIntegralCount(String where) {
        return adminDao.ClockInIntegralCount(where);
    }

    @Override
    public void deleteClockInIntegral(int id) {
        adminDao.deleteClockInIntegral(id);
    }

    @Override
    public void updateClockInIntegral(ClockInIntagral clockInIntagral) {
        adminDao.updateClockInIntegral(clockInIntagral);
    }

    @Override
    public void refreshfile(String file,Date time) {
        adminDao.refreshfile(file,time);
    }

    @Override
    public List<File> files(Date time) {
        return adminDao.files(time);
    }

    @Override
    public void addNoticeIntegral(NoticeIntegral noticeIntegral) {
        adminDao.addNoticeIntegral(noticeIntegral);
    }

    @Override
    public void addNewNoticeIntegral(NoticeIntegral noticeIntegral) {
        adminDao.addNewNoticeIntegral(noticeIntegral);
    }

    @Override
    public void deleteNewNoticeIntegral() {
        adminDao.deleteNewNoticeIntegral();
    }

    @Override
    public List<NoticeIntegral> findNoticeIntegral() {
        return adminDao.findNoticeIntegral();
    }

    @Override
    public List<AdminFiles> findAllFiles(String where,int num,int limit) {
        return adminDao.findAllFiles(where,num, limit);
    }

    @Override
    public String filesCount(String where) {
        return adminDao.filesCount(where);
    }

    @Override
    public void deletefiles(int id) {
        adminDao.deletefiles(id);
    }

    @Override
    public void updatefiles(AdminFiles adminFiles) {
        adminDao.updatefiles(adminFiles);
    }

    @Override
    public List<Admin> AllAdmin() {
        return adminDao.AllAdmin();
    }

    @Override
    public void updateadminpwd(Admin admin) {
        adminDao.updateadminpwd(admin);
    }

    @Override
    public List<Admin> findAllAdmin(String where, int num, int limit) {
        return adminDao.findAllAdmin(where, num, limit);
    }

    @Override
    public String AdminCount(String where) {
        return adminDao.AdminCount(where);
    }

    @Override
    public List<Admin> findAdmin(String adminname) {
        return adminDao.findAdmin(adminname);
    }

    @Override
    public void addAdmin(Admin admin) {
        adminDao.addAdmin(admin);
    }

    @Override
    public void deleteAdmin(int id) {
        adminDao.deleteAdmin(id);
    }

    @Override
    public void updateAdmin(Admin admin) {
        adminDao.updateAdmin(admin);
    }

    @Override
    public void updateNonameAdmin(Admin admin) {
        adminDao.updateNonameAdmin(admin);
    }

    @Override
    public void updateAdminEmpower(int empower, int id) {
        adminDao.updateAdminEmpower(empower, id);
    }

    @Override
    public void updateAdminadminEmpower(int adminempower, int id) {
        adminDao.updateAdminadminEmpower(adminempower, id);
    }

    @Override
    public List<Admin> refreadmin(int id) {
        return adminDao.refreadmin(id);
    }

    @Override
    public List<Admin> refreadmin_super(int id) {
        return adminDao.refreadmin_super(id);
    }

    @Override
    public List<User> findphone(String phone) {
        return adminDao.findphone(phone);
    }


    @Override
    public void refreIntegralRule(Notice notice) {
        adminDao.refreIntegralRule(notice);
    }

    @Override
    public void deleteIntegralRule() {
        adminDao.deleteIntegralRule();
    }

    @Override
    public List<Notice> findIntegralRule() {
        return adminDao.findIntegralRule();
    }

    @Override
    public List<ClockIn> findAllClockIn(String where, int num, int limit) {
        return adminDao.findAllClockIn(where, num, limit);
    }

    @Override
    public String ClockInCount(String where) {
        return adminDao.ClockInCount(where);
    }

    @Override
    public void deleteClockIn(int id) {
        adminDao.deleteClockIn(id);
    }

    @Override
    public List<ClockIn> findAllClockInToday(String where, int num, int limit) {
        return adminDao.findAllClockInToday(where, num, limit);
    }

    @Override
    public String ClockInTodaysCount(String where) {
        return adminDao.ClockInTodaysCount(where);
    }

    @Override
    public void deleteClockInToday(int id) {
            adminDao.deleteClockInToday(id);
    }

    @Override
    public List<Exchange> findAllexchange(String where, int num, int limit) {
        return adminDao.findAllexchange(where, num, limit);
    }

    @Override
    public String AllexchangeCount(String where) {
        return adminDao.AllexchangeCount(where);
    }

    @Override
    public void updateexchange(String state, int id) {
        adminDao.updateexchange(state, id);
    }

    @Override
    public List<UserIntegral> findAllUserIntegral(String where, int num, int limit) {
        return adminDao.findAllUserIntegral(where, num, limit);
    }

    @Override
    public String AllUserIntegralCount(String where) {
        return adminDao.AllUserIntegralCount(where);
    }

    @Override
    public void deleteUserIntegral(int id) {
        adminDao.deleteUserIntegral(id);
    }

    @Override
    public void updateUserIntegral(UserIntegral userIntegral) {
        adminDao.updateUserIntegral(userIntegral);
    }

    @Override
    public List<IntegralAward> findnewNoticeIntegral() {
        return adminDao.findnewNoticeIntegral();
    }

    @Override
    public List<IntegralAward> FindNoticeIntegral() {
        return adminDao.FindNoticeIntegral();
    }

    @Override
    public List<Address> findAllAddress() {
        return adminDao.findAllAddress();
    }


}
