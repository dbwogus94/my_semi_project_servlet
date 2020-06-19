package member.mentee.food.biz;

import java.util.List;

import member.mentee.dayMenu.dto.DayMenuDto;
import member.mentee.food.dao.FoodDao;
import member.mentee.food.dao.FoodDaoImpl;
import member.mentee.food.dto.FoodDto;

public class FoodBizImpl implements FoodBiz{

	FoodDao dao = new FoodDaoImpl();
	
	@Override
	public List<FoodDto> selectList_food() {
		return dao.selectList_food();
	}
	
	@Override
	public List<String> selectList_foodName() {
		// TODO Auto-generated method stub
		return dao.selectList_foodName();
	}

	@Override
	public FoodDto selectOne_food(String foodName) {
		return dao.selectOne_food(foodName);
	}

	@Override
	public int insert_food(FoodDto fooddto) {
		return dao.insert_food(fooddto);
	}

}
