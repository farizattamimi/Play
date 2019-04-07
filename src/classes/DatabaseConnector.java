package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class DatabaseConnector {
	private static final String DB_URL = "jdbc:mysql://localhost/play?user=root&password=Jumble52";
		
	public static User login(String username, String password) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next()) {
				user = new User(rs.getInt("userID"), rs.getString("username"));
			}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("CNFException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return user;
	}
	
	public static User getUser(String username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			if(rs.next()) {
				user = new User(rs.getInt("userID"), rs.getString("username"));
			}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("CNFException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return user;
	}
	
	public static User getUser(int userID) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("SELECT * FROM User WHERE userID=?");
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			if(rs.next()) {
				user = new User(rs.getInt("userID"), rs.getString("username"));
			}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("CNFException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return user;
	}
	
	public static boolean createUser(
			String username,
			String password,
			String passwordConfirmation) {
		Connection conn = null;
		PreparedStatement ps = null;
		int rs = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("INSERT INTO User (username, password) VALUES (?, ?)");
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("ClassNotFoundException: " + cnfe.getMessage());
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return rs > 0;
	}
	
	public static ArrayList<Event> getEvents() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Event> events = new ArrayList<Event>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("SELECT * "
					+ "FROM Event e "
					+ "LEFT JOIN User u ON e.creatorID=u.userID");
			rs = ps.executeQuery();
			while(rs.next()) {
				Event event = new Event(
						rs.getInt("eventID"),
						rs.getString("name"),
						rs.getInt("creatorID"),
						rs.getString("username"),
						rs.getString("latitude"),
						rs.getString("longitude"),
						rs.getTimestamp("createdAt"),
						rs.getInt("upvotes"),
						rs.getString("description"),
						rs.getTimestamp("expirationDate"),
						rs.getString("website"));
				events.add(event);
			}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("CNFException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return events;
	}
	
	public static boolean createEvent(
			String name,
			int creatorID,
			String latitude,
			String longitude,
			String description,
			Timestamp expirationDate,
			String website) {
		Connection conn = null;
		PreparedStatement ps = null;
		int rs = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("INSERT INTO Event "
					+ "(name, creatorID, latitude, longitude, "
					+ "description, expirationDate, website) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)");
			ps.setString(1, name);
			ps.setInt(2, creatorID);
			ps.setString(3, latitude);
			ps.setString(4, longitude);
			ps.setString(5, description);
			ps.setTimestamp(6, expirationDate);
			ps.setString(7, website);
			rs = ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("ClassNotFoundException: " + cnfe.getMessage());
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return rs > 0;
	}
	
	public boolean upvoteEvent(int eventID) {
		Connection conn = null;
		PreparedStatement ps = null;
		int rs = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("UPDATE Event SET upvotes = upvotes + 1 "
					+ "WHERE eventID=?");
			ps.setInt(1, eventID);
			rs = ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("CNFException: " + cnfe.getMessage());
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return rs > 0;
	}
	
	public static ArrayList<Comment> getComments(int eventID) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Comment> comments = new ArrayList<Comment>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("SELECT * "
					+ "FROM Comment c "
					+ "LEFT JOIN User u ON c.creatorID=u.userID"
					+ "WHERE Comment.eventID=?");
			ps.setInt(1, eventID);
			rs = ps.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment(
						rs.getInt("commentID"),
						rs.getInt("creatorID"),
						rs.getString("username"),
						rs.getString("message"),
						rs.getTimestamp("createdAt"));
				comments.add(comment);
			}
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("CNFException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return comments;
	}
	
	public static boolean createComment(
			int creatorID,
			int eventID,
			String message) {
		Connection conn = null;
		PreparedStatement ps = null;
		int rs = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL);
			ps = conn.prepareStatement("INSERT INTO Comment "
					+ "(creatorID, eventID, message) "
					+ "VALUES (?, ?, ?)");
			ps.setInt(1, creatorID);
			ps.setInt(2, eventID);
			ps.setString(3, message);
			
			rs = ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("ClassNotFoundException: " + cnfe.getMessage());
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		return rs > 0;
	}
	
}
