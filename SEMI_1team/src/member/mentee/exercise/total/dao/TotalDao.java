package member.mentee.exercise.total.dao;
import java.util.List;

import member.mentee.exercise.total.dto.TotalDto;
import net.sf.json.JSONArray;

public interface TotalDao {
 
   // 달력 기록 표시 (버튼)
   public List<TotalDto> getCalViewList(String id, String yyyyMM);
   
   public List<TotalDto> selectList_total(String id);
   
   // 체중 기록
   public int insert_total(TotalDto dto);
   public int update_total(TotalDto dto);
   public int delete_total(TotalDto dto);
   
   // 총 체중 차트 (기본 : 7일, 선택 : 1개월, 3개월, 6개월)
   public JSONArray getWeightChartView(String id);
   public JSONArray getWeightChartViewM(String id, int month);
   
   // 총 운동 소모 칼로리 차트 (7일, 1개월, 3개월, 6개월)
   public JSONArray getExerciseChartView(String id);
   public JSONArray getExerciseChartViewM(String id, int month);
   
   // 오늘 체중 차트 (체중만)
   public double getTodayWeight(String id, String totalDate);
   
   // 오늘 운동 소모 칼로리와 시간 차트 (소모 칼로리 + 시간만)
   public TotalDto getTodayTotal(String id, String totalDate);
   
   //운동수행 소모 칼로리, 시간 삭제
   public int deleteTimeCal(TotalDto dto);
   
   //운동수행 소모 칼로리, 시간 입력
   public int insertTimeCal(TotalDto dto);
   
   //운동수행 소모 칼로리, 시간 가져오기
   public TotalDto selectTimeCal(TotalDto dto);
   
}