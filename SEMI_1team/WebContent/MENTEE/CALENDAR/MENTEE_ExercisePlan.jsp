<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운동플랜</title>
<link href="CSS/MENTEE_ExercisePlan.css" rel="stylesheet">
<script type="text/javascript"
   src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="JS/MENTEE_ExercisePlan.js"></script>
</head>
<body>
<header>
   <div id="logo"><img src="ICON/gym.png" /></div>
   <h1>운토티</h1>
   <div class="container" onclick="myFunction(this)">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
   </div>
</header><br>
<hr><h3>MENTEE MAIN</h3><hr>
 <!-- 가슴, 다리, 팔, 등, 어깨, 복근, 전신 카테고리 -->
   <div class="exercisePlan">
      <div class="selectPlan" id="select1" draggable="true" ondragstart="onDragStart(event)" >
         <h4 class="category">가슴</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>버피 테스트</option>
            <option>스로우 버피</option>
            <option>마운틴 클라이머</option>
            <option>업다운 플랭크</option>
            <option>암 워킹</option>
            <option>에어 바이크</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      
      <div class="selectPlan" id="select2" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">다리</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>스쿼트</option>
            <option>점프 스쿼트</option>
            <option>런지</option>
            <option>할로우 바디 홀드</option>
            <option>브릿지</option>
            <option>레그 컬</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      
      <div class="selectPlan" id="select3" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">팔</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>덤벨 컬</option>
            <option>덤벨 킥백</option>
            <option>벤치 딥</option>
            <option>컨센트레이션 컬</option>
            <option>오버 헤드 익스텐션</option>
            <option>라잉 트라이셉스 익스텐션</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      
      <div class="selectPlan" id="select4" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">등</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>풀업</option>
            <option>덤벨 로우</option>
            <option>밴트 오버 로우</option>
            <option>슈퍼맨 로우</option>
            <option>엔젤 업</option>
            <option>덤벨 데드리프트</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      
      <div class="selectPlan" id="select5" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">어깨</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>파이크 프레스</option>
            <option>덤벨 숄더 프레스</option>
            <option>사이드 레터럴 레이즈</option>
            <option>덤벨 벤트 오버 레이즈</option>
            <option>프론트 레터럴 레이즈</option>
            <option>밴트 오버 레   터럴 레이즈</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      
      <div class="selectPlan" id="select6" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">복근</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>윗몸 일으키기</option>
            <option>사이드 플랭크</option>
            <option>플랭크</option>
            <option>사이드 브릿지</option>
            <option>크런치</option>
            <option>바이시클 메뉴버</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      
      <div class="selectPlan" id="select7" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">전신</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>버피 테스트</option>
            <option>스로우 버피</option>
            <option>마운틴 클라이머</option>
            <option>업다운 플랭크</option>
            <option>암 워킹</option>
            <option>에어 바이크</option>
         </select>
         <select class="selectCount">
            <option>10회</option>
            <option>15회</option>
            <option>20회</option>
         </select>
      </div>
      <div class="selectPlan" id="select8" draggable="true" ondragstart="onDragStart(event)">
         <h4 class="category">유산소</h4><span class="close">&times;</span>
         <select class="selectExer">
            <option>산책</option>
            <option>조깅</option>
            <option>자전거타기(천천히)</option>
            <option>자전거타기(빠르게)</option>
            <option>스트레칭체조</option>
            <option>춤추기</option>
            <option>요가</option>
            <option>에어로빅</option>
            <option>계단 오르내리기</option>
            <option>수영(자유형)</option>
            <option>수영(접형)</option>
            <option>줄넘기</option>
         </select>
         <select class="selectTime">
            <option>30분</option>
            <option>1시간</option>
            <option>1시간 30분</option>
         </select>
      </div>   
   </div>
      
<!-- 계획창 -->
<form>
      <ul>
         <li>
            <p>월</p>
            <div class="drop" id="mon" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
                     
         </li>
         <li>
            <p>화</p>
            <div class="drop" id="tue" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
         </li>
         <li>
            <p>수</p>
            <div class="drop" id="wen" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
         </li>
         <li>
            <p>목</p>
            <div class="drop" id="thu" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
         </li>
         <li>
            <p>금</p>
            <div class="drop" id="fri" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
         </li>
         <li>
            <p>토</p>
            <div class="drop" id="sat" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
         </li>
         <li>
            <p>일</p>
            <div class="drop" id="sun" ondragover="onDragOver(event)" ondrop="onDrop(event)"></div>
         </li>
      </ul>
      
      <div>
         <input type="button" value="dd" onclick="postSend('plan.do?command=planInsert', 'post');">
      </div>
</form>
         <footer>@ 2020 all copyrights reserved by 운토티</footer>
</body>
</html>