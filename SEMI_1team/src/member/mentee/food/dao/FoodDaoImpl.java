package member.mentee.food.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import member.mentee.dayMenu.dto.DayMenuDto;
import member.mentee.food.db.sqlMapConfig;
import member.mentee.food.dto.FoodDto;



public class FoodDaoImpl extends sqlMapConfig implements FoodDao{

	String namespace = "member.mentee.food.db.Mapper.";
	@Override
	public List<FoodDto> selectList_food() {
		List<FoodDto> list = new ArrayList<FoodDto>();
		SqlSession session = null;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			list = session.selectList(namespace + "selectList_food");
		} catch (Exception e) {
			System.out.println("[ERROR] : seletList");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	
	@Override
	public List<String> selectList_foodName() {
		List<String> list = new ArrayList<String>();
		SqlSession session = null;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			list = session.selectList(namespace + "selectList_foodName");			
		} catch (Exception e) {
			System.out.println("[ERROR] : seletList_foodName");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}


	@Override
	public FoodDto selectOne_food(String foodName) {
		FoodDto foodDto = null;
		SqlSession session = null;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			foodDto = session.selectOne(namespace + "selecetOne_food"); 
		} catch (Exception e) {
			System.out.println("[ERROR] : selectOne");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return foodDto;
	}

	@Override
	public int insert_food(FoodDto fooddto) {
		// TODO Auto-generated method stub
		return 0;
	}


}
