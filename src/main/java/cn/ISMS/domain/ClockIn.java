package cn.ISMS.domain;

import java.util.Date;

public class ClockIn {

    private int id;
    private int uid;
    private String uname;
    private String clockin;
    private Date time;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }


    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getClockin() {
        return clockin;
    }

    public void setClockin(String clockin) {
        this.clockin = clockin;
    }

    @Override
    public String toString() {
        return "ClockIn{" +
                "id=" + id +
                ", uid=" + uid +
                ", uname='" + uname + '\'' +
                ", clockin='" + clockin + '\'' +
                ", time=" + time +
                '}';
    }
}
