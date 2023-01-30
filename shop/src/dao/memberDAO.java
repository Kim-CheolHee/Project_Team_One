package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import common.JDBConnect;
import dto.Product;
import dto.memberDTO;

public class memberDAO extends JDBConnect {
	
	private ArrayList<memberDTO> memberlist = new ArrayList<memberDTO>();
	private static memberDAO instance = new memberDAO();

	// 회원 정보를 반환하는 메소드.
	public void memberInfo(String id) {

		String query = "SELECT * FROM member WHERE id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			while (rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPhoto(rs.getString(4));
				memberlist.add(dto);
			}
		} catch (Exception e) {
			System.out.println("memberInfo 예외 발생" + e);
		}

	}

	public ArrayList<memberDTO> getMemberlist() {
		return memberlist;
	}

	public void setMemberlist(ArrayList<memberDTO> memberlist) {
		this.memberlist = memberlist;
	}

	public static memberDAO getInstance() {
		return instance;
	}

	public static void setInstance(memberDAO instance) {
		memberDAO.instance = instance;
	}

//	public int insertFile(memberDTO dto) {
//		int applyResult = 0;
//		
//		try {
//			String query = "INSERT INTO myfile(idx, name, title, cate, ofile, sfile) VALUES(seq_board_num.nextval, ?, ?, ?, ?, ?)";
//			
//			psmt = con.prepareStatement(query);
//			psmt.setString(1, dto.getName());
//			psmt.setString(2, dto.getTitle());
//			psmt.setString(3, dto.getCate());
//			psmt.setString(4, dto.getOfile());
//			psmt.setString(5, dto.getSfile());
//			
//			applyResult = psmt.executeUpdate();
//		} catch (Exception e) {
//			System.out.println("insertFile 예외발생" + e);
//		}
//		
//		return applyResult;
//	}
}
