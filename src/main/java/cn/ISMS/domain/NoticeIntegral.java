package cn.ISMS.domain;

import java.util.Date;

public class NoticeIntegral {
    private int id;
    private int integral;
    private Date time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIntegral() {
        return integral;
    }

    public void setIntegral(int integral) {
        this.integral = integral;
    }


    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "NoticeIntegral{" +
                "id=" + id +
                ", integral=" + integral +
                ", time=" + time +
                '}';
    }
}
