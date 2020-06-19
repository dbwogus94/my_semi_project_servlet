package member.mentee.dayMenu.biz;

import java.util.List;

import All.statics.join.menuFood.dto.menuFoodDto;
import member.mentee.dayMenu.dto.DayMenuDto;
import net.sf.json.JSONArray;

public interface DayMenuBiz {
	// 달력 기록 표시 (버튼)
	public List<DayMenuDto> getCalViewList(String id, String yyyyMM);

	// 해당 날짜 먹은 메뉴 가져오기
	public List<menuFoodDto> selectList(String menuDate);

	public List<menuFoodDto> selectMorning(String menuDate);

	public List<menuFoodDto> selectLunch(String menuDate);

	public List<menuFoodDto> selectEven(String menuDate);

	public List<menuFoodDto> selectSnack(String menuDate);

	// 총 섭취 칼로리 차트 (기본 : 7일, 선택 : 1개월, 3개월, 6개월)
	public JSONArray getCalorieChartView(String id);

	public JSONArray getCalorieChartViewM(String id, int month);

	// 오늘 섭취 칼로리 차트
	public double getTodayCal(String id, String menuDate);

	// 오늘 영양소 섭취 비율 차트
	public JSONArray getNutrientChartView(String id, String menuDate);

	// 식단기록 삭제
	public int deleteMenu(String menuDate);

	public int deleteOneMenu(DayMenuDto menuDto);

	// 메뉴 입력
	public int insertDayMenu(DayMenuDto menuDto);
}
