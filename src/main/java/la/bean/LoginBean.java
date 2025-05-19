package la.bean;

import java.io.Serializable;
import java.sql.Date;

public class LoginBean implements Serializable {
	private static final long serialVersionUID = 1L; // シリアル化ID

	private int members_id;
	private String name;
	private String postal_code;
	private String address;
	private String phone_number;
	private String email;
	private Date birthdate;
	private String admission_date;
	private String unsubscribe_date;
	private String password;
	private boolean admin_flag;

	// 引数を持つコンストラクタ（すべてのフィールドを初期化）
	public LoginBean(int members_id, String name, String postal_code, String address, String phone_number, String email,
			Date birthdate, String admission_date, String unsubscribe_date, String password, boolean admin_flag) {
		this.members_id = members_id;
		this.name = name;
		this.postal_code = postal_code;
		this.address = address;
		this.phone_number = phone_number;
		this.email = email;
		this.birthdate = birthdate;
		this.admission_date = admission_date;
		this.unsubscribe_date = unsubscribe_date;
		this.password = password;
		this.admin_flag = admin_flag;
	}

	// 引数を持つ部分的なコンストラクタ
	public LoginBean(String name, String postal_code, String address, String phone_number, String email,
			Date birthdate, String password, boolean admin_flag) {
		this.name = name;
		this.postal_code = postal_code;
		this.address = address;
		this.phone_number = phone_number;
		this.email = email;
		this.birthdate = birthdate;
		this.password = password;
		this.admin_flag = admin_flag;
	}

	// 引数を持つ部分的なコンストラクタ
	public LoginBean(String email, String password) {
		this.email = email;
		this.password = password;
	}

	// デフォルトコンストラクタ
	public LoginBean() {
	}

	// GetterとSetter
	public int getMembers_id() {
		return members_id;
	}

	public void setMembers_id(int members_id) {
		this.members_id = members_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostal_code() {
		return postal_code;
	}

	public void setPostal_code(String postal_code) {
		this.postal_code = postal_code;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getAdmission_date() {
		return admission_date;
	}

	public void setAdmission_date(String admission_date) {
		this.admission_date = admission_date;
	}

	public String getUnsubscribe_date() {
		return unsubscribe_date;
	}

	public void setUnsubscribe_date(String unsubscribe_date) {
		this.unsubscribe_date = unsubscribe_date;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isAdmin_flag() {
		return admin_flag;
	}

	public void setAdmin_flag(boolean admin_flag) {
		this.admin_flag = admin_flag;
	}

	// toStringメソッド（オブジェクトの内容を文字列で表示）
	@Override
	public String toString() {
		return "LoginBean{" +
				"members_id=" + members_id +
				", name='" + name + '\'' +
				", postal_code='" + postal_code + '\'' +
				", address='" + address + '\'' +
				", phone_number='" + phone_number + '\'' +
				", email='" + email + '\'' +
				", birthdate='" + birthdate + '\'' +
				", admission_date='" + admission_date + '\'' +
				", unsubscribe_date='" + unsubscribe_date + '\'' +
				", password='" + password + '\'' +
				", admin_flag=" + admin_flag +
				'}';
	}
}
