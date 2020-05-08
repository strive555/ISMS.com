package cn.ISMS.domain;

public class ClockInIntagral {
    private int id;
    private int year;
    private int month;
    private int date;
    private int integral;
    private String state;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDate() {
        return date;
    }

    public void setDate(int date) {
        this.date = date;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getIntegral() {
        return integral;
    }

    public void setIntegral(int integral) {
        this.integral = integral;
    }

    @Override
    public String toString() {
        return "ClockInIntagral{" +
                "id=" + id +
                ", year=" + year +
                ", month=" + month +
                ", date=" + date +
                ", integral=" + integral +
                ", state='" + state + '\'' +
                '}';
    }
}
