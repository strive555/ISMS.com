package cn.ISMS.domain;

import java.util.Date;

public class IntegralAward {
    private int id;
    private int uid;
    private String event;
    private String integral;
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

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public String getIntegral() {
        return integral;
    }

    public void setIntegral(String integral) {
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
        return "IntegralAward{" +
                "id=" + id +
                ", uid=" + uid +
                ", event='" + event + '\'' +
                ", integral='" + integral + '\'' +
                ", time=" + time +
                '}';
    }
}
