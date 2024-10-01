package alarm;

public class AlarmBean {
	private int alarm_num;
	private String alarm_type;
	private String alarm_at;
	private int alarm_content_num;
	private String alarm_user_id;
	private boolean alarm_read;
	private boolean alarm_delete;
	
	
	public boolean isAlarm_read() {
		return alarm_read;
	}
	public void setAlarm_read(boolean alarm_read) {
		this.alarm_read = alarm_read;
	}
	public boolean isAlarm_delete() {
		return alarm_delete;
	}
	public void setAlarm_delete(boolean alarm_delete) {
		this.alarm_delete = alarm_delete;
	}
	public String getAlarm_user_id() {
		return alarm_user_id;
	}
	public void setAlarm_user_id(String alarm_user_id) {
		this.alarm_user_id = alarm_user_id;
	}
	public int getAlarm_num() {
		return alarm_num;
	}
	public void setAlarm_num(int alarm_num) {
		this.alarm_num = alarm_num;
	}
	public String getAlarm_type() {
		return alarm_type;
	}
	public void setAlarm_type(String alarm_type) {
		this.alarm_type = alarm_type;
	}
	public String getAlarm_at() {
		return alarm_at;
	}
	public void setAlarm_at(String alarm_at) {
		this.alarm_at = alarm_at;
	}
	public int getAlarm_content_num() {
		return alarm_content_num;
	}
	public void setAlarm_content_num(int alarm_content_num) {
		this.alarm_content_num = alarm_content_num;
	}
	
	
}
