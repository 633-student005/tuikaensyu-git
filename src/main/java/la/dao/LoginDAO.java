package la.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import la.bean.LoginBean;

public class LoginDAO {
	// URL、ユーザ名、パスワードの準備
	private String url = "jdbc:postgresql:library_managementdb";
	private String user = "yuki";
	private String pass = "himitu";

	public LoginDAO() throws DAOException {
		try {
			// JDBCドライバの登録
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new DAOException("ドライバの登録に失敗しました。");
		}
	}

	public List<LoginBean> findLogin(LoginBean login_info) throws DAOException {
		// SQL文の作成
		String sql = "SELECT * FROM members_ledger WHERE email = ?";

		try (// データベースへの接続
				Connection con = DriverManager.getConnection(url, user, pass);
				// PreparedStatementオブジェクトの取得
				PreparedStatement st = con.prepareStatement(sql);) {
			st.setString(1, login_info.getEmail());
			try (// SQLの実行
					ResultSet rs = st.executeQuery();) {

				// 結果の取得
				List<LoginBean> list = new ArrayList<LoginBean>();
				while (rs.next()) {
					int members_id = rs.getInt("members_id");
					String name = rs.getString("name");
					String postal_code = rs.getString("postal_code");
					String address = rs.getString("address");
					String phone_number = rs.getString("phone_number");
					String email = rs.getString("email");
					Date birthdate = rs.getDate("birthdate");
					String admission_date = rs.getString("admission_date");
					String unsubscribe_date = rs.getString("unsubscribe_date");
					String password = rs.getString("password");
					boolean TF = rs.getBoolean("admin_flag");
					LoginBean bean = new LoginBean(members_id, name, postal_code, address, phone_number, email,
							birthdate,
							admission_date, unsubscribe_date, password, TF);
					list.add(bean);
				}
				// 商品一覧をListとして返す
				return list;
			} catch (SQLException e) {
				e.printStackTrace();
				throw new DAOException("レコードの操作に失敗しました。");
			}

		} catch (SQLException e) {
			e.printStackTrace();
			throw new DAOException("レコードの取得に失敗しました。");
		}
	}

	public int addLogin(LoginBean login_info) throws DAOException {
		// SQL文の作成
		String sql = "INSERT INTO members_ledger ("
				+ "name, postal_code, address, phone_number, email, birthdate, password, admin_flag"
				+ ") VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		//		System.out.println("URL:" + url);

		try (// データベースへの接続
				Connection con = DriverManager.getConnection(url, user, pass);
				// PreparedStatementオブジェクトの取得
				PreparedStatement st = con.prepareStatement(sql);) {
			// 商品名と値段の指定
			st.setString(1, login_info.getName());
			st.setString(2, login_info.getPostal_code());
			st.setString(3, login_info.getAddress());
			st.setString(4, login_info.getPhone_number());
			st.setString(5, login_info.getEmail());
			st.setDate(6, login_info.getBirthdate());
			st.setString(7, login_info.getPassword());
			st.setBoolean(8, login_info.isAdmin_flag());
			// SQLの実行
			int rows = st.executeUpdate();
			return rows;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DAOException("レコードの操作に失敗しました。");
		}
	}

	public LoginBean selectLogin(LoginBean login_info) throws DAOException {
		// SQL文の作成
		String sql = "SELECT * FROM members_ledger WHERE email = ?";
		try (
				// データベースへの接続
				Connection con = DriverManager.getConnection(url, user, pass);
				// PreparedStatementオブジェクトの取得
				PreparedStatement st = con.prepareStatement(sql);) {
			//			System.out.println("aaaaaaaaaaaaaaaa" + login_info.getEmail());
			st.setString(1, login_info.getEmail());
			try (
					// SQLの実行
					ResultSet rs = st.executeQuery();) {
				// カーソルを次の行に移動（データが存在するかチェック）
				if (rs.next()) {
					// データを取得
					int members_id = rs.getInt("members_id");
					String name = rs.getString("name");
					String postal_code = rs.getString("postal_code");
					String address = rs.getString("address");
					String phone_number = rs.getString("phone_number");
					String email = rs.getString("email");
					Date birthdate = rs.getDate("birthdate");
					String admission_date = rs.getString("admission_date");
					String unsubscribe_date = rs.getString("unsubscribe_date");
					String password = rs.getString("password");
					boolean TF = rs.getBoolean("admin_flag");

					// LoginBeanオブジェクトを作成
					LoginBean bean = new LoginBean(members_id, name, postal_code, address, phone_number, email,
							birthdate, admission_date, unsubscribe_date, password, TF);

					// LoginBeanを返す
					//					System.out.println(bean);
					return bean;
				} else {
					// データが見つからない場合
					return null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw new DAOException("レコードの操作に失敗しました。");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new DAOException("レコードの取得に失敗しました。");
		}
	}

}