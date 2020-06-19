package All.statics;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.apache.coyote.Request;

import member.mentee.dayMenu.dto.DayMenuDto;
import member.mentee.exercise.plan.dto.PlanDto;
import member.mentee.exercise.total.dto.TotalDto;

public class Util {

	// Date -> String (yyyyMMdd) 형식으로 변환
	public static String isString(Date date) {
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
		return transFormat.format(date);
	}

	// 한 자리수를 두 자리수로 변환
	public static String isTwo(String date) {
		return Integer.parseInt(date) < 10 ? "0" + date : date;
	}

	// 요일을 반환
	public static String getDayOfWeek(int dayOfWeek) {
		String planDayofweek = "";
		switch (dayOfWeek) {
		case 1:
			planDayofweek = "일";
			break;
		case 2:
			planDayofweek = "월";
			break;
		case 3:
			planDayofweek = "화";
			break;
		case 4:
			planDayofweek = "수";
			break;
		case 5:
			planDayofweek = "목";
			break;
		case 6:
			planDayofweek = "금";
			break;
		case 7:
			planDayofweek = "토";
			break;
		}
		return planDayofweek;
	}
}
