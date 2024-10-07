package report;

public class ReportBean {
	private int report_num;
	private String report_senduserid;
	private String report_receiveuserid;
	private String report_at;
	private String report_type;
	private boolean report_complete;
	private int report_contentnum;
	
	public int getReport_contentnum() {
		return report_contentnum;
	}
	public void setReport_contentnum(int report_contentnum) {
		this.report_contentnum = report_contentnum;
	}
	public boolean isReport_complete() {
		return report_complete;
	}
	public void setReport_complete(boolean report_complete) {
		this.report_complete = report_complete;
	}
	public int getReport_num() {
		return report_num;
	}
	public void setReport_num(int report_num) {
		this.report_num = report_num;
	}
	public String getReport_senduserid() {
		return report_senduserid;
	}
	public void setReport_senduserid(String report_senduserid) {
		this.report_senduserid = report_senduserid;
	}
	public String getReport_receiveuserid() {
		return report_receiveuserid;
	}
	public void setReport_receiveuserid(String report_receiveuserid) {
		this.report_receiveuserid = report_receiveuserid;
	}
	public String getReport_at() {
		return report_at;
	}
	public void setReport_at(String report_at) {
		this.report_at = report_at;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	
}
