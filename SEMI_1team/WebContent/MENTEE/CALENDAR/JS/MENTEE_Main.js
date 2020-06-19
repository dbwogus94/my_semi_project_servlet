function popupWeight(weight, date, id) {
	// MENTEE_ | WeightDetail.jsp?weight= | data
	var url = 'MENTEE_WeightDetail.jsp?weight=' + weight + '&date=' + date
			+ '&id=' + id;
	window.open(url, "", "width=300px, height=300px");
}

function popupMenu(menu, date, id) {
	var url = 'MENTEE_MenuDetail.jsp?menu=' + menu + '&date=' + date + '&id='
			+ id;
	window.open(url, "", "width=380px, height=590px");
}

function popupPlan(date) {
	var url = '../../plan.do?command=getPlanC&date=' + date;
	window.open(url, "", "width=750px, height=550px");
}

/* MENTEE_WeightInsert.jsp */
function popupInsertWeight(id) {
	var url = 'MENTEE_WeightInsert.jsp?id=' + id;
	window.open(url, "", "width=300px, height=300px");
}

function popupInsertDayMenu(id) {
	location.href = "MENTEE_DayMenuInsert.jsp?id=" + id;
}

function popupInsertPlan() {
	var url = "../../plan.do?command=getPlan";
	window.open(url, "", "width=750px, height=550px");
}

/*----------------pop up-----------*/
var year = new Date().getFullYear();
var month = new Date().getMonth() + 1;
var isTwoMonth = month < 10 ? "0" + month : month;