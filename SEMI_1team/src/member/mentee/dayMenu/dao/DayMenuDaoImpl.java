package member.mentee.dayMenu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import All.statics.join.menuFood.dto.menuFoodDto;
import member.mentee.dayMenu.db.sqlMapConfig;
import member.mentee.dayMenu.dto.DayMenuDto;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DayMenuDaoImpl extends sqlMapConfig implements DayMenuDao {
	private String namespace = "member.mentee.dayMenu.db.Mapper.";

	@Override
	public List<DayMenuDto> getCalViewList(String id, String yyyyMM) {

		SqlSession session = null;
		List<DayMenuDto> list = null;
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("yyyyMM", yyyyMM);

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getCalViewList", data);
		} catch (Exception e) {
			System.out.println("[Error] DayMenu getCalViewList");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<menuFoodDto> selectList(String menuDate) {
		SqlSession session = null;
		List<menuFoodDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "selectList", menuDate);
		} catch (Exception e) {
			System.out.println("[Error] DayMenu selectList");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<menuFoodDto> selectMorning(String menuDate) {
		SqlSession session = null;
		List<menuFoodDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "selectMorning", menuDate);
		} catch (Exception e) {
			System.out.println("[Error] DayMenu selectMorning");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<menuFoodDto> selectLunch(String menuDate) {
		SqlSession session = null;
		List<menuFoodDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "selectLunch", menuDate);
		} catch (Exception e) {
			System.out.println("[Error] DayMenu selectLunch");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<menuFoodDto> selectEven(String menuDate) {
		SqlSession session = null;
		List<menuFoodDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "selectEven", menuDate);
		} catch (Exception e) {
			System.out.println("[Error] DayMenu selectEven");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<menuFoodDto> selectSnack(String menuDate) {
		SqlSession session = null;
		List<menuFoodDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "selectSnack", menuDate);
		} catch (Exception e) {
			System.out.println("[Error] DayMenu selectSnack");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public int deleteMenu(String menuDate) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.delete(namespace + "deleteMenu", menuDate);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] DayMenu deleteMenu");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int deleteOneMenu(DayMenuDto menuDto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.delete(namespace + "deleteOneMenu", menuDto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[ERROR] DayMenu deleteMenu");
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public JSONArray getCalorieChartView(String id) {
		SqlSession session = null;
		List<Map<String, String>> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getCalorieChartView", id);

			for (Map<String, String> map : list) {
				System.out.println(map);
				obj.put("date", map.get("MENU_DATE"));
				obj.put("calorie", map.get("SUM(FOOD_CALORIE*(FOOD_GRAM*MENU_GRAM))"));
				if (obj != null) {
					arr.add(obj);
				}
			}
		} catch (Exception e) {
			System.out.println("[Error] DayMenu getCalorieChartView");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public double getTodayCal(String id, String menuDate) {
		SqlSession session = null;
		Map<String, String> map = null;
		double res = 0.0;
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("menuDate", menuDate);
		
		try {
			session = getSqlSessionFactory().openSession();
			map = session.selectOne(namespace + "getTodayCal", data);
			res = Double.parseDouble(String.valueOf(map.get("SUM(FOOD_CALORIE*(FOOD_GRAM*MENU_GRAM))")));
			System.out.println(String.valueOf(map.get("SUM(FOOD_CALORIE*(FOOD_GRAM*MENU_GRAM))")));
		} catch (Exception e) {
			System.out.println("[Error] DayMenu getTodayCal");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return res;
	}

	@Override
	public JSONArray getNutrientChartView(String id, String menuDate) {
		SqlSession session = null;
		List<Map<String, String>> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("menuDate", menuDate);

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getNutrientChartView", data);

			for (Map<String, String> map : list) {
				System.out.println(map);
				obj.put("car", map.get("SUM(FOOD_CAR*MENU_GRAM)"));
				obj.put("pro", map.get("SUM(FOOD_PRO*MENU_GRAM)"));
				obj.put("fat", map.get("SUM(FOOD_FAT*MENU_GRAM)"));
				if (obj != null) {
					arr.add(obj);
				}
			}
		} catch (Exception e) {
			System.out.println("[Error] DayMenu getNutrientChartView");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public JSONArray getCalorieChartViewM(String id, int month) {
		SqlSession session = null;
		List<Map<String, Double>> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();

		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("month", Integer.toString(month));

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getCalorieChartViewM", data);

			for (Map<String, Double> map : list) {
				System.out.println(map);
				obj.put("calDate", map.get("MENU_DATE"));
				obj.put("calorie", map.get("SUM(FOOD_CALORIE*(FOOD_GRAM*MENU_GRAM))"));
				if (obj != null) {
					arr.add(obj);
				}
			}
		} catch (Exception e) {
			System.out.println("[Error] DayMenu getCalorieChartViewM");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public int insertDayMenu(DayMenuDto menuDto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(namespace + "insertDayMenu", menuDto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] DayMenu insertTotal");
			e.printStackTrace();

		} finally {
			session.close();
		}

		return res;
	}

}