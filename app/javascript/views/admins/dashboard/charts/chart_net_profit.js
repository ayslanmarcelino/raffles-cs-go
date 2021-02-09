var labels = $('#valuesNetProfit').data('labels')
var values = $('#valuesNetProfit').data('values')
var ctx = document.getElementById('chartNetProfit');

var chartNetProfit = new Chart(ctx, {
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

export { chartNetProfit };
