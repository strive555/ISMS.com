package cn.ISMS.domain;

import java.util.Date;

public class Task {
    private String type;
    private int id;
    private String theme;
    private String content;
    private Date time;
    private int uid;
    private String state;
    private Date finishtime;

    public Date getFinishtime() {
        return finishtime;
    }

    public void setFinishtime(Date finishtime) {
        this.finishtime = finishtime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "Task{" +
                "type='" + type + '\'' +
                ", id=" + id +
                ", theme='" + theme + '\'' +
                ", content='" + content + '\'' +
                ", time=" + time +
                ", uid=" + uid +
                ", state='" + state + '\'' +
                ", finishtime=" + finishtime +
                '}';
    }
}
