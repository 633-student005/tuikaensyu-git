package la.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import la.bean.LoginBean;
import la.dao.LoginDAO;

@WebServlet("/BooksManagementServlet")
public class BooksManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			// パラメータの解析
			String page = request.getParameter("page");
			String action = request.getParameter("action");
			String tf = request.getParameter("TF");
			//			System.out.println("page:" + page);
			//			System.out.println("action:" + action);
			HttpSession session = request.getSession();

			// モデルのDAOを生成
			LoginDAO dao = new LoginDAO();
			// パラメータなしの場合は画面遷移を管理
			if (action == null || action.length() == 0) {
				// pageパラメータに基づいて画面遷移を管理
				if (page == null || page.isEmpty() || page.equals("toppage")) {
					// トップページに遷移
					if (session.getAttribute("login_info") != null) {
						gotoPage(request, response, "/mypage.jsp");
					} else {
						gotoPage(request, response, "/toppage.jsp");
					}

				} else if (page.equals("lendable")) {
					// 貸出可能資料一覧ページに遷移
					if (session.getAttribute("login_info") != null) {
						gotoPage(request, response, "/lendable_document_list_mypage.jsp");
					} else {
						gotoPage(request, response, "/lendable_document_list.jsp");
					}

				} else if (page.equals("bookable")) {
					// 予約可能資料一覧ページに遷移
					if (session.getAttribute("login_info") != null) {
						gotoPage(request, response, "/bookable_document_one_mypage.jsp");
					} else {
						gotoPage(request, response, "/bookable_document_one.jsp");
					}

				} else if (page.equals("login")) {
					// ログインページに遷移
					gotoPage(request, response, "/login.jsp");
				} else if (page.equals("register")) {
					// ログインページに遷移
					gotoPage(request, response, "/register.jsp");
				} else if (page.equals("logout")) {
					// ログアウトページに遷移
					session.invalidate();
					gotoPage(request, response, "/logout.jsp");
				} else if (page.equals("members_info")) {
					// 会員表示ページに遷移
					gotoPage(request, response, "/members_info.jsp");
				} else {
					// 不正なpageの場合はエラーページを表示
					request.setAttribute("message", "不正な操作です。");
					gotoPage(request, response, "/errInternal.jsp");
				}
			}
			// addは追加
			else if (action.equals("add")) {
				String name = request.getParameter("name");
				String postal_code = request.getParameter("postal_code");
				String address = request.getParameter("address");
				String phone_number = request.getParameter("phone_number");
				String email = request.getParameter("email");
				Date birthdate = Date.valueOf(request.getParameter("birthdate"));
				String password = request.getParameter("password");
				String confirm_password = request.getParameter("confirm_password");
				if (!password.equals(confirm_password)) {
					// 不正なpageの場合はエラーページを表示
					request.setAttribute("message", "パスワードと確認用のパスワードが一致しません。");
					gotoPage(request, response, "/errInternal.jsp");
				}
				// 郵便番号が7文字であることを確認します
				if (postal_code.length() == 7) {
					// 郵便番号の前半（3文字）と後半（4文字）を分割し、ハイフンを追加します
					String formattedPostalCode = postal_code.substring(0, 3) + "-" + postal_code.substring(3);
					//					System.out.println("フォーマットされた郵便番号: " + formattedPostalCode);
					postal_code = formattedPostalCode;
				} else {
					// 不正なpageの場合はエラーページを表示
					request.setAttribute("message", "郵便番号は7桁である必要があります。");
					gotoPage(request, response, "/errInternal.jsp");
				}
				//				System.out.println(birthdate);

				boolean TF;

				if (tf.equals("True")) {
					TF = true;
				} else {
					TF = false;
				}

				LoginBean login_info = new LoginBean(name, postal_code, address, phone_number, email, birthdate,
						password, TF);
				//				list={name,postal_code,address,phone_number};
				dao.addLogin(login_info);
				// 追加後、全レコード表示
				List<LoginBean> return_info = dao.findLogin(login_info);
				//				System.out.println(return_info);
				// Listをリクエストスコープに入れてJSPへフォーワードする
				request.setAttribute("login_info", return_info);
				gotoPage(request, response, "/registafter.jsp");
			}
			//login
			else if (action.equals("login")) {
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				LoginBean login_info = new LoginBean(email, password);
				// ユーザーネームと一致するレコードを取得
				LoginBean return_info = dao.selectLogin(login_info);
				//				System.out.println(return_info);
				if (return_info == null) {
					request.setAttribute("message", "アカウントが存在しません。");
					gotoPage(request, response, "/errInternal.jsp");
				}

				if (!password.equals(return_info.getPassword())) {
					// 不正なpageの場合はエラーページを表示
					request.setAttribute("message", "パスワードが一致しません");
					gotoPage(request, response, "/errInternal.jsp");
				}
				//				list={name,postal_code,address,phone_number};
				// Listをリクエストスコープに入れてJSPへフォーワードする
				session.setAttribute("login_info", return_info); // セッションに保存
				gotoPage(request, response, "/mypage.jsp");
			} //login
			else if (action.equals("toppage")) {
				// Listをリクエストスコープに入れてJSPへフォーワードする
				gotoPage(request, response, "/toppage.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "内部エラーが発生しました。");
			gotoPage(request, response, "/errInternal.jsp");
		}
	}

	private void gotoPage(HttpServletRequest request, HttpServletResponse response, String page)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
