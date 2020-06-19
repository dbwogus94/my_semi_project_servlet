function deleteWeight(weight, date, id) {
   location.href = '../../total.do?command=deleteWeight&weight=' + weight + '&date=' + date + '&id=' + id;
   opener.window.location.reload();
   window.close();
}