package cn.ISMS.domain;

import java.util.Date;

public class Admin {
    private  int id;
    private String adminname;
    private String adminpwd;
    private Date time;
    private int empower;
    private int adminempower;

    public int getAdminempower() {
        return adminempower;
    }

    public void setAdminempower(int adminempower) {
        this.adminempower = adminempower;
    }

    public int getEmpower() {
        return empower;
    }

    public void setEmpower(int empower) {
        this.empower = empower;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAdminname() {
        return adminname;
    }

    public void setAdminname(String adminname) {
        this.adminname = adminname;
    }

    public String getAdminpwd() {
        return adminpwd;
    }

    public void setAdminpwd(String adminpwd) {
        this.adminpwd = adminpwd;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", adminname='" + adminname + '\'' +
                ", adminpwd='" + adminpwd + '\'' +
                ", time=" + time +
                ", empower=" + empower +
                ", adminempower=" + adminempower +
                '}';
    }
}
