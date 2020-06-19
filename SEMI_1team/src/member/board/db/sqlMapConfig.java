package member.board.db;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class sqlMapConfig { 
	private static SqlSessionFactory sqlSessionFactory; // 싱글톤으로 사용
	
	static {
		String resource = "member/board/db/board-config.xml";
		Reader reader = null;
		
		try {
			reader = Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 싱글톤 패턴으로 만들어진 SqlSessionFactory을 부르는대 사용되는 메서드(getter)
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}
