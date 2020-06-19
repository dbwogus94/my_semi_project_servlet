package member.mentee.dayMenu.biz;

import java.util.List;

import All.statics.join.menuFood.dto.menuFoodDto;
import member.mentee.dayMenu.dao.DayMenuDao;
import member.mentee.dayMenu.dao.DayMenuDaoImpl;
import member.mentee.dayMenu.dto.DayMenuDto;
import net.sf.json.JSONArray;

public class DayMenuBizImpl implements DayMenuBiz {

	DayMenuDao dao = new DayMenuDaoImpl();

	@Override
	public List<DayMenuDto> getCalViewList(String id, String yyyyMM) {
		// TODO Auto-generated method stub
		return dao.getCalViewList(id, yyyyMM);
	}

	@Override
	public List<menuFoodDto> selectList(String menuDate) {
		// TODO Auto-generated method stub
		return dao.selectList(menuDate);
	}

	@Override
	public List<menuFoodDto> selectMorning(String menuDate) {
		// TODO Auto-generated method stub
		return dao.selectMorning(menuDate);
	}

	@Override
	public List<menuFoodDto> selectLunch(String menuDate) {
		// TODO Auto-generated method stub
		return dao.selectLunch(menuDate);
	}

	@Override
	public List<menuFoodDto> selectEven(String menuDate) {
		// TODO Auto-generated method stub
		return dao.selectEven(menuDate);
	}

	@Override
	public List<menuFoodDto> selectSnack(String menuDate) {
		// TODO Auto-generated method stub
		return dao.selectSnack(menuDate);
	}

	@Override
	public int deleteMenu(String menuDate) {
		// TODO Auto-generated method stub
		return dao.deleteMenu(menuDate);
	}

	@Override
	public int deleteOneMenu(DayMenuDto menuDto) {
		// TODO Auto-generated method stub
		return dao.deleteOneMenu(menuDto);
	}

	@Override
	public int insertDayMenu(DayMenuDto menuDto) {
		// TODO Auto-generated method stub
		return dao.insertDayMenu(menuDto);
	}

	@Override
	public JSONArray getCalorieChartView(String id) {
		// TODO Auto-generated method stub
		return dao.getCalorieChartView(id);
	}

	@Override
	public JSONArray getCalorieChartViewM(String id, int month) {
		// TODO Auto-generated method stub
		return dao.getCalorieChartViewM(id, month);
	}

	@Override
	public double getTodayCal(String id, String menuDate) {
		// TODO Auto-generated method stub
		return dao.getTodayCal(id, menuDate);
	}

	@Override
	public JSONArray getNutrientChartView(String id, String menuDate) {
		// TODO Auto-generated method stub
		return dao.getNutrientChartView(id, menuDate);
	}
}