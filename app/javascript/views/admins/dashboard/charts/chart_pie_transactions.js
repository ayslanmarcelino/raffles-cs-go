import { colors } from './../../../random_color'

var labels = $('#valuesPie').data('labels')
var values = $('#valuesPie').data('values')
var count_labels = labels.length

var ctx = document.getElementById('chartPieTransactions');

var chartPieTransactions = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: labels,
    datasets: [{
      data: values,
        backgroundColor: colors(count_labels),
    }]
  },
  options: {
    plugins: {
      labels: [
        {
          render: 'label',
          position: 'outside'
        },
        {
          render: 'percentage',
          fontColor: 'white'
        }
      ]
    },
    legend: false
  }
});

export { chartPieTransactions };
