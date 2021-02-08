var labels = $('#values').data('labels')
var values = $('#values').data('values')
var ctx = document.getElementById('chartTransactions');

var chartTransactions = new Chart(ctx, {
  type: 'line',
  data: {
    labels: labels,
    datasets: [{
      data: values,
      backgroundColor: "rgba(0,0,0,0)",
      borderColor: "#dddfeb",
      pointBackgroundColor: "#28a745",
      pointBorderColor: "#28a745",
      pointHoverBackgroundColor: "#28a745",
      pointHoverBorderColor: "#28a745",
    }]
  },
  options: {
    legend: {
      display: false
    },
    tooltips: {
      callbacks: {
        label: function(t) {
          var yLabel = 'R$ ' + t.yLabel.toFixed(2);
          return yLabel;
        }
      }
    }
  }
});

export { chartTransactions };
