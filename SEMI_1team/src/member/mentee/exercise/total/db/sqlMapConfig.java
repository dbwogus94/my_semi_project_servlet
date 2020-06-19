package member.mentee.exercise.total.db;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class sqlMapConfig { 
	private static SqlSessionFactory sqlSessionFactory; // 싱글톤으로 사용
	
	/*
	 * mybatis의 설명을 확인하면 
	 * SqlSessionFactory는 애플리케이션을 실행하는 동안 존재해야만 한다.
	 * 그래서 재생성할 필요가 없으며. 해당 클래스는 여러번 다시 빌드하는것을 지양해야한다.
	 * 결과적으로 해당 SqlSessionFactory가 존재하면 좋은 스코프는 애플리케이션 스코프이며
	 * 자바에서는 이를 싱글톤 패턴을 사용하여 적용할 수 있다. 
	 * 
	 */
			
	// static 초기화 블록  >> 싱글톤 패턴에 사용된다.
	static {
		String resource = "member/mentee/exercise/total/db/total-config.xml";
		Reader reader = null;
		
		try {
			reader = Resources.getResourceAsReader(resource);
			// 해당 파일을 스트림으로 읽어온다.
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			// 읽어들어온 파일로 1.2. 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				reader.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	// 싱글톤 패턴으로 만들어진 SqlSessionFactory을 부르는대 사용되는 메서드(getter)
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}
