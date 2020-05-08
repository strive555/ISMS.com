package cn.ISMS.domain;

public class UserIntegral {

    private int id;
    private int uid;
    private String uname;
    private int uintegral;
    private String uimage;
    private int allintegral;
    private String uphone;

    public String getUphone() {
        return uphone;
    }

    public void setUphone(String uphone) {
        this.uphone = uphone;
    }


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

    public int getUintegral() {
        return uintegral;
    }

    public void setUintegral(int uintegral) {
        this.uintegral = uintegral;
    }

    public int getAllintegral() {
        return allintegral;
    }

    public void setAllintegral(int allintegral) {
        this.allintegral = allintegral;
    }

    public String getUimage() {
        return uimage;
    }

    public void setUimage(String uimage) {
        this.uimage = uimage;
    }

    @Override
    public String toString() {
        return "UserIntegral{" +
                "id=" + id +
                ", uid=" + uid +
                ", uname='" + uname + '\'' +
                ", uintegral=" + uintegral +
                ", uimage='" + uimage + '\'' +
                ", allintegral=" + allintegral +
                ", uphone='" + uphone + '\'' +
                '}';
    }
}
