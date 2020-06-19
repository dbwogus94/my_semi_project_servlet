package member.mentee.exercise.total.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import member.mentee.exercise.total.db.sqlMapConfig;
import member.mentee.exercise.total.dto.TotalDto;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TotalDaoImpl extends sqlMapConfig implements TotalDao {

	private String namespace = "member.mentee.exercise.total.db.Mapper.";

	@Override
	public List<TotalDto> selectList_total(String id) {
		SqlSession session = null;
		List<TotalDto> list = null;

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "selectList");
		} catch (Exception e) {
			System.out.println("[Error] total selectList_total");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return list;
	}

	@Override
	public List<TotalDto> getCalViewList(String id, String yyyyMM) {
		SqlSession session = null;
		List<TotalDto> list = null;
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("yyyyMM", yyyyMM);

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getCalViewList", data);
		} catch (Exception e) {
			System.out.println("[Error] total getCalViewList");
			e.printStackTrace();
		} finally {
			session.close();
		}

		for (TotalDto dto : list) {
			System.out.println(dto);
		}

		return list;
	}

	@Override
	public int insert_total(TotalDto dto) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.insert(namespace + "insertTotal", dto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] total insertTotal");
			e.printStackTrace();

		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int update_total(TotalDto dto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(namespace + "updateTotal", dto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] total updateTotal");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	// chart : 날짜, 체중 json 형태로 저장
	@Override
	public JSONArray getWeightChartView(String id) {
		SqlSession session = null;
		List<TotalDto> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getWeightChartView", id);
			for (TotalDto dto : list) {
				obj.put("date", dto.getTotalDate());
				obj.put("weight", Double.toString(dto.getTotalWeight()));
				if (obj != null) {
					arr.add(obj);
				}
			}
			System.out.println(arr);
		} catch (Exception e) {
			System.out.println("[Error] total getWeightChartView");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public JSONArray getExerciseChartView(String id) {
		SqlSession session = null;
		List<TotalDto> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getExerciseChartView", id);

			for (TotalDto dto : list) {
				System.out.println(dto);
				obj.put("date", dto.getTotalDate());
				obj.put("exercise", dto.getTotalCalorie());
				if (obj != null) {
					arr.add(obj);
				}
			}
		} catch (Exception e) {
			System.out.println("[Error] total getExerciseChartView");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public TotalDto getTodayTotal(String id, String totalDate) {
		SqlSession session = null;
		TotalDto dto = null;
	
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("totalDate", totalDate);
		
		try {
			session = getSqlSessionFactory().openSession();
			dto = session.selectOne(namespace + "getTodayTotal", data);
		} catch (Exception e) {
			System.out.println("[Error] total getTodayTotal");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return dto;
	}

	@Override
	public double getTodayWeight(String id, String totalDate) {
		SqlSession session = null;
		Map<String, String> map = null;
		double res = 0.0;
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("totalDate", totalDate);
		
		
		try {
			session = getSqlSessionFactory().openSession();
			map = session.selectOne(namespace + "getTodayWeight", data);
			res = Double.parseDouble(String.valueOf(map.get("TOTAL_WEIGHT")));
			System.out.println(map.toString());
		} catch (Exception e) {
			System.out.println("[Error] total getTodayWeight");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return res;
	}

	@Override
	public int delete_total(TotalDto dto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(namespace + "deleteWeight", dto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] total deleteWeight");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public JSONArray getExerciseChartViewM(String id, int month) {
		SqlSession session = null;
		List<Map<String, Double>> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("month", Integer.toString(month));

		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getExerciseChartViewM", data);

			for (Map<String, Double> map : list) {
				System.out.println(map);
				obj.put("exerDate", map.get("TOTAL_DATE"));
				obj.put("exercise", map.get("TOTAL_CALORIE"));
				if (obj != null) {
					arr.add(obj);
					System.out.println(arr.toString());
				}
				
			}
		} catch (Exception e) {
			System.out.println("[Error] total getWeightChartViewM");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public JSONArray getWeightChartViewM(String id, int month) {
		SqlSession session = null;
		List<Map<String, Double>> list = null;
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("id", id);
		data.put("month", Integer.toString(month));


		try {
			session = getSqlSessionFactory().openSession();
			list = session.selectList(namespace + "getWeightChartViewM", data);

			for (Map<String, Double> map : list) {
				System.out.println(map);
				obj.put("weightDate", map.get("TOTAL_DATE"));
				obj.put("weight", map.get("TOTAL_WEIGHT"));
				if (obj != null) {
					arr.add(obj);
				}
			}
		} catch (Exception e) {
			System.out.println("[Error] total getWeightChartViewM");
			e.printStackTrace();
		} finally {
			session.close();
		}

		return arr;
	}

	@Override
	public int deleteTimeCal(TotalDto dto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(namespace + "deleteTimeCal", dto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] total deleteTimeCal");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int insertTimeCal(TotalDto dto) {
		SqlSession session = null;
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession();
			res = session.update(namespace + "insertTimeCal", dto);
			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[Error] total insertTimeCal");
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public TotalDto selectTimeCal(TotalDto dto) {
		SqlSession session = null;
		TotalDto res = null;
		try {
			session = getSqlSessionFactory().openSession();
			res = session.selectOne(namespace + "selectTimeCal", dto);
		} catch (Exception e) {
			System.out.println("[Error] total selectTimeCal");
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

}