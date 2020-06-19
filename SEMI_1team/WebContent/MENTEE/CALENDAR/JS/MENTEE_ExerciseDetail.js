function delPlan(date) {
	location.href = 'plan.do?command=deletePlanC&date='+date;
	opener.window.location.reload();
	window.close();
}