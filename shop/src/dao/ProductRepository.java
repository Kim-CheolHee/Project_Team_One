package dao;

import java.util.*;

import common.JDBConnect;
import dto.Product;

public class ProductRepository extends JDBConnect{

	private ArrayList<Product> listOfProducts = new ArrayList<Product>();
	private static ProductRepository instance = new ProductRepository();
	
	public ProductRepository(){
		String query = "SELECT * FROM product";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			while(rs.next()) {
				Product dto = new Product();
				dto.setProductId(rs.getString(1));
				dto.setPname(rs.getString(2));
				dto.setUnitPrice(rs.getInt(3));
				dto.setDescription(rs.getString(4));
				dto.setCategory(rs.getString(5));
				dto.setManufacturer(rs.getString(6));
				dto.setUnitsInStock(rs.getLong(7));
				dto.setCondition(rs.getString(8));
				dto.setFilename(rs.getString(9));
				listOfProducts.add(dto);
			}
		} catch (Exception e) {
			System.out.println("productList 예외 발생 : " + e);
		}
	}
	

	public ArrayList<Product> getAllProducts() {
		return listOfProducts;
	}

	public Product getProductById(String productId) {
		Product productById = null;
		for (int i = 0; i < listOfProducts.size(); i++) {
			Product product = listOfProducts.get(i);
			if (product.getProductId() != null && product.getProductId().equals(productId)) {
				productById = product;
				break;
			}
		}
		return productById;
	}

	public static ProductRepository getInstance() {
		return instance;
	}
	
	public int addProduct(Product product) {
		int result = 0;
		String query = "INSERT INTO product VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getPname());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFilename());
			result = psmt.executeUpdate();
			listOfProducts.add(product);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("addProduct 예외 발생 : " + e);
		}
		return result;
	}

}
