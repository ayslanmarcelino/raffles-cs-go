var labels = $('#values').data('labels')
var values = $('#values').data('values')
var count_labels = labels.length

var colors = function(count_labels){
  var array_colors = []
  for (let index = 0; index < count_labels; index++) {
    array_colors.push(get_random_color())
  }
  return array_colors;
}

var get_random_color = function(){
  const letters = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

var ctx = document.getElementById('chartTransactions');

var chartTransactions = new Chart(ctx, {
  type: 'line',
  data: {
    labels: labels,
    datasets: [{
      data: values,
      backgroundColor: "rgba(0,0,0,0)",
      borderColor: "#bae755",
      pointBackgroundColor: "#55bae7",
      pointBorderColor: "#55bae7",
      pointHoverBackgroundColor: "#55bae7",
      pointHoverBorderColor: "#55bae7",
    }]
  },
  options: { 
    plugins: {
      labels: {
        render: () => {}
      }
    },
    legend: {
      display: false
    }
  }
});

var labels = $('#valuesPie').data('labels')
var values = $('#valuesPie').data('values')
var count_labels = labels.length

var ctx = document.getElementById('myChart');

var myChart = new Chart(ctx, {
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
