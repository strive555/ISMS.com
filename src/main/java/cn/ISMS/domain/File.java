package cn.ISMS.domain;

import java.util.Date;

public class File {

    private int id;
    private String files;
    private Date time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFiles() {
        return files;
    }

    public void setFiles(String files) {
        this.files = files;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "File{" +
                "id=" + id +
                ", files='" + files + '\'' +
                ", time=" + time +
                '}';
    }
}
